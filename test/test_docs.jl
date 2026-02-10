# This file is a part of NestedNumbers.jl, licensed under the MIT License (MIT).

using Test
using NestedNumbers
import Documenter

Documenter.DocMeta.setdocmeta!(
    NestedNumbers,
    :DocTestSetup,
    :(using NestedNumbers);
    recursive = true
)
Documenter.doctest(NestedNumbers)
