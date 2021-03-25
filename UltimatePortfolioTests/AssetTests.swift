//
//  AssetTests.swift
//  UltimatePortfolioTests
//
//  Created by David Hughes on 19/03/2021.
//

import XCTest
@testable import UltimatePortfolio

class AssetTests: XCTestCase {
    func testColorsExist() {
        for colour in Project.colours {
            XCTAssertNotNil(UIColor(named: colour), "Failed to load colour '\(colour)' from asset catalog.")
        }
    }

    func testAwardsJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON.")
    }
}
