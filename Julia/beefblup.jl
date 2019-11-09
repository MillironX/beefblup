# beefblup
# Main script for performing single-variate BLUP to find beef cattle
# breeding values
# Usage: julia beefblup.jl
# (C) 2019 Thomas A. Christensen II
# Licensed under BSD-3-Clause License

# Import the required packages
using XLSX

# Display stuff
print("beefblup v 0.0.0.1\n")
print("(C) 2019 Thomas A. Christensen II\n")
print("https://github.com/millironx/beefblup\n")
print("\n")

### Prompt User
# Ask for an input spreadsheet
print("Enter the full filename of a beefblup worksheet> ")
path = readline(stdin)

# Ask for an output text filename
print("Enter the full filename of your desired results> ")
savepath = readline(stdin)

# Ask for heritability
print("What is the heritability for this trait?> ")
h2 = parse(Float64, readline(stdin))
