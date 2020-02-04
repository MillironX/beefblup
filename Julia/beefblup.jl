# beefblup
# Main script for performing single-variate BLUP to find beef cattle
# breeding values
# Usage: julia beefblup.jl
# (C) 2019 Thomas A. Christensen II
# Licensed under BSD-3-Clause License

# Import the required packages
using XLSX
using LinearAlgebra
using Dates
using Gtk

# Display stuff
println("beefblup v 0.0.0.1")
println("(C) 2019 Thomas A. Christensen II")
println("https://github.com/millironx/beefblup")
print("\n")

### Prompt User
# Ask for an input spreadsheet
path = open_dialog_native(
    "Select a beefblup worksheet",
    GtkNullContainer(),
    ("*.xlsx", GtkFileFilter("*.xlsx", name="beefblup worksheet"))
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
print("[🐮]: Importing Excel file...")

# Import data from a suitable spreadsheet
data = XLSX.readxlsx(path)[1][:]

print("Done!\n")

### Process input file
print("[🐮]: Processing and formatting data...")

# Extract the headers into a separate array
headers = data[1,:]
data = data[2:end,:]

# Sort the array by date
data = sortslices(data, dims=1, lt=(x,y)->isless(x[2],y[2]))

# Define fields to hold id values for animals and their parents
ids = string.(data[:,1])
damids = string.(data[:,3])
sireids = string.(data[:,4])
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
            normal[i-5] = string(data[j,i])
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
    localdata = string.(data[:,i+5])
    traits = unique(localdata)
    # Remove the normal version from the analysis
    effecttraits = traits[findall(x -> x != normal[i], traits)]
    # Iterate inside of the group
    for j in 1:length(effecttraits)
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
Y = convert(Array{Float64}, data[:,5])

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
    write(fileID, ids[i])
    write(fileID, "\t")
    write(fileID, string(solutions[i+counter-1]))
    write(fileID, "\t")
    write(fileID, string(reliability[i+counter-1]))
    write(fileID, "\n")
end

write(fileID, "\n - END REPORT -")
close(fileID)

print("Done!\n")
