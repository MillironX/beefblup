using BeefBLUP
using DataFrames
using Test

@testset "BeefBLUP.jl" begin
    # Write your tests here.
    correctX = [1 1 0 0; 1 1 0 1; 1 0 1 0; 1 0 1 1; 1 0 1 0; 1 0 1 1; 1 0 0 0]
    fixedfx = DataFrame(year = [1990, 1990, 1991, 1991, 1991, 1991, 1992], sex = ["male", "female", "male", "female", "male", "female", "male"])
    @test BeefBLUP.fixedeffectmatrix(fixedfx)[1] == correctX
end
