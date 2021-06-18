#!/bin/bash
#=
exec julia --project=$(realpath $(dirname $(dirname "${BASH_SOURCE[0]}"))) "${BASH_SOURCE[0]}" "$@"
=#
# beefblup
# Main script for performing single-variate BLUP to find beef cattle
# breeding values
# Usage: julia beefblup.jl
# (C) 2020 Thomas A. Christensen II
# Licensed under BSD-3-Clause License
# cSpell:includeRegExp #.*
# cSpell:includeRegExp ("""|''')[^\1]*\1

# Import the required packages
using CSV
using DataFrames
using LinearAlgebra
using Dates
using Gtk

# Display stuff
println("beefblup v 0.1")
println("(C) 2020 Thomas A. Christensen II")
println("https://github.com/millironx/beefblup")
print("\n")

### Prompt User
# Ask for an input spreadsheet
path = open_dialog_native(
    "Select a beefblup worksheet",
    GtkNullContainer(),
    ("*.csv", GtkFileFilter("*.csv", name="beefblup worksheet"))
)

# Ask for an output text filename
savepath = save_dialog_native(
    "Save your beefblup results",
    GtkNullContainer(),
    (GtkFileFilter("*.txt", name="Results file"),
    "*.txt")
)

# Ask for heritability
print("What is the heritability for this trait?> ")
h2 = parse(Float64, readline(stdin))

### Import input filename
print("[🐮]: Importing data file...")

# Import data from a suitable spreadsheet
data = CSV.File(path) |> DataFrame

print("Done!\n")

### Process input file
print("[🐮]: Processing and formatting data...")

# Sort the array by date
sort!(data, :birthdate)

# Define fields to hold id values for animals and their parents
numanimals = length(data.id)

# Find the index values for animals and their parents
dam = indexin(data.dam, data.id)
sire = indexin(data.sire, data.id)

# Extract all of the fixed effects
fixedfx = select(data, Not([:id, :birthdate, :sire, :dam]))[:,1:end-1]

# Find any columns that need to be deleted
for i in 1:ncol(fixedfx)
    if length(unique(fixedfx[:,i])) <= 1
        colname = names(fixedfx)[i]
        print("Column '")
        print(colname)
        print("' does not have any unique animals and will be removed from this analysis\n")
        deletecols!(fixedfx,i)
    end
end

# Determine how many contemporary groups there are
numtraits = ncol(fixedfx)
numgroups = ones(1, numtraits)
for i in 1:numtraits
    numgroups[i] = length(unique(fixedfx[:,i]))
end

