# This file is a part of NestedNumbers.jl, licensed under the MIT License (MIT).

using NestedNumbers
using Test


struct SomeOpaque{T<:Number} <: OpaqueNumber{T} end

struct SomeRemote{T<:Number} <: RemoteNumber{T} end

struct SomeQuantity{T<:Number} <: QuantityNumber{T}
    value::T
    unit::Symbol
end


@testset "NestedNumber" begin
    oreal = SomeOpaque{Float32}()
    @test oreal isa AReal{Float32}
    @test oreal isa QReal{Float32}
    @test oreal isa Number

    ointeger = SomeOpaque{Int32}()
    @test ointeger isa AInteger{Int32}
    @test ointeger isa QInteger{Int32}
    @test ointeger isa Number

    obool = SomeOpaque{Bool}()
    @test obool isa ABool
    @test obool isa QBool
    @test obool isa Number

    ocomplex = SomeOpaque{ComplexF32}()
    @test ocomplex isa AComplex{Float32}
    @test ocomplex isa QComplex{Float32}
    @test ocomplex isa Number


    rreal = SomeRemote{Float32}()
    @test rreal isa AReal{Float32}
    @test rreal isa QReal{Float32}
    @test rreal isa Number

    rinteger = SomeRemote{Int32}()
    @test rinteger isa AInteger{Int32}
    @test rinteger isa QInteger{Int32}
    @test rinteger isa Number

    tbool = SomeRemote{Bool}()
    @test tbool isa ABool
    @test tbool isa QBool
    @test tbool isa Number

    tcomplex = SomeRemote{ComplexF32}()
    @test tcomplex isa AComplex{Float32}
    @test tcomplex isa QComplex{Float32}
    @test tcomplex isa Number


    qreal = SomeQuantity(4.2f0, :m)
    @test !(qreal isa AReal{Float32})
    @test qreal isa QReal{Float32}
    @test qreal isa Number

    qinteger = SomeQuantity(Int32(42), :s)
    @test !(qinteger isa AInteger{Int32})
    @test qinteger isa QInteger{Int32}
    @test qinteger isa Number

    qbool = SomeQuantity(true, :kg)
    @test !(qbool isa ABool)
    @test qbool isa QBool
    @test qbool isa Number

    qcomplex = SomeQuantity(1.0f0 + 2.0f0im, :A)
    @test !(qcomplex isa AComplex{Float32})
    @test qcomplex isa QComplex{Float32}
    @test qcomplex isa Number


    qoreal = SomeQuantity(oreal, :m)
    @test !(qoreal isa AReal{Float32})
    @test qoreal isa QReal{Float32}
    @test qoreal isa Number

    qointeger = SomeQuantity(ointeger, :s)
    @test !(qointeger isa AInteger{Int32})
    @test qointeger isa QInteger{Int32}
    @test qointeger isa Number

    qobool = SomeQuantity(obool, :kg)
    @test !(qobool isa ABool)
    @test qobool isa QBool
    @test qobool isa Number

    qocomplex = SomeQuantity(ocomplex, :A)
    @test !(qocomplex isa AComplex{Float32})
    @test qocomplex isa QComplex{Float32}
    @test qocomplex isa Number
end
