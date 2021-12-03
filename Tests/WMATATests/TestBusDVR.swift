//
//  TestBusDVR.swift
//  
//
//  Created by Emma on 12/2/21.
//

@testable import WMATA
import XCTest
import DVR

class DVRTestCase: XCTestCase {
    lazy var session = {
        Session(
            outputDirectory: URL(fileURLWithPath: #file).pathComponents.dropLast().joined(separator: "/").appending("/Fixtures"),
            cassetteName: name,
            testBundle: .module
        )
    }()
    
    lazy var expectation = {
        self.expectation(description: self.name)
    }()
}

final class TestBusDVR: DVRTestCase {
    func testPositions() {
        let positions = Bus.Positions(key: TEST_API_KEY)
    
        positions.request(with: session) { [weak self] result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.busPositions.count, 0)
                self?.expectation.fulfill()
            case let .failure(error):
                print(error)
            }
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
