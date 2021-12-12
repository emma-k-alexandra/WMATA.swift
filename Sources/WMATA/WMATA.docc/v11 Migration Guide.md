# v11 Migration Guide

WMATA.swift v11 is a complete overhaul of the package. Likely, all previous code will need to be reworked.

Majors changes were made to the package in order to vastly simplify the code base. I think you'll find the new structure of the package to be much simpler to use and matches your workflow better.

If you have previously worked with WMATA.swift I recommend reading <doc:Endpoints> to understand the new structure of this package. Instead of using client-like structures like `MetroRail` and `MetroBus`, you now create individual calls with ``Endpoint`` structures. This removes the ability to make requests on structures like ``Stop`` and ``Line``, but greatly simplies the structure of the package.

This update includes the ability to make requests using Swift's async/await concurrency features. This is now the recommended way to make foreground requests. This feature is available for iOS 13, macOS Catalina, watchOS 6 and tvOS 13 or higher. You will need Xcode 13.2 or newer to use this feature with these OSes. Otherwise, you will only be able to target iOS 14, macOS Big Sur, etc or newer.

## Breaking changes

- `MetroRail` and `MetroBus` have been removed.

Use endpoints in ``Rail``, ``Bus``, ``Rail/GTFS`` or ``Bus/GTFS`` instead.

- You can no longer make API calls from ``Station``, ``Line``, ``Stop`` or ``Route`` instances.

Use endpoints in ``Rail``, ``Bus``, ``Rail/GTFS`` or ``Bus/GTFS`` instead.

- ``Stop`` and  ``Route`` are now typealiases for `String` rather than structs.

These structures can no longer be used to make API requests, so they can be much simpler now.

- `WMATADelegate` has been replaced with ``EndpointDelegate``.

Previous, WMATADelegate was overly complicated and unwieldy to use. For information on how to use the new delegate system see <doc:BackgroundRequests>.

- `RadiusAtCoordinates` has been renamed ``WMATALocation``.

- ``WMATAError`` is now an enum.

Error handling has been much improved in v11. Previously, it could be very difficult to detemrine what errors you were actually receiving. Errors should be much clearer now.

- Many response structures have been changed.

Previously, responses were their own, independent structures. Now, they are response structures within an endpoint defined as ``Endpoint/Response``. Hopefully this will keep responses closer to the endpoint they're related to and it's easier to navigate all information related to an API.


## Deprecations

- ``Station`` and ``Line`` enums now use names like ``Station/ballston`` rather than codes.

You can currently still use codes, but they are deprecated and Xcode will assist you in renaming your hardcoded station and line instances. You can get the station code by calling `rawValue` on a `Station` or `Line` instance.