# If there are more groups than animals, then the analysis cannot continue
if sum(numgroups) >= numanimals
    println("There are more contemporary groups than animals. The analysis will
    now abort.")
    exit()
end

# Define a "normal" animal as one of the last in the groups, provided that
# all traits do not have null values
normal = Array{String}(undef,1,numtraits)
for i in 1:numtraits
    for j in numanimals:-1:1
        if !ismissing(fixedfx[j,i])
            normal[i] = string(fixedfx[j,i])
            break
        end
    end
end

print("Done!\n")

### Create the fixed-effect matrix
print("[🐮]: Creating the fixed-effect matrix...")

# Form the fixed-effect matrix
X = zeros(Int8, numanimals, floor(Int,sum(numgroups))-length(numgroups)+1)
X[:,1] = ones(Int8, 1, numanimals)

# Create an external counter that will increment through both loops
counter = 2

# Store the traits in a string array
adjustedtraits =
Array{String}(undef,floor(Int,sum(numgroups))-length(numgroups))
# Iterate through each group
for i in 1:length(normal)
    # Find the traits that are present in this trait
    localdata = string.(fixedfx[:,i])
    traits = unique(localdata)
    # Remove the normal version from the analysis
    effecttraits = traits[findall(x -> x != normal[i], traits)]
    # Iterate inside of the group
    for j in 1:(length(effecttraits) - 1)
            matchedindex = findall(x -> x != effecttraits[j], localdata)
            X[matchedindex, counter] .= 1
            # Add this trait to the string
            adjustedtraits[counter - 1] = traits[j]
        # Increment the big counter
        global counter = counter + 1
    end
end

print("Done!\n")

### Additive relationship matrix
print("[🐮]: Creating additive relationship matrix...")

# Create an empty matrix for the additive relationship matrix
A = zeros(numanimals, numanimals)

# Create the additive relationship matrix by the FORTRAN method presented by
# Henderson
for i in 1:numanimals
    if !isnothing(dam[i]) && !isnothing(sire[i])
        for j in 1:(i-1)
            A[j,i] = 0.5*(A[j,sire[i]] + A[j,dam[i]])
            A[i,j] = A[j,i]
        end
        A[i,i] = 1 + 0.5*A[sire[i], dam[i]]
    elseif !isnothing(dam[i]) && isnothing(sire[i])
        for j in 1:(i-1)
            A[j,i] = 0.5*A[j,dam[i]]
            A[i,j] = A[j,i]
        end
        A[i,i] = 1
    elseif isnothing(dam[i]) && !isnothing(sire[i])
        for j in 1:(i-1)
            A[j,i] = 0.5*A[j,sire[i]]
            A[i,j] = A[j,i]
        end
        A[i,i] = 1
    else
        for j in 1:(i-1)
            A[j,i] = 0
            A[i,j] = 0
        end
        A[i,i] = 1
    end
end

print("Done!\n")

### Perform BLUP
print("[🐮]: Solving the mixed-model equations...")

# Extract the observed data
Y = convert(Array{Float64}, data[:,end])

# The random effects matrix
Z = Matrix{Int}(I, numanimals, numanimals)

# Remove items where there is no data
nullobs = findall(isnothing, Y)
Z[nullobs, nullobs] .= 0

# Calculate heritability
λ = (1-h2)/h2

# Use the mixed-model equations
MME = [X'*X X'*Z; Z'*X (Z'*Z)+(inv(A).*λ)]
MMY = [X'*Y; Z'*Y]
solutions = MME\MMY

# Find the accuracies
diaginv = diag(inv(MME))
reliability = ones(Float64, length(diaginv)) - diaginv.*λ

print("Done!\n")

### Output the results
print("[🐮]: Saving results...")

# Find how many traits we found BLUE for
numgroups = numgroups .- 1

# Start printing results to output
fileID = open(savepath, "w")
write(fileID, "beefblup Results Report\n")
write(fileID, "Produced using beefblup for Julia (")
write(fileID, "https://github.com/millironx/beefblup")
write(fileID, ")\n\n")
write(fileID, "Input:\t")
write(fileID, path)
write(fileID, "\nAnalysis performed:\t")
write(fileID, string(Dates.today()))
write(fileID, "\nTrait examined:\t")
write(fileID, headers[5])
write(fileID, "\n\n")

# Print base population stats
write(fileID, "Base Population:\n")
for i in 1:length(numgroups)
    write(fileID, "\t")
    write(fileID, headers[i+5])
    write(fileID, ":\t")
    write(fileID, normal[i])
    write(fileID, "\n")
end
write(fileID, "\tMean ")
write(fileID, headers[5])
write(fileID, ":\t")
write(fileID, string(solutions[1]))
write(fileID, "\n\n")

# Contemporary group adjustments
counter = 2
write(fileID, "Contemporary Group Effects:\n")
for i in 1:length(numgroups)
    write(fileID, "\t")
    write(fileID, headers[i+5])
    write(fileID, "\tEffect\tReliability\n")
    for j in 1:numgroups[i]
        write(fileID, "\t")
        write(fileID, adjustedtraits[counter - 1])
        write(fileID, "\t")
        write(fileID, string(solutions[counter]))
        write(fileID, "\t")
        write(fileID, string(reliability[counter]))
        write(fileID, "\n")

        global counter = counter + 1
    end
    write(fileID, "\n")
end
write(fileID, "\n")

# Expected breeding values
write(fileID, "Expected Breeding Values:\n")
write(fileID, "\tID\tEBV\tReliability\n")
for i in 1:numanimals
    write(fileID, "\t")
    write(fileID, data.id[i])
    write(fileID, "\t")
    write(fileID, string(solutions[i+counter-1]))
    write(fileID, "\t")
    write(fileID, string(reliability[i+counter-1]))
    write(fileID, "\n")
end

write(fileID, "\n - END REPORT -")
close(fileID)

print("Done!\n")
