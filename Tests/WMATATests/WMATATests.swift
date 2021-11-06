import Combine
import Foundation
import GTFS
@testable import WMATA
import XCTest

let TEST_API_KEY = "9e38c3eab34c4e6c990828002828f5ed" // Get your own @ https://developer.wmata.com using this one will probably result in some weird behavior


class CombineTests: XCTestCase {
    // Thanks to eskimo for this solution
    // https://developer.apple.com/forums/thread/121814?answerId=378975022#378975022
    var deferredCancellables = [AnyCancellable]()

    func deferCancellable(_ cancellable: AnyCancellable) {
        deferredCancellables.append(cancellable)
    }

    override func tearDown() {
        deferredCancellables.removeAll()
    }
}

func waitFor<Response>(_ expectation: XCTestExpectation, for result: Result<Response, WMATAError>)
where
    Response: Codable
{
    switch result {
    case .success:
        expectation.fulfill()

    case let .failure(error):
        print(error)
    }
}
