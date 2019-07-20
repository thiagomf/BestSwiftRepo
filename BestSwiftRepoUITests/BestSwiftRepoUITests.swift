//
//  BestSwiftRepoUITests.swift
//  BestSwiftRepoUITests
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import Foundation
import XCTest
import UIKit
import KIF
import Nimble

@testable import BestSwiftRepo

class BestSwiftRepoUITests: KIFTestCase {

    var viewController: RepoViewController!
    
    override func setUp() {
        super.setUp()
        
        KIFEnableAccessibility()
        XCUIApplication().launch()
        
    }

    func testSwipe() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //tentei fazer com KIF mas por algum motivo dá KIF fails to find accessibility labels talvez seja por causa da versão ios 12
        let tableviewrepoTable = XCUIApplication().tables["tableViewRepo"]
        for _ in 1...40 {
            tableviewrepoTable.swipeUp()
        }
    }
}
