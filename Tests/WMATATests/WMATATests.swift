import Combine
import Foundation
import GTFS
import DVR
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

class TestJSONDelegate<Parent: JSONEndpoint>: JSONEndpointDelegate<Parent> {
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    override func received(_ response: Result<Parent.Response, WMATAError>) {
        switch response {
        case .success:
            expectation.fulfill()
        case let .failure(error):
            print(error)
            XCTFail()
        }
    }
}

class TestGTFSDelegate<Parent: GTFSEndpoint>: GTFSEndpointDelegate<Parent> {
    let expectation: XCTestExpectation

    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }

    override func received(_ response: Result<Parent.Response, WMATAError>) {
        switch response {
        case .success:
            expectation.fulfill()

        case let .failure(error):
            print(error)
            XCTFail()
        }
    }
}

class DVRTestCase: XCTestCase {
    lazy var session = {
        Session(
            outputDirectory: URL(fileURLWithPath: #file)
                .pathComponents
                .dropLast()
                .joined(separator: "/")
                .appending("/Fixtures"),
            cassetteName: name,
            testBundle: .module
        )
    }()
    
    lazy var expectation = {
        self.expectation(description: self.name)
    }()
}

// TODO: Add test for error responses
// TODO: Tests for Decoding
