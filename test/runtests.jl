# This file is a part of NestedNumbers.jl, licensed under the MIT License (MIT).

import Test

Test.@testset "Package NestedNumbers" begin
    include("test_aqua.jl")
    include("test_nested_number.jl")
    include("test_docs.jl")
end # testset
