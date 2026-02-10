# This file is a part of NestedNumbers.jl, licensed under the MIT License (MIT).

"""
    NestedNumbers

Numbers that kind of contain numbers.
"""
module NestedNumbers

export NestedNumber, BareNumber, AReal, AInteger, ABool, AComplex
export OpaqueNumber, RemoteNumber
export QuantityNumber, QReal, QInteger, QBool, QComplex


"""
    abstract type NestedNumber{T<:Number} end

Super-type for numbers that contain another number of type `T`, directly or
semantically.

The value of the inner number may or may not be directly accessible, and
may or may not have a unit or similar, depending of the subtype of
`NestedNumber`.

Examples include opaque numbers, quantities with units, etc.
"""
abstract type NestedNumber{T<:Number} <: Number end


"""
    abstract type BareNumber{T<:Number} end

Super-type for numbers do not have a unit or similar "decoration".
"""
abstract type BareNumber{T<:Number} <: NestedNumber{T} end

"""
    const AReal{T<:Real} = Union{T, BareNumber{T}}

Real as "almost Real", a `Real` or `NestedNumber{<:Real}`.
"""
const AReal{T<:Real} = Union{T, BareNumber{T}}

"""
    const AInteger{T<:Integer} = Union{T, BareNumber{T}}

Real as "almost Real", a `Real` or `NestedNumber{<:Real}`.
"""
const AInteger{T<:Integer} = Union{T, BareNumber{T}}

"""
    const AInteger{T<:Integer} = Union{T, BareNumber{T}}

Read as "almost Integer", an `Integer` or `NestedNumber{<:Integer}`.
"""
const AInteger{T<:Integer} = Union{T, BareNumber{T}}

"""
    const ABool = Union{Bool, BareNumber{Bool}}

Read as "almost Bool", a `Bool` or `NestedNumber{Bool}`.
"""
const ABool = Union{Bool, BareNumber{Bool}}

"""
    const AComplex{T<:Real} = Union{Complex{T}, BareNumber{Complex{T}}}

Read as "almost Complex", a `Complex` or `BareNumber{<:Complex}`.
"""
const AComplex{T<:Real} = Union{Complex{T}, BareNumber{Complex{T}}}


"""
    abstract type OpaqueNumber{T<:Number} end

Super-type for numbers that do not have an accessible value, for example
traced or symbolic numbers.
"""
abstract type OpaqueNumber{T<:Number} <: BareNumber{T} end


"""
    abstract type RemoteNumber{T<:Number} end

Super-type for numbers that are physically stored on another system or device,
so that accessing the value may take time.
"""
abstract type RemoteNumber{T<:Number} <: BareNumber{T} end


"""
    abstract type QuantityNumber{T<:Number} <: NestedNumber{T} end

Read as "maybe static Integer", an `Integ
Super-type for number-like quantities (e.g. numbers with units).
"""
abstract type QuantityNumber{T<:Number} <: NestedNumber{T} end

"""
    const QReal{T<:Real} = Union{T, BareNumber{T}, QuantityNumber{T}, QuantityNumber{<:BareNumber{T}}}

Read as "real number or real-valued quantity", a `Real` or `QuantityNumber{<:Real}`.
""" 
const QReal{T<:Real} = Union{T, BareNumber{T}, QuantityNumber{T}, QuantityNumber{<:BareNumber{T}}}

"""
    const QInteger{T<:Integer} = Union{T, BareNumber{T}, QuantityNumber{T}, QuantityNumber{<:BareNumber{T}}}

Read as "integer or integer-valued quantity", an `Integer` or `QuantityNumber{<:Integer}`.
"""
const QInteger{T<:Integer} = Union{T, BareNumber{T}, QuantityNumber{T}, QuantityNumber{<:BareNumber{T}}}

"""
    const QBool = Union{Bool, BareNumber{Bool}, QuantityNumber{Bool}, QuantityNumber{<:BareNumber{Bool}}}

Read as "boolean or boolean-valued quantity", a `Bool` or `QuantityNumber{Bool}`.
"""
const QBool = Union{Bool, BareNumber{Bool}, QuantityNumber{Bool}, QuantityNumber{<:BareNumber{Bool}}}

"""
    const QComplex{T<:Real} = Union{Complex{T}, BareNumber{Complex{T}}, QuantityNumber{Complex{T}}, QuantityNumber{<:BareNumber{Complex{T}}}}

Read as "complex or complex-valued quantity", a `Complex` or `QuantityNumber{<:Complex}`.
"""
const QComplex{T<:Real} = Union{Complex{T}, BareNumber{Complex{T}}, QuantityNumber{Complex{T}}, QuantityNumber{<:BareNumber{Complex{T}}}}

end # module
