//
//  PickerInputUIHelperTests.swift
//  UITextFieldPickerInputTests
//
//  Created by Omran Aleid on 2020-06-10.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import XCTest
@testable import UITextFieldPickerInput

class PickerInputUIHelperTests: XCTestCase {

    var overlayedView: UIView!
    var textField: UITextField!

    override func setUpWithError() throws {
        overlayedView = UIView()
        textField = UITextField()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddOverlay() {
        XCTAssertNil(PickerInputUIHelper.overlayView(for: overlayedView))
        PickerInputUIHelper.addOverlay(overlayedView)
        XCTAssertNotNil(PickerInputUIHelper.overlayView(for: overlayedView))
    }

    func testRemoveOverlay() {
        XCTAssertNil(PickerInputUIHelper.overlayView(for: overlayedView))
        PickerInputUIHelper.addOverlay(overlayedView)
        XCTAssertNotNil(PickerInputUIHelper.overlayView(for: overlayedView))
        PickerInputUIHelper.removeOverlay(overlayedView)
        XCTAssertNil(PickerInputUIHelper.overlayView(for: overlayedView))
    }
      
    func testUpdateOverlayView() {
        let color: UIColor = .yellow
        PickerInputUIHelper.addOverlay(overlayedView)
        let overlayView = PickerInputUIHelper.overlayView(for: overlayedView)
        XCTAssertNotNil(overlayView)
        XCTAssertNotEqual(overlayView?.backgroundColor, color)
        PickerInputUIHelper.updateOverlayView(for: overlayedView, backgroundColor: color)
        XCTAssertEqual(overlayView?.backgroundColor, color)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
