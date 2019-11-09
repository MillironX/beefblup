# beefblup install
# Prepares the Julia environment for using beefblup by installing the requisite
# packages
# Usage: julia install.jl
# (C) 2019 Thomas A. Christensen II
# Licensed under BSD-3-Clause License

# Import the package manager
using Pkg

# Install requisite packages
Pkg.add("XLSX")