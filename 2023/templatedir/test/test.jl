using Test

include("../src/lib.jl")

@testset "test1" begin
    @test f1()
end

@testset "test2" begin
    @test f2()
end
