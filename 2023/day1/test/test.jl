using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet"""
    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines) == 142
end

@testset "test2" begin
    input = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen"""
    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines) == 281
end
