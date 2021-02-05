#  Using Combine

All structs in WMATA.swift provide Combine Publishers for each API WMATA provides.

## OS Support

While callback and delegate methods are available on all platforms that support a recent verison of Swift, Combine methods are only available in OSes released in 2019 or later. That is, maOS 15 Catalina, iOS 13, watchOS 6 and tvOS 13.

## Publishers

Combine provides many methods on [`Publisher`][publisher] that allow you to modify and use responses from the WMATA without writing much code. Checkout the [Publisher Operators][publisher-operators] documentation if you're not familiar with Combine. Some that I find particularly useful are [`map`][map], [`catch`][catch] and [`assign`][assign]. Combine is generally associated with SwiftUI, but Combine works great with any UI framework you're using.

## Naming

Publisher methods in WMATA.swift have the suffix `Publisher` on the associated callback or delegate method. So, `MetroRail` has a callback method named `nextTrains`, whereas the Publisher method is named `nextTrainsPublisher` and returns the equivalent data.


[publisher]: https://developer.apple.com/documentation/combine/publisher
[publisher-operators]: https://developer.apple.com/documentation/combine/anypublisher-publisher-operators
[map]: https://developer.apple.com/documentation/combine/anypublisher/map(_:)-1mdn8
[catch]: https://developer.apple.com/documentation/combine/anypublisher/catch(_:)
[assign]: https://developer.apple.com/documentation/combine/anypublisher/assign(to:on:)
