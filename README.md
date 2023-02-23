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

I used VScode for my IDE atm, loved Atom for the longest time but they are retiring it. Looking for others like atom.

## Release History

I'll Add Soon™


## Road Map 

This is mainly a test run to get the tool working asap. There will be a full rewrite later to make the tool be written better as of right now Its just if's in a do loop... 
Please don't hate. It was written in haste with upset managers about inventory being wrong again.

In terms of features the tool provides I think its pretty set for what we want it todo. If you want to add any please let me know on here.

## Other Repairshopr Projects

Not all my Repairshopr projects will work for everyone. That being said all my tools I release here are open sourced and are "attempted" to be configured in a way to be used by others. This tool is setup the best for it. feel free to take a look and see what is going on. 

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request


## Meta

Dakota – dakmessier@pixelbays.com
go play some games you have been working awefully hard. <3

