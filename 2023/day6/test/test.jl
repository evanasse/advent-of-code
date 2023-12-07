using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """
Time:      7  15   30
Distance:  9  40  200"""

    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines) == 288
end

@testset "test2" begin
    input = """
Time:      7  15   30
Distance:  9  40  200"""

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 71503
end
