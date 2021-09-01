# beefblup
# Julia package for performing single-variate BLUP to find beef cattle
# breeding values
# (C) 2021 Thomas A. Christensen II
# Licensed under BSD-3-Clause License
# cSpell:includeRegExp #.*
# cSpell:includeRegExp ("""|''')[^\1]*\1

module BeefBLUP

# Import the required packages
using CSV
using DataFrames
using LinearAlgebra
using Dates
using Gtk

# Main entry-level function - acts just like the script
function beefblup()

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

    beefblup(path, savepath, h2)

end

function beefblup(datafile::String, h2::Float64)
    # Assume the data is named the same as the file without the trailing extension
    dataname = join(split(datafile, ".")[1:end - 1])

    # Create a new results name
    resultsfile = string(dataname, "_results.txt")

    # Pass this info on to the worker
    beefblup(datafile, resultsfile, h2)
end

# Main worker function, can perform all the work if given all the user input
function beefblup(path::String, savepath::String, h2::Float64)

    # Import data from a suitable spreadsheet
    data = DataFrame(CSV.File(path))

    # Make sure the data is in the proper format
    renamecolstospec!(data)

    # Sort the array by date
    sort!(data, :birthdate)

    # Define fields to hold id values for animals and their parents
    numanimals = length(data.id)

    # Calculate the relationship matrix
    A = additiverelationshipmatrix(data.id, data.dam, data.sire)

    # Extract all of the fixed effects
    fixedeffectdata = data[:,5:end-1]

    (X, fixedeffects) = fixedeffectmatrix(fixedeffectdata)

    # Extract the observed data
    Y = convert(Array{Float64}, data[:,end])

    # The random effects matrix
    Z = Matrix{Int}(I, numanimals, numanimals)

    # Remove items where there is no data
    nullobs = findall(isnothing, Y)
    Z[nullobs, nullobs] .= 0

    # Calculate heritability
    λ = (1 - h2) / h2

    # Use the mixed-model equations
    MME = [X' * X X' * Z; Z' * X (Z' * Z) + (inv(A) .* λ)]
    MMY = [X' * Y; Z' * Y]
    solutions = MME \ MMY

    # Find the accuracies
    diaginv = diag(inv(MME))
    reliability = ones(Float64, length(diaginv)) - diaginv .* λ

    # Find how many traits we found BLUE for
    numgroups = numgroups .- 1

    # Extract the names of the traits
    fixedfxnames = names(fixedfx)
    traitname = names(data)[end]

    # Start printing results to output
    fileID = open(savepath, "w")
    write(fileID, "beefblup Results Report\n")
    write(fileID, "Produced using beefblup (")
    write(fileID, "https://github.com/millironx/beefblup")
    write(fileID, ")\n\n")
    write(fileID, "Input:\t")
    write(fileID, path)
    write(fileID, "\nAnalysis performed:\t")
    write(fileID, string(Dates.today()))
    write(fileID, "\nTrait examined:\t")
    write(fileID, traitname)
    write(fileID, "\n\n")

    # Print base population stats
    write(fileID, "Base Population:\n")
    for i in 1:length(normal)
        write(fileID, "\t")
        write(fileID, fixedfxnames[i])
        write(fileID, ":\t")
        write(fileID, normal[i])
        write(fileID, "\n")
    end
    write(fileID, "\tMean ")
    write(fileID, traitname)
    write(fileID, ":\t")
    write(fileID, string(solutions[1]))
    write(fileID, "\n\n")

    # Contemporary group adjustments
    counter = 2
    write(fileID, "Contemporary Group Effects:\n")
    for i in 1:length(numgroups)
        write(fileID, "\t")
        write(fileID, fixedfxnames[i])
        write(fileID, "\tEffect\tReliability\n")
        for j in 1:numgroups[i]
            write(fileID, "\t")
            write(fileID, adjustedtraits[counter - 1])
            write(fileID, "\t")
            write(fileID, string(solutions[counter]))
            write(fileID, "\t")
            write(fileID, string(reliability[counter]))
            write(fileID, "\n")

            counter = counter + 1
        end
        write(fileID, "\n")
    end
    write(fileID, "\n")

    # Expected breeding values
    write(fileID, "Expected Breeding Values:\n")
    write(fileID, "\tID\tEBV\tReliability\n")
    for i in 1:numanimals
        write(fileID, "\t")
        write(fileID, string(data.id[i]))
        write(fileID, "\t")
        write(fileID, string(solutions[i + counter - 1]))
        write(fileID, "\t")
        write(fileID, string(reliability[i + counter - 1]))
        write(fileID, "\n")
    end

    write(fileID, "\n - END REPORT -")
    close(fileID)

end

"""
    fixedeffectmatrix(fixedeffectdata::DataFrame)

Creates contemporary groupings and the fixed-effect incidence matrix based on the fixed
effects listed in `fixedeffectdata`.

Returns a tuple `(X::Matrix{Int}, fixedeffects::Array{FixedEffect})` in which `X` is the
actual matrix, and `fixedeffects` is the contemporary groupings.
"""
function fixedeffectmatrix(fixedeffectdata::DataFrame)
    # Declare an empty return matrix
    fixedeffects = FixedEffect[]

    # Add each trait to the array
    for i in 1:size(fixedeffectdata)[2]
        name = names(fixedeffectdata)[i]
        traits = eachcol(fixedeffectdata)[i]

        if length(unique(traits)) > 1
            push!(fixedeffects, FixedEffect(name, traits))
        else
            @warn string("column '", name, "' does not have any unique animals and will be dropped from analysis")
            pname = propertynames(fixedeffectdata)[i]
            DataFrames.select!(fixedeffectdata, Not(pname))
        end
    end

    X = ones(Int64, (size(fixedeffectdata)[1], 1))

    for i in 1:length(fixedeffects)
        trait = fixedeffects[i]
        for phenotype in trait.alltraits
            X = cat(X, Int64.(fixedeffectdata[:,i] .== phenotype), dims=2)
        end
    end

    return X, fixedeffects
end

"""
    additiverelationshipmatrix(id, dam, sire)

Returns the additive numerator relationship matrix based on the pedigree provided in `dam`
and `sire` for animals in `id`.

"""
function additiverelationshipmatrix(id::AbstractVector, damid::AbstractVector, sireid::AbstractVector)
    # Sanity-check for valid pedigree
    if !(length(id) == length(damid) && length(damid) == length(sireid))
        throw(ArgumentError("id, dam, and sire must be of the same length"))
    end

    # Convert to positions
    dam = indexin(damid, id)
    sire = indexin(sireid, id)

    # Calculate loop iterations
    numanimals = length(dam)

    # Create an empty matrix for the additive relationship matrix
    A = zeros(numanimals, numanimals)

    # Create the additive relationship matrix by the FORTRAN method presented by
    # Henderson
    for i in 1:numanimals
        if !isnothing(dam[i]) && !isnothing(sire[i])
            for j in 1:(i - 1)
                A[j,i] = 0.5 * (A[j,sire[i]] + A[j,dam[i]])
                A[i,j] = A[j,i]
            end
            A[i,i] = 1 + 0.5 * A[sire[i], dam[i]]
        elseif !isnothing(dam[i]) && isnothing(sire[i])
        for j in 1:(i - 1)
            A[j,i] = 0.5 * A[j,dam[i]]
            A[i,j] = A[j,i]
        end
        A[i,i] = 1
    elseif isnothing(dam[i]) && !isnothing(sire[i])
        for j in 1:(i - 1)
            A[j,i] = 0.5 * A[j,sire[i]]
            A[i,j] = A[j,i]
        end
        A[i,i] = 1
    else
        for j in 1:(i - 1)
            A[j,i] = 0
            A[i,j] = 0
        end
        A[i,i] = 1
        end
    end

    return A
end

"""
    renamecolstospec(::DataFrame)

Renames the first four columns of the beefblup data sheet so that they can be referred to by
name instead of by column index, regardless of user input.
"""
function renamecolstospec!(df::DataFrame)
    # Pull out the fixed-effect and observation name
    othernames = propertynames(df)[5:end]

    # Put specification column names and user-defined names together
    allnames = cat([:id, :birthdate, :dam, :sire], othernames, dims=1)

    # Rename in the DataFrame
    rename!(df, allnames, makeunique=true)
    return df
end

struct FixedEffect
    name::String
    basetrait::Any
    alltraits::AbstractArray{Any}
end

function FixedEffect(name::String, incidences)
    basetrait = last(unique(incidences))
    types = unique(incidences)[1:end-1]
    return FixedEffect(name, basetrait, types)
end


end
