using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"""

    lines = [String(line) for line in split(input, "\n")]
    # @test f1(lines) == 6440
end

@testset "test2" begin
    input = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"""

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 5905
end
