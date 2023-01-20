#Jan2023 -- Dakotam@conceptsnet.com
try {
    $Version = 1.0.0
    $remoteScript = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Pixelbays/Repairshopr-Inventory-tool/main/1-Inventory.ps1" -UseBasicParsing).Content
    $RemoteVersion = ($remoteScript -split '\$version = "')[1].split('"')[0]
    if($localVersion -ne $RemoteVersion){
        $UpdateRequest = Read-Host "Current Version $Version is out date! Would you like to update? y/n"
        $BackupRequest = Read-Host "Would you like to backup the current script? y/n"
        if ($BackupRequest -eq "y") {
            #renames the current script file to 
            Rename-Item -Path ".\1-inventory.ps1" -NewName "1-inventory-backup.ps1" -Force
        }
        if ($UpdateRequest -eq "y") {
            # download the new version if the version is different
            (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Pixelbays/Repairshopr-Inventory-tool/main/1-Inventory.ps1" -UseBasicParsing).Content | Out-File "C:\path\to\local\script.ps1"
        }
    }
    if($localVersion -eq $RemoteVersion){
        Write-Output "Current Version $Version is up to date."
    }
}
catch {
    Write-Output "Unable to check for update. Current Version $Version"
}
#These Vars are editable if you need to change the subdomain or API. To change them go to the varibles.xml and change the data there. hoping to have this editable in the script using c
#First time setup. Checks if the variables.xml is real. if fails, Asks the user questions about their shopr and saves them to an external file.
try {
    $CFiles = Import-Clixml -Path .\variables.xml
} catch {
    Write-Output "Hello! Welcome to the PowerShell Repairshopr API Inventory tool!"
    Write-Output "I'll ask a couple of questions, save them Locally in a file called variables.ps1."
    Write-Output "This way I dont know them, and you don't know mine!"
    Write-Output "keep varibles.xml in the same folder as the main script otherwise it wont work, and will be talking again."
    Write-Output $Spacer
    $CFiles = [pscustomobject]@{
        CName = Read-Host "What is your Company Name?"
        SubDom = Read-Host "What is the sub domain you have at repairshopr? Example '*****.repairshopr.com'"
        APIKey = Read-Host "What is the API key you have made for this? Make sure it has ONLY The following permissions List/search, Edit, ViewCost"
    }
    $CFiles | Export-Clixml -Path .\variables.xml
    $CFiles = Import-Clixml -Path .\variables.xml
}
#These Vars setup the whole Script Please don't edit
$APIKey = $CFiles.APIKey
$SubDom = $CFiles.SubDom
$CName = $CFiles.CName 
#gets the date and changes to the formate yyMMdd so that we can use that for sort order 
$DateString = (Get-Date -UFormat %y%m%d)
#setup the vars for the API requests
$postheaders = @{Authorization = "Bearer $APIKey"
"Accept" = "application/json"}
$contenttype = "application/json"
#This Var is to use for the if statments to ignore when a cmd has been typed
$IgnoredInputs = "n", "c", "s", "o", "help", "export"
#format spacer reused so i dont have to copy and paste the same bit or count. Lazness pays off now. 
$Spacer = "_______________"
#This var is for the product IDs to get saved when needed.
$SavedList = @()
#creates the UPC var for later use
$UPC = ""
#this is a var to check if the user has selected that repair shopr has been opened and logged into. 
$Signedin = ""
#the request user input saying so i dont have to copy and paste the same bit or count. Lazness pays off now.
$CSay = "Type/Scan a UPC or a valid command. Type help if needed"
#this is the var that is setup for logs, and finally some user input!
$ELogs = [Ordered]@{
    Company = $CName
    Name = Read-Host "What is your Name?"
    Date = (Get-Date -Format "yyyy-MM-dd@HH.mm")
    NumProdScanned = 0
    NumProdSaved = 0
    UPCsNotFound = 0
    ScannedProds = @()
    SavedProdID = @()
}
#start of main
$Continue = Read-Host "$CSay"
#once the user has been inputed it is checked if it matches any of the coded commands. if not a command runs it as a UPC check.
do {
    if ($Continue -notin $IgnoredInputs) {
        #changes the UPC var to the user input.
        $UPC = $Continue
        #requests the API for the Prod using the given UPC. If nothing is found with that UPC, it will tell you. 
        $Request = Invoke-WebRequest -Uri "https://$SubDom.repairshopr.com/api/v1/products?upc_code=$UPC" -ContentType $contenttype -Headers $postheaders
        #converts it to poowershell vars from jason
        $Response = $Request.Content | ConvertFrom-Json
        #if the server reponded we start to get the info we need and displays it.
        if (($Response.products).count -ne 0) {
            #Making vars for the things we care about from the reponse from the API.
            $ProdName = $Response.products[0].name
            $Quantity = $Response.products[0].quantity
            $Price = $Response.products[0].price_retail
            $ProdID = $Response.products[0].id
            $PriceCost = $Response.products[0].price_cost
            $SortOrder = $Response.products[0].sort_order
            $Serialized = $Response.products[0].serialized
            #Prints those vars out to the user. So that they can double check what they see matches.
            Write-Output $Spacer
            Write-Host "ProdID: $ProdID"
            Write-Host "Product Name: $ProdName"
            Write-Host "Cost: $PriceCost"
            Write-Host "Price: $Price"
            Write-Host "Quantity: $Quantity"
            Write-Host "Last Scanned Date: $SortOrder"
            #if the devices is serialized it runs that as a API request then outputs the S/Ns 
            if ($Serialized -eq "True"){
                Write-Output $Spacer
                Write-Output "This Product is serialized here are the S/N that are known and labeled in stock"
                Write-Output $Spacer
                $RequestSN = Invoke-WebRequest -Uri "https://$SubDom.repairshopr.com/api/v1/products/$ProdID/product_serials" -ContentType $contenttype -Headers $postheaders
                $ResponseSN = $RequestSN.Content | ConvertFrom-Json
                $ResponseSN.product_serials | ForEach-Object {Write-Output $_.serial_number}
            }
            Write-Output $Spacer
            #adding to logs var for those who want to export the data 
            $ELogs.ScannedProds += @("https://$SubDom.repairshopr.com/products/$ProdID/edit")
            $ELogs.NumProdScanned += 1
            #creates the var to update the sort order to the date that the user is scanning
            $body = @{"sort_order" ="$DateString";}
            #converts back to json then pushes that date change to the API using the sort order field
            $jsonBody = $body | ConvertTo-Json
            Invoke-RestMethod -Method PUT -Uri "https://$SubDom.repairshopr.com/api/v1/products/$ProdID" -ContentType $contenttype -Headers $postheaders -Body $jsonBody | Out-Null
        }if (!$Response.products -and $Response.meta.total_entries -eq 0) {
            $ELogs.UPCsNotFound += 1
            Write-Output $Spacer
            Write-Host "UPC not found"
            Write-Output $Spacer
         }
    
    }
    if ($Continue -eq "c"){
        #This is under dev... This is wil be for changes if we want to add this, Just added the framework for the command.
        Write-Output $Spacer
        Write-Output "what do you want to change? Trick Question, nothing can be from here!"
        Write-Output $Spacer
    }
    if ($Continue -eq "s"){
        #This area is to save the prod in question to a var so that its logged and can be opened later
        $SavedList += $ProdID
        $SavedCount = $SavedList.Count
        $ELogs.SavedProdID += @("https://$SubDom.repairshopr.com/products/$ProdID/edit")
        $ELogs.NumProdSaved += 1
        #informs the user how many items they have saved.
        Write-Output $Spacer
        Write-Output "You have Saved a total of $SavedCount Products to look at for review"
        Write-Output $Spacer
    }
    if ($Continue -eq "o"){
        #This area is to open the products in question on the systems default browser, please make sure you already signed in otherwise it will only open sign in windows
        Write-Output $Spacer
        #checks if user has already done this before and typed yes if anything but y will ask again 
        if ($Signedin -ne "y") {
            Write-Output $Spacer
            $Signedin = Read-Host "Is repairshopr open and signed in? Please make sure. y/n"
            Write-Output $Spacer
        }
        #if yes opens the items that have been saved
        if ($Signedin -eq "y"){
            foreach ($item in $SavedList) {
                Start-Process "https://$SubDom.repairshopr.com/products/$item/edit"
            }
            Write-Output $Spacer
            Write-Output "You have opened $SavedCount links in your default browser, hope you were signed in."
            Write-Output $Spacer
        }elseif ($Signedin -eq "n") {
            #if user said no opens repairshopr
            Write-Output $Spacer
            Write-Output "Please Make sure you have repairshopr opened and signed in before trying to export, Here I'll Open it for you."
            Start-Process "https://$SubDom.repairshopr.com/"
            Write-Output $Spacer
        }
    }
    if ($Continue -eq "help"){
        #This area is to inform what this tool can do.
        Write-Output $Spacer
        Write-Output "Hello and welcome to $CName PowerShell Repairshopr Inventory Tool! "
        Write-Output $Spacer
        Write-Output "Using this tool we are able to quickly get zones of inventory checked out without using the slow website."
        Write-Output "Anything saved will be lost once the script is closed. If you have saved Products to look at later using 's' make sure to open them using 'o' before closing the script."
        Write-Output "While using this tool, if the qty in front of you does not match up with the qty shown, please find out why."
        Write-Output "Need to save it? you can export the data you've taken"
        Write-Output "The Date format is yyMMdd. This is so it plays nicer with the Sort Order on the website. Since that that is the column we are high jacking for the scanned date."
        Write-Output "Type 'cmds' to get the list of valid commands"
        Write-Output "'credits' - Typing credits will bring up credits of this script"
        Write-Output $Spacer 
    }
    if ($Continue -eq "cmds"){
        #this is the area for what cmds are ready for the user to use
        Write-Output $Spacer
        Write-Output "Here are valid commands that you can do with this tool."
        Write-Output "Scanning/Typing the UPC on a Product using a scanner will bring up the Product ID, Name, Retailed Price, Expected Qty, and last scanned date."
        Write-Output "'s' - Typing S will save the current product ID that you last scanned to a list that you can open at a later time to evaluate it on the website."
        Write-Output "'o' - Typing O will open the saved products to their product page in repairshopr, Make sure you are already signed in or it will just open a lot of sign in pages."
        Write-Output "'n' - Typing N will close the script out."
        Write-Output "'export'- Typing export will export a json file with usefull info. like who, date, links what products were scanned, saved, total amount of scanned/saved."
        Write-Output $Spacer
    }
    if ($Continue -eq "export"){
        #Exporting the data
        $SaveName = $Elogs.Name + "-" + $Elogs.Date
        # Convert the hashtable to a JSON object
        $ELogsJSON = $ELogs | ConvertTo-Json
        # Convert the JSON object to a CSV file
        $ELogsJSON | Out-File -FilePath ".\logs\$SaveName.json"
        #$ELogs | Export-Csv -Path ".\$SaveName.csv" -NoTypeInformation
        #letting the user know
        Write-Output $Spacer
        Write-Output "The Data should have been exported to a file called $SaveName.json in the same location as the script"
        Write-Output $Spacer
    }    
    #Asks for another UPC or to stop
    $Continue = Read-Host -Prompt "$CSay"
    #keeping the loop going while user hasnt put n in the prompt
} while ($Continue -ne "n")