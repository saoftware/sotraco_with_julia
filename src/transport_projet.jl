module TransportProjet

using Dates
using CSV
using DataFrames
using Statistics
using JSON3

include("types.jl")
include("io_operations.jl")
include("optimisation.jl")
include("analyse.jl")
include("visualisation.jl")
include("recommandations.jl")
include("rapports.jl")
include("prediction.jl")
end