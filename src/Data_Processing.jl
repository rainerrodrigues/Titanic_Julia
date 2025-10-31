using CSV
using DataFrames
using Impute

data_test = CSV.read("src/test.csv", DataFrame)
data_train = CSV.read("src/train.csv", DataFrame)

data_train

ismissing.(data_train) .== true

ismissing(data_train)

describe(data_train)

processed_data = data_train[:,Not([:PassengerId,:Name,:Cabin,:Ticket,:Embarked,:Fare])]

any(ismissing, eachrow(processed_data))

n_rows = nrow(processed_data)
total_missing = sum(col -> sum(ismissing, processed_data[!, col]), names(processed_data))
missing_pct = round((total_missing / n_rows) * 100, digits=2)

for col in names(processed_data)
    pct = (sum(ismissing, processed_data[!, col]) / n_rows) * 100
    if 19.5 ≤ pct ≤ 20.5  # Check for values around 20%
        println("$col has $(round(pct, digits=2))% missing data")
    end
end