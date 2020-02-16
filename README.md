# [:cow:]: beefblup

beefblup is an easy-to-use program for ranchers to calculate expected breeding
values (EBVs) for their own beef cattle. Why? It's part of my effort to
**\#KeepEPDsReal**

> **Notice:** beefblup for MATLAB and beefblup for Python are going away. I'm
> going to make changes here soon that will break the MATLAB version of
> beefblup, and I don't intend to update it anymore. (How many ranchers do you
> know that can afford MATLAB?) As for beefblup for Python, it never really got
> off the ground, and beefblup for Julia has superceded it.

## For Users

### Installation

#### Windows (My Platform)

1. Press the **Windows Key** + **X**, and then press **A**, and select **Yes**
2. [Install Chocolatey](https://chocolatey.org/install) using the PowerShell
   window that opened
3. Close PowerShell
4. Press the **Windows Key** + **X**, and then press **A**, and select **Yes**
   (Again)
5. Type `choco install Julia -y` into PowerShell and press **Enter**
6. Close PowerShell once Chocolatey has finished
7. Download and unzip beefblup to somewhere you will remember it
8. Hold down the **Shift** key, and **right-click** in a blank space in the
   "Julia" folder of beefblup
9. Click **Open PowerShell window here"
10. Type `julia install.jl` into PowerShell and press **Enter**
11. Close PowerShell once Julia has finished

Why do you need Chocolatey? Because it allows you to access Julia (and therefore
beefblup) from the **Shift**+**Right-click** menu directly, without having to
worry about `cd` commands or editing your `%PATH%`. That's good, right?

#### Mac

I don't know. I can't afford one. If any of you super-privileged Apple snobs
out there run beefblup, please add proper instructions here and submit a pull
request.

#### Debian/Ubuntu Linux

TODO: Add instructions here. This is slightly complicated since there is no
Julia package in the main repositories, and I don't use Debian distros enough to
know where to find a third-party repos

#### Fedora Linux

TODO: Add instructions here. I have this info, but it's on the work computer.

## How to Use

1. Choose a spreadsheet appropriate to the trait you want to analyze from the `Excel` folder, and save it to your hard drive
2. Place your data into the structure described by the spreadsheet
3. If you wish to add more contemporary group traits to your analysis, replace or add them to the right of the Purple section
4. Open MATLAB
5. Enter the following lines in the command window:

    ```
    websave('beefblup.zip','https://github.com/MillironX/beefblup/archive/master.zip');
    unzip('beefblup.zip');
    cd beefblup-master/MATLAB
    beefblup
    ```

6. Select the spreadsheet file you just placed your data into
7. Select a file that you would like to save your results to
8. Breeding values and contemporary group adjustments will be outputted to the file you selected

## For Programmers

### Development Roadmap

| Version | Feature                                                             |
| ------- | ------------------------------------------------------------------- |
| v0.1    | Julia port of original MATLAB script                                |
| v0.2    | Spreadsheet format redesign                                         |
| v0.3    | API rewrite (change to function calls instead of script running)    |
| v0.4    | Add GUI for all options                                             |
| v0.5    | Automatically calculated Age-Of-Dam, Year, and Season fixed-effects |
| v0.6    | Repeated measurement BLUP (aka dairyblup)                           |
| v0.7    | Multiple trait BLUP                                                 |
| v0.8    | Maternal effects BLUP                                               |
| v0.9    | Genomic BLUP                                                        |
| v0.10   | beefblup binaries                                                   |
| v1.0    | [Finally, RELEASE!!!](https://youtu.be/Zd-up5EgoMw?t=5049)                                                                    |

I will gladly take input on the following:

* Converting MATLAB scripts to Python
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

## License

Distributed under the 3-Clause BSD License
