using Test

include("../src/lib.jl")

@testset "test1" begin
    input = """

    """

    lines = [String(line) for line in split(input, "\n")]
    @test f1(lines)
end

@testset "test2" begin
    input = """

    """

    lines = [String(line) for line in split(input, "\n")]
    @test f2(lines)
end
