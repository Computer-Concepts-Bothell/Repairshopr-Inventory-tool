# PS-Inventory-ReapairShopr-Tool
> Quick inventory tool for repairshopr that uses powershell.

Personally at our shop we have issues with inventory. I've built this tool in powershell so that we can quickly scan the UPC of a Product in inventory. Save products that are wrong, open them all later to review them, and export logs.

## Installation

Anything that can run powershell with admin rights:
Download the zip or clone this repository  
Right click 1-Inventory.ps1 and click run with powershell
If you haven't allowed scripts for powershell before it will ask if you want to enable scripts.  
you will have 6 options to pick from, which one you pick depends on you. if you want to run just this tool type y if you run lots of tools and know what you are doing type A. 
```
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):
```
If you select A. PLEASE make sure to understand what you are doing and to read ANY AND ALL scripts before running them. 

## Usage example

# First time setup
First you will want to create an API key for repairshopr Make sure it has ONLY The following permissions List/search, Edit, ViewCost. Any other permission are not needed for this tool.
If you haven't run the tool before it will go through a first time setup. Asking for some key info to let the tool work with your repairshopr. 
```
Company Name:
Sub Domain: 
API Key:
```



## Development setup

I used VScode for my IDE atm, loved Atom for the longest time but they are retiring it. Looking for others like atom. Other that use w/e you want to change code to fit you best.

## Release History
<details>
<summary>1.7</summary>
<br>
revamped the update checker
added more comments and made things more readable 
</details>
<details>
<summary>1.6</summary>
<br>
Added Text to Voice to the script that will auto read out the qty of products scanned
Fixed error in UPC not found
</details>

<details>
<summary>1.5 </summary>
<br>
Added command to open the last thing scanned instead of saving it then opening it later 
</details>
<details>
<summary>1.4</summary>
<br>
Skipped a few versions 
Added the start of being able to change the saved varible within the tool itself. 
added the reload script cmd 
added proper readme not properly filled out though
added a work around for API bug.
</details>
<details>
<summary>1.0</summary>
<br>
Polished the basic tool
added an update checker at the start of the script
added logs to export 
</details>
<details>
<summary>0.1 initial release.</summary>
<br>
Basic form of the tool. can ask API with UPC and get some details back. 
</details>




## Road Map 

This is mainly a test run to get the tool working asap. There will be a full rewrite later to make the tool be written better as of right now Its just if's in a big loop... 
Please don't hate. It was written in haste with upset managers about inventory being wrong again.

In terms of features the tool provides I think its pretty set for what we want it todo. If you want to add any please let me know on here.

need to add more settings that can be changed the in the tool. namely I need to add voice settings to the user change able settings.

## Other Repairshopr Projects

Not all my Repairshopr projects will work for everyone. That being said all my tools I release here are open sourced and are "attempted" to be configured in a way to be used by others. This tool is setup the best for it at the moment. feel free to take a look and see what is going on. 

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request


## Meta

Dakota – dakmessier@pixelbays.com
go play some games you have been working awefully hard. <3

