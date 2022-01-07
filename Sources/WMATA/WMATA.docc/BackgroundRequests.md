# Background Requests

Calling WMATA APIs while your application is in the background.

## Overview

If you are using WMATA within an application or extension, your application can receive responses from WMATA's API while in the background using a delegate for ``Endpoint``.

Unfortunately, Combine and Swift's Concurrency features cannot be used while your application is in the background (yet).

## Example

First, select an ``Endpoint`` you wish to call in the background. In this example we'll call ``Bus/NextBuses``, which is a Standard API endpoint. We'll need to define a subclass of ``JSONEndpointDelegate`` in order to receive responses from the API.

> Note: If you are calling a Standard API endpoint, subclass ``JSONEndpointDelegate``. If you are calling a GTFS endpoint, subclass ``GTFSEndpointDelegate``.

```swift
class CustomEndpointDelegate: JSONEndpointDelegate<Bus.NextBuses> {
    
}
```

Next, we'll need to override ``EndpointDelegate/received(_:)`` within our delegate in order to receive responses.

```swift
override func received(_ response: Result<Bus.NextBuses.Response, WMATAError>) {
    switch response {
    case let .success(nextBuses):
        print(nextBuses)
    case let .failure(error):
        print(error)
    }
}
```

> Tip: Your `received(_:)` function will receive both successful calls to the API and errors, so be sure to handle both. 

Now we'll create our `CustomEndpointDelegate` instance and our `Endpoint`.

```swift
let delegate = CustomEndpointDelegate()

let endpoint = Bus.NextBuses(
    key: YOUR_API_KEY,
    stop: "1001195",
    delegate: delegate
)
```

> Tip: Be sure to store your delegate in a way that your application maintains a reference to it. Endpoints only maintain weak references to delegates, so if you do not store your delegate on `self` or maintain a reference in some way, your delegate will be deallocated.

Finally, we can make our request. In practice this would happen when your application or extension is in the background.

```swift
endpoint.backgroundRequest()
```

When your application receives a response from the API, `received(_:)` will be called on your delegate.

## Application Extensions

In order to make background requests within an application extension, you must supply a [shared container identifier](https://developer.apple.com/documentation/foundation/urlsessionconfiguration/1409450-sharedcontaineridentifier) to your delegate. This is done with ``EndpointDelegate/sharedContainerIdentifier``. Modifying the example above's custom delegate to include a shared container identifier looks like:

```swift
class CustomEndpointDelegate: JSONEndpointDelegate<Bus.NextBuses> {
    
    override init() {
        super.init()
        
        sharedContainerIdentifier = "com.mycompany.myapp.backgroundsession"
    }
    
    ...
}
```

You can read more about shared container identifiers in the "Performing Uploads and Downloads" section of Apple's [App Extension Programming Guide](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html#//apple_ref/doc/uid/TP40014214-CH21-SW1).
