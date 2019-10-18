# beefblup

:cow: :cow: :cow:

#### \#KeepEPDsReal

MATLAB and Python scripts and Excel spreadsheets that can be used in conjunction to find breeding values for beef cattle.

## How to Use

1. Download the [Excel template](https://github.com/MillironX/beefblup/raw/master/Excel/Master%20BLUP%20Worksheet.xlsx)
2. Place your data into the structure described by the spreadsheet
3. If you wish to add more contemporary group traits to your analysis, replace or add them to the right of the Purple section
4. Download the entire `MATLAB` folder, and set it as your current MATLAB directory
5. Run `beefblup.m`
6. Select the spreadsheet file you just placed your data into
7. Select a file that you would like to save your results to
8. Breeding values and contemporary group adjustments will be outputted to the file you selected

## Contributing

I will gladly accept pull requests that acomplish any of the following:

* Convert MATLAB scripts to Python
    * The product must be able to be run from the native (non-python) terminal using only the default [Anaconda Python packages](https://anaconda.com/distribution)
* Optimizing code sections
    * Use triagonal shortcuts to generate the additive relationship matrix
    * Solve implicit forms of the mixed-model equation
    * Perform cannonical transformations for missing values
    * Other similar improvements that I might not be aware of
* Creation of scripts to handle additional forms of BLUP
    * Mult-trait (MBLUP)
    * Maternal-trait
    * Genomic-enhanced (GBLUP) - this will require the creation of a standard SNP spreadsheet format
* Creation of spreadsheets for additional traits
* Creation of wiki pages to explain what each script does
    * The general rule is that **every** wiki page should be understandable to anyone who's passed high school algebra, while still being correct and informative
    


Note that I intend to implement all of the items above eventually, but progress is slow since I'm learning as I go.

If you are writing code, please keep the code clean:

* Run "Smart Indent" in the MATLAB editor on the entire file before checking it in
* Name variables in full word English using all lowercase, unless the matrix name is generally agreed upon in academic papers (i.e. A is the additive relationship matrix)
* For MATLAB, functions go in a separate file
* Comments go before a code block: no inline comments

Bug reports and suggestions will be gladly taken on the [issues](https://github.com/MillironX/beefblup/issues) page. There is no set format for issues, yet, but please at the minimum attach a filled-out spreadsheet that demonstrates your bug or how your suggestion would be useful.

## License

Distributed under the 3-Clause BSD License
