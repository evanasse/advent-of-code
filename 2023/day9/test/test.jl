using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"""

    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines) == 114
end

@testset "test2" begin
    input = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45"""

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 2
end
