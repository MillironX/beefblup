# [:cow:]: beefblup

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://millironx.github.io/beefblup/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://MillironX.github.io/beefblup/dev)
[![Build Status](https://travis-ci.com/millironx/beefblup.svg?branch=master)](https://travis-ci.com/millironx/beefblup)
[![Coverage](https://codecov.io/gh/millironx/beefblup/branch/master/graph/badge.svg)](https://codecov.io/gh/millironx/beefblup)
[![Code Style: Blue](https://img.shields.io/badge/code%20style-blue-4495d1.svg)](https://github.com/invenia/BlueStyle)
[![GitHub license](https://img.shields.io/github/license/MillironX/beefblup)](https://github.com/MillironX/beefblup/blob/master/LICENSE.md)
[![Join the chat at https://gitter.im/beefblup/community](https://badges.gitter.im/beefblup/community.svg)](https://gitter.im/beefblup/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Github all releases](https://img.shields.io/github/downloads/MillironX/beefblup/total.svg)](https://GitHub.com/MillironX/beefblup/releases)

beefblup is a program for ranchers to calculate expected breeding
values (EBVs) for their own beef cattle. It is intended to be usable by anyone
without requiring any prior knowledge of computer programming or linear algebra.
Why? It's part of my effort to
**\#KeepEPDsReal**

## Installation

1. [Download and install Julia](https://julialang.org/downloads/platform/)
2. Download the [beefblup ZIP
   file](https://github.com/MillironX/beefblup/archive/refs/tags/v0.2.zip) and unzip it   someplace memorable
3. In your file explorer, copy the address of the "beefblup" folder
4. Launch Julia
5. Type `cd("<the address copied in step 5")` and press **Enter** (For example,
   `cd("C:\Users\MillironX\Documents\beefblup")`)
6. Type the `]` key
7. Type `activate .` and press **Enter**
8. Type `instantiate` and press **Enter**
9. Installation is done: you can close the Julia window

## How to Use

1. Make a copy of the "sample.csv" spreadsheet and replace the data with your own
   1. The trait you wish to calculate EBVs for always goes in the rightmost column
   2. If you wish to add more contemporary group traits to your analysis, include them before the rightmost column
2. Save and close
3. In your file explorer, copy the address of the "beefblup" folder
4. Launch Julia
5. Type `cd("<the address copied in step 5")` and press **Enter** (For example,
   `cd("C:\Users\MillironX\Documents\beefblup")`)
6. Type the `]` key
7. Type `activate .` and press **Enter**
8. Press **Backspace**
9. Type `include("src/beefblup.jl")` and press **Enter**
10. Select the spreadsheet you created in steps 1-4
11. Follow the on-screen prompts
12. **#KeepEPDsReal!**

## For Programmers

> **Also Note:** beefblup was written on, and has only been tested with Julia
> v1.2.0 and higher. While this shouldn't affect most everyday users, it might
> affect you if you are stuck on the current LTS version of Julia (v1.0.5).

### Development Roadmap

| Version | Feature                                                                             | Status             |
| ------- | ----------------------------------------------------------------------------------- | ------------------ |
| v0.1    | Julia port of original MATLAB script                                                | :heavy_check_mark: |
| v0.2    | Spreadsheet format redesign                                                         | :heavy_check_mark: |
| v0.3    | API rewrite (change to function calls and package format instead of script running) |                    |
| v0.4    | Add GUI for all options                                                             |                    |
| v0.5    | Automatically calculated Age-Of-Dam, Year, and Season fixed-effects                 |                    |
| v0.6    | Repeated measurement BLUP (aka dairyblup)                                           |                    |
| v0.7    | Multiple trait BLUP                                                                 |                    |
| v0.8    | Maternal effects BLUP                                                               |                    |
| v0.9    | Genomic BLUP                                                                        |                    |
| v0.10   | beefblup binaries                                                                   |                    |
| v1.0    | [Finally, RELEASE!!!](https://youtu.be/1CBjxGdgC1w?t=282)                           |                    |

### Bug Reports

For every bug report, please include at least the following:

- Platform (Windows, Mac, Fedora, etc)
- Julia version
- beefblup version
- How you are running Julia (From PowerShell, via the REPL, etc.)
- A beefblup spreadsheet that can be used to recreate the issue
- Description of the problem
- Expected behavior
- A screenshot and/or REPL printout

## License

Distributed under the 3-Clause BSD License
