import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WMATA_swiftTests.allTests),
    ]
}
#endif
