include("c:/Users/Rainer/Titanic_Julia/TITANIC_JULIA/src/Data_Processing.jl")

# Performing feature engineering
imputed_data.FamilySize = imputed_data.SibSp .+ imputed_data.Parch .+ 1
imputed_data.IsAlone = imputed_data.FamilySize .== 1

using  StatsPlots

@df imputed_data histogram(:Age, group=:Survived, normalize=:probability,
                 title="Age Distribution by Survival",
                 legend=:topright)

using Statistics
StatsPlots.StatsBase.skewness(imputed_data.Age)

@df imputed_data bar(:Sex, group=:Survived, normalize=:probability,
           title="Survival Rate by Sex";reuse=false)

gr()

@df imputed_data bar(:Pclass, group=:Survived, legend=:top;reuse=false)
gr()
@df imputed_data bar(:Embarked, group=:Survived;reuse=false)
gr()
@df imputed_data bar(:IsAlone, group=:Survived;reuse=false)

#Performing hot encoding
using MLJ
hot = OneHotEncoder()
mach_hot = machine(hot, imputed_data)