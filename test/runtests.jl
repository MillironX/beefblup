using BeefBLUP
using DataFrames
using Test

@testset "BeefBLUP.jl" begin
    # Write your tests here.
    correctX = [1 1 0 0; 1 1 0 1; 1 0 1 0; 1 0 1 1; 1 0 1 0; 1 0 1 1; 1 0 0 0]
    fixedfx = DataFrame(year = [1990, 1990, 1991, 1991, 1991, 1991, 1992], sex = ["male", "female", "male", "female", "male", "female", "male"])
    @test BeefBLUP.fixedeffectmatrix(fixedfx)[1] == correctX
    correctA = [1   0   1/2 1/2 1/2 0   0;
                0   1   0   0   1/2 1/2 0;
                1/2 0   1   1/4 1/4 0   0;
                1/2 0   1/4 1   1/4 0   0;
                1/2 1/2 1/4 1/4 1   1/4 0;
                0 1/2   0   0   1/4 1   0;
                0 0     0   0   0   0   1]
    id = collect(1:7)
    dam_id = [missing, missing, missing, missing, 2, 2, missing]
    sire_id = [missing, missing, 1, 1, 1, missing, missing]
    @test BeefBLUP.additiverelationshipmatrix(id, dam_id, sire_id) == correctA
end
