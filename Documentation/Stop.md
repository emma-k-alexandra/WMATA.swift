#  Using `Stop`

The `Stop` struct represents a MetroBus stop.

## Definition

```swift
public struct Stop {
    public let id: String
}
```

Values are `StopID`s rather than stop names.

### Values
MetroBus stops are numerous and defining them all explicitly is not feasible. Check the [Stop Search][stop-search] API from WMATA, which is available on `MetroBus` as the `searchStops` method.

### As a `String`

When explicitly stating a `Stop`, you can simply provide a `String` of the StopID you wish to use, rather than creating a `Stop` struct explicitly.

```swift
let stop: Stop = "1001195"
```

You'll still need to use the `id` field when you are provided a `Stop` instance.

## Callback methods

### `nextBuses`

[WMATA Documentation][next-buses]  
Next bus arrivals at this Stop

```swift
Stop(id: "1001195").nextBuses(key: apiKey) { result in
    switch result {
    case .success(let predictions):
        print(predictions)

    case .failure(let error):
        print(error)
    }
}
```

### `schedule`

[WMATA Documentation][stop-schedule]  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
Stop(id: "1001195").schedule() { result in
    switch result {
    case .success(let schedule):
        print(schedule)

    case .failure(let error):
        print(error)
    }
}   
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `nextBusesPublisher`

[WMATA Documentation][next-buses]  
Next bus arrivals at this Stop

```swift
Stop(id: "1001195")
    .nextBusesPublisher(key: apiKey)
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```

### `schedulePublisher`

[WMATA Documentation][stop-schedule]  
Buses scheduled to arrival at this Stop at a given date. Omit for today.

```swift
Stop(id: "1001195")
    .schedulePublisher()
    .sink(
        receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished")
            case let .failure(failure):
                print(failure)
            }
        },
        receiveValue: { response in
            print(response)
        }
    )
```


[stop-search]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6d
[next-buses]: https://developer.wmata.com/docs/services/5476365e031f590f38092508/operations/5476365e031f5909e4fe331d
[stop-schedule]: https://developer.wmata.com/docs/services/54763629281d83086473f231/operations/5476362a281d830c946a3d6c
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
