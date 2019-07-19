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

@testable import BestSwiftRepo

class BestSwiftRepoUITests: KIFTestCase {

    var viewController: RepoViewController!
    
    override func setUp() {
        super.setUp()
        
        KIFEnableAccessibility()
        
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        tester().waitForAnimationsToFinish()
        tester().waitForView(withAccessibilityLabel: "Autor")
    }
}
