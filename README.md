# PS-Inventory-ReapairShopr-Tool
> Quick inventory tool for repairshopr that uses powershell.

Personally at our shop we have issues with inventory. I've built this tool in powershell so that we can quickly scan the UPC of a Product in inventory. Save products that are wrong, open them all later to review them, and export logs.
![](header.png)

## Installation

Anything that can run powershell with admin rights:
Download the zip or clone this repository  
Right click 1-Inventory.ps1 and click run with powershell
If you haven't allowed scripts for powershell before it will ask if you want to enable scripts.  
you will have 6 options to pick from, which one you pick depends on you. if you want to run just this tool type y if you run lots of tools and know what you are doing type A. 
```
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"):
```
If you select A. PLEASE make sure to understand what you are doing and to read scripts before running them. 

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

Describe how to install all development dependencies and how to run an automated test-suite of some kind. Potentially do this for multiple platforms.

```sh
make install
npm test
```

## Release History

* 0.2.1
    * CHANGE: Update docs (module code remains unchanged)
* 0.2.0
    * CHANGE: Remove `setDefaultXYZ()`
    * ADD: Add `init()`
* 0.1.1
    * FIX: Crash when calling `baz()` (Thanks @GenerousContributorName!)
* 0.1.0
    * The first proper release
    * CHANGE: Rename `foo()` to `bar()`
* 0.0.1
    * Work in progress

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

<!-- Markdown link & img dfn's -->
[npm-image]: https://img.shields.io/npm/v/datadog-metrics.svg?style=flat-square
[npm-url]: https://npmjs.org/package/datadog-metrics
[npm-downloads]: https://img.shields.io/npm/dm/datadog-metrics.svg?style=flat-square
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[wiki]: https://github.com/yourname/yourproject/wiki
