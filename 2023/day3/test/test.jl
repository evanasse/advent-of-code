using Test

include("../src/lib.jl")

@testset "test1" begin
    input = raw"""
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."""

    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines) == 4361
end

@testset "test2" begin
    input = raw"""
467..114..
...*......
..35..633.
......#...
617*......
.....+.58.
..592.....
......755.
...$.*....
.664.598.."""

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 467835
end
