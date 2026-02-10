# Users only need to depend on NestedNumbers to write generic code that does
# restrict numerical type. For example:

using NestedNumbers
using SpecialFunctions: loggamma

# We'll define a ratio-function that doesn't allow complex-valued ratios (the
# user may have good reasons that), but allows both real numbers and real
# valued quantities (real numbers with units):
real_ratio(a::QReal, b::QReal) = a / b

# Poisson-PDF/PMF wouldn't make sense for a non-real λ, and we'll disallow
# non-integer `k` for the log-PMF and disallow a non-real `k` for the log-PDF:
poisson_logpmf(λ::AReal, k::AInteger) = k * log(λ) - λ - loggamma(k + 1)
function poisson_logpdf(λ::AReal, k::AReal)
    logd = poisson_logpmf(λ, trunc(Int, k))
    return ifelse(isinteger(k), logd, oftype(logd, -Inf))
end


# The unit packages derive their number types from `QuantityNumber`:

x = 4.2f0
i = Int32(2)


import Unitful

ux = x * Unitful.u"m"
ui = i * Unitful.u"s"
ux isa QuantityNumber{Float32} && ux isa AReal
ui isa QuantityNumber{Int32} && ui isa AInteger


import FlexUnits

fsx = x * FlexUnits.UnitRegistry.u"m"
fsi = i * FlexUnits.UnitRegistry.u"s"
fsx isa QuantityNumber{Float32} && fsx isa AReal
fsi isa QuantityNumber{Int32} && fsi isa AInteger

fdx = x * FlexUnits.UnitRegistry.ud"m"
fdi = i * FlexUnits.UnitRegistry.ud"s"
fdx isa QuantityNumber{Float32} && fdx isa AReal
fdi isa QuantityNumber{Int32} && fdi isa AInteger


import DynamicQuantities

dx = x * DynamicQuantities.u"m"
di = i * DynamicQuantities.u"s"
dx isa QuantityNumber{Float32} && dx isa AReal
di isa QuantityNumber{Int32} && di isa AInteger


# Since it allows for `QReal`, we can use `real_ratio` with and without units,
# as long as the numerical type is real:

real_ratio(x, i) isa Real
real_ratio(ux, ui) isa Unitful.AbstractQuantity
real_ratio(fsx, fsi) isa FlexUnits.Quantity
real_ratio(fdx, fdi) isa FlexUnits.Quantity
real_ratio(dx, di) isa DynamicQuantities.AbstractQuantity


# Reactant derives its number types from `RemoteNumber` and `OpaqueNumber`:

import Reactant

rx = Reactant.ConcreteRNumber(x)
rx isa NestedNumber{Float32} && rx isa AReal

ri = Reactant.ConcreteRNumber(i)
ri isa NestedNumber{Int32} && ri isa AInteger

ry = Reactant.ConcreteRNumber(Float32(i))
ry isa NestedNumber{Float32} && ri isa AReal

is_opaque(x) = x isa OpaqueNumber
Reactant.@jit is_opaque(rx)


# Can run `real_ratio`, `poisson_logpmf`, and `poisson_logpdf` via Reactant,
# and still respect their constraints on numerical type:

Reactant.@code_hlo real_ratio(rx, ri)
Reactant.@jit real_ratio(rx, ri)

Reactant.@code_hlo poisson_logpmf(rx, ri)
Reactant.@jit poisson_logpmf(rx, ri)

Reactant.@code_hlo poisson_logpdf(rx, ry)
Reactant.@jit poisson_logpdf(rx, ry)
isinf(Reactant.@jit poisson_logpdf(rx, rx))
