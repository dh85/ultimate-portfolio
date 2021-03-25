//
//  ExtensionTests.swift
//  UltimatePortfolioTests
//
//  Created by David Hughes on 19/03/2021.
//

import SwiftUI
import XCTest
@testable import UltimatePortfolio

class ExtensionTests: XCTestCase {
    private struct Example: Equatable {
        let value: String
    }

    func testSequenceKeyPathSortingSelf() {
        // Given
        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")

        let array = [example2, example3, example1]

        // When
        let sortedArray = array.sorted(by: \.value)

        // Then
        XCTAssertEqual(sortedArray, [example1, example2, example3], "The custom object array must be sorted.")
    }

    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode a non-empty array.")
    }

    func testBindingOnChange() {
        // Given
        var onChangeFunctionRun = false

        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }

        var storedValue = ""

        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleFunctionToCall)

        // When
        changedBinding.wrappedValue = "Test"

        // Then
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function must be run when the binding is changed.")
    }
}
