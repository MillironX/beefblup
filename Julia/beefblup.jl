# beefblup
# Main script for performing single-variate BLUP to find beef cattle
# breeding values
# Usage: julia beefblup.jl
# (C) 2019 Thomas A. Christensen II
# Licensed under BSD-3-Clause License

# Import the required packages
using XLSX

# Display stuff
println("beefblup v 0.0.0.1")
println("(C) 2019 Thomas A. Christensen II")
println("https://github.com/millironx/beefblup")
print("\n")

### Prompt User
# Ask for an input spreadsheet
# print("Enter the full filename of a beefblup worksheet> ")
# path = readline(stdin)
path = "C:\\Users\\cclea\\source\\repos\\beefblup\\Excel\\Master BLUP Worksheet.xlsx"

# Ask for an output text filename
# print("Enter the full filename of your desired results> ")
# savepath = readline(stdin)
savepath = "C:\\Users\\cclea\\source\\repos\\beefblup\\results.txt"

# Ask for heritability
# print("What is the heritability for this trait?> ")
# h2 = parse(Float64, readline(stdin))
h2 = 0.4

### Import input filename
print("[🐮]: Importing Excel file...")

# Import data from a suitable spreadsheet
data = XLSX.readxlsx(path)[1][:]

print("Done!\n")

### Process input file
print("[🐮]: Processing and formatting data ...")

# Extract the headers into a separate array
headers = data[1,:]
data = data[2:end,:]

# Sort the array by date
data = sortslices(data, dims=1, lt=(x,y)->isless(x[2],y[2]))

# Define fields to hold id values for animals and their parents
ids = data[:,1]
damids = data[:,3]
sireids = data[:,4]
numanimals = length(ids)

# Find the index values for animals and their parents
dam = indexin(damids, ids)
sire = indexin(sireids, ids)

# Store column numbers that need to be deleted
# Column 6 contains an intermediate Excel calculation and always need to
# be deleted
colstokeep = [1, 2, 3, 4, 5]

# Find any columns that need to be deleted
for i in 7:length(headers)
    if length(unique(data[:,i])) <= 1
        colname = headers[i]
        print("Column '")
        print(colname)
        print("' does not have any unique animals and will be removed from this analysis\n")
    else
        push!(colstokeep, i)
    end
end

# Delete the appropriate columns from the datasheet and the headers
data = data[:, colstokeep]
headers = headers[colstokeep]

# Determine how many contemporary groups there are
numgroups = ones(1, length(headers)-5)
for i in 6:length(headers)
    numgroups[i-5] = length(unique(data[:,i]))
end

# If there are more groups than animals, then the analysis cannot continue
if sum(numgroups) >= numanimals
    println("There are more contemporary groups than animals. The analysis will
    now abort.")
    exit()
end

# Define a "normal" animal as one of the last in the groups, provided that
# all traits do not have null values
normal = Array{String}(undef,1,length(headers)-5)
for i in 6:length(headers)
    for j in numanimals:-1:1
        if !ismissing(data[j,i])
            normal[i-5] = data[j,i]
            break
        end
    end
end

# Print the results of the "normal" definition
println(" ")
println("For the purposes of this analysis, a 'normal' animal will be defined by")
println("the following traits:")
for i in 6:length(headers)
    print(headers[i])
    print(": ")
    print(normal[i-5])
    print("\n")
end
println("If no animal matching this description exists, the results may appear")
println("outlandish, but are still as correct as the accuracy suggests")

print("Done!\n")
