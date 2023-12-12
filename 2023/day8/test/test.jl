using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """
LLR

AAA = (BBB, BBB)
BBB = (AAA, ZZZ)
ZZZ = (ZZZ, ZZZ)"""

    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines) == 6
end

@testset "test2" begin
    input = """
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)"""

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 6
end
