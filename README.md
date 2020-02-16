# [:cow:]: beefblup

beefblup is a program for ranchers to calculate expected breeding
values (EBVs) for their own beef cattle. It is intended to be usable by anyone
without requiring any prior knowledge of computer programming or linear algebra.
Why? It's part of my effort to
**\#KeepEPDsReal**

[:arrow_down_small:  Download beefblup](https://github.com/MillironX/beefblup/archive/master.zip)

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
7. [Download beefblup](https://github.com/MillironX/beefblup/archive/master.zip)
   and unzip it to somewhere you will remember it
8. Hold down the **Shift** key, and **right-click** in a blank space in the
   "Julia" folder of beefblup
9. Click **Open PowerShell window here"
10. Type `julia install.jl` into PowerShell and press **Enter**
11. Close PowerShell once Julia has finished

Why do you need Chocolatey? Because it allows you to access Julia (and therefore
beefblup) from the **Shift**+**Right-click** menu directly, without having to
worry about `cd` commands or editing your `%PATH%`. That's good, right?

#### Mac

1. [Download and install Julia](https://julialang.org/downloads/)
2. Open terminal.app, and run the following

```bash
curl https://github.com/MillironX/beefblup/archive/master.zip -o beefblup.zip
unzip beefblup.zip
rm beefblup.zip
```

3. Quit terminal.app
4. Open julia.app, and run the following

```julia
cd("~/beefblup/beefblup-master/Julia")
include("install.jl")
```

5. Quit julia.app

I don't know if these are right, since I can't afford a Mac. If any of you
super-privileged Apple snobs out there use beefblup, please add proper
instructions here and submit a pull request.

#### Debian/Ubuntu Linux

TODO: Add instructions here. This is slightly complicated since there is no
Julia package in the main repositories, and I don't use Debian distros enough to
know where to find a third-party repos

#### Fedora Linux (The best platform)

From a new terminal, run

```bash
sudo dnf install julia -y
wget https://github.com/MillironX/beefblup/archive/master.zip -O beefblup.zip
unzip beefblup.zip
rm beefblup.zip
cd beefblup/beefblup-master/Julia
julia install.jl
exit
```

#### Other Platforms

Seriously? If you're enough of a geek to be using something else, you can figure
this out on your own.

### How to Use

> **Note:** beefblup and [Juno](https://junolab.org)/[Julia Pro](https://juliacomputing.com/products/juliapro.html) currently don't get along.
> Although it's tempting to just open up beefblup in Juno and press the big play
> button, it won't work. Follow these instructions until it's fixed. If you
> don't know what Juno is: ignore this message.

#### All platforms

1. Download the [Excel template](https://github.com/MillironX/beefblup/raw/master/Excel/Master%20BLUP%20Worksheet.xlsx)
2. Replace the sample data in the spreadsheet with your own
3. If you wish to add more contemporary group traits to your analysis, replace
   or add them to the right of the Purple section
4. Save, and continue with your platform-specific instructions below

#### Windows

5. Remember where you downloaded beefblup to when you installed it
6. Hold down the **Shift** key, and **right-click** in a blank space in the
   "Julia" folder of beefblup
7. Click **Open PowerShell window here"
8. Type `julia beefblup.jl` into PowerShell and press **Enter**
9. Select the spreadsheet you created in Step 4
10. Follow the on-screen prompts
11. **\#KeepEPDsReal!**

#### Mac

5. Open julia.app, and run the following

```julia
cd("~/beefblup/beefblup-master/Julia")
include("beefblup.jl")
```

6. Select the spreadsheet you created in Step 4
7. Follow the on-screen prompts
8. **\#KeepEPDsReal!**

#### All Linux

5. Open a new terminal, and type

```bash
cd beefblup/beefblup-master/Julia
julia beefblup.jl
```

6. Select the spreadsheet you created in Step 4
7. Follow the on-screen prompts
8. **\#KeepEPDsReal!**

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
| v1.0    | [Finally, RELEASE!!!](https://youtu.be/1CBjxGdgC1w?t=282)           |

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

### Feature and Pull Requests

Although I doubt there will be many contributors here,

## License

Distributed under the 3-Clause BSD License
