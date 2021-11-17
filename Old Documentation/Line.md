#  Using `Line`

The `Line` enum provides values for all MetroRail lines.

## Definition

```swift
public enum Line {
    case RD
    case BL
    case YL
    case OR
    case GR
    case SV
    case YLRP
}
```
### Current values

- `.RD` - Red
- `.BL` - Blue
- `.YL` - Yellow
- `.OR` - Orange
- `.GR` - Green
- `.SV` - Silver

### Previous values

- `.YLRP` - Yellow Line Rush Plus, no longer used by WMATA.

## Callback methods

### `stations`

[WMATA Documentation][stations]  
Stations along this Line

```swift
Line.RD.stations(key: apiKey) { result in
    switch result {
    case let .success(stations):
        print(stations)

    case let .failure(error):
        print(error)
    }
}
```

## Combine Publisher methods
These methods access the WMATA API and return your result via a Combine [`Publisher`][publisher]. In modern projects, these methods should be your goto. Combine Publishers can't be used in the background. For more details on using Combine with WMATA.swift, check the [Combine][combine-docs] documentation.

### `stationsPublisher`

[WMATA Documentation][stations]
Stations along this Line

```swift
let cancellable = Line.RD
    .stationsPublisher(key: apiKey)
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

## Additional values

### `name`
The human presentable name of this line in English.

```swift
Line.RD.name == "Red" // true
```

### `current`
If this line is currently used by WMATA. True for all lines except `.YLRP`

```swift
Line.GR.current // true
```

[stations]: https://developer.wmata.com/docs/services/5476364f031f590f38092507/operations/5476364f031f5909e4fe3311
[combine-docs]: https://github.com/emma-k-alexandra/WMATA.swift/blob/master/Documentation/Combine.md
[publisher]: https://developer.apple.com/documentation/combine/publisher
