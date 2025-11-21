using CSV
using DataFrames
using Impute

data_test = CSV.read("src/test.csv", DataFrame)
data_train = CSV.read("src/train.csv", DataFrame)

data_train

ismissing.(data_train) .== true

ismissing(data_train)

describe(data_train)
describe(data_train, :nmissing)[[6,11,12], :]

imputed_data = copy(data_train)
imputed_data.Age = coalesce.(imputed_data.Age, Impute.median(skipmissing(imputed_data.Age)))
imputed_data.Fare = coalesce.(imputed_data.Fare, Impute.mean(skipmissing(imputed_data.Fare)))
imputed_data.Embarked = coalesce.(imputed_data.Embarked, Impute.mode(skipmissing(imputed_data.Embarked)))

using MLJScientificTypes
schema(imputed_data)

coerce!(imputed_data, :Survived => OrderedFactor,
            :Pclass => OrderedFactor,
            :Sex => Multiclass,
            :Embarked => Multiclass,
            :Age => Continuous,
            :Fare => Continuous,
            :SibSp => Count,
            :Parch => Count)

schema(imputed_data)