# This file is a part of NestedNumbers.jl, licensed under the MIT License (MIT).

import Test
import Aqua
import NestedNumbers

Test.@testset "Package ambiguities" begin
    Test.@test isempty(Test.detect_ambiguities(NestedNumbers))
end # testset

Test.@testset "Aqua tests" begin
    Aqua.test_all(
        NestedNumbers,
        ambiguities = true
    )
end # testset
