# Making Background Requests

## `WMATADelegate`

Background requests can be made using a`WMATADelegate` on `MetroRail` or `MetroBus`. First, create a class implementing `WMATADelegate`:

```swift
import WMATA

class Delegate: WMATADelegate {

}
```

Then implement the `received` method for whichever method you plan on calling on the `MetroBus` or `MetroRail` object this delegate belongs to. For example, if yoy plan on calling `lines` on `MetroRail`, implement `received(linesResponse:)` on your delegate.

```swift
class Delegate: WMATADelegate {
    func received(linesResponse result: Result<LinesResponse, WMATAError>) {
        switch result {
        case let .success(lines):
            print(lines)

        case let .failure(error):
            print(error)
        }
    }
}
```

Finally, create a `MetroBus` or `MetroRail` instance with an instance of your delegate and make requests!

```swift
let delegate = Delegate()
let metroRail = MetroRail(key: apiKey, delegate: delegate)

metroRail.lines()
```

### App Extensions
If you want to use a `WMATADelegate` for background requests within an app extension, you'll need to provide a unique identifier to `MetroRail` or `MetroBus` via the `sharedContainerIdentifier` constructor parameter. See [Apple's `URLSessionConfiguration` docs][url-session-configuration] for details.

[url-session-configuration]: https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1409450-sharedcontaineridentifier
