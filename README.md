# beefblup

MATLAB and Python scripts and Excel spreadsheets that can be used in conjunction to find breeding values for beef cattle.

## How to Use

*Notice: this project is currently in development, these instuctions are to guide development efforts toward an intended operation procedure*

1. Choose a spreadsheet appropriate to the trait you want to analyse from the `Excel` folder, and save it to your hard drive
2. Place your data into the structure described by the spreadsheet
3. If you wish to add more contemporary group traits to your analysis, add them into or directly after the Purple section
4. Download the entire `MATLAB` folder, and set it as your current MATLAB directory
5. Run `beefblup.m`
6. Select the spreadsheet file you just placed your data into
7. Select a file that you would like to save your results to
8. Breeding values and contemporary group adjustments will be outputted to the file you selected

## Contributing

I will not accept any contributions while writing the initial MATLAB script. Once that is finished, I will gladly take input on the following:

* Converting MATLAB scripts to Python
* Optimizing code sections
* Adding spreadsheets for additional traits
* Bug reports, usability issues, etc.

If you are writing code, please keep the code clean by:

* Indenting using the native editor's formating
* Naming variables in full word English using camelCase, unless the matrix name is generally agreed upon in papers (i.e. A is the additive relationship matrix)
* For MATLAB, functions go in a separate file
* Comments go before a code block: no inline comments

## License

Distributed under the 3-Clause BSD License