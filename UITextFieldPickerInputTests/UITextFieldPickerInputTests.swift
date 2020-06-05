//
//  UITextFieldPickerInputTests.swift
//  UITextFieldPickerInputTests
//
//  Created by Omran Aleid on 2020-06-05.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import XCTest
@testable import UITextFieldPickerInput

extension String: Selectable {
    public var selectableText: String {
        return self
    }
    
    public var selectableValue: Any {
        return self
    }
}

class UITextFieldPickerInputTests: XCTestCase {

    var textField: UITextField!
    
    override func setUpWithError() throws {
        textField = UITextField()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDataInput() {
        XCTAssertNil(textField.pickerInputView)
        XCTAssertNil(textField.pickerInputView?.pickerData)
        textField.loadPicker(data: [0: ["first", "second", "third"]])
        XCTAssertNotNil(textField.pickerInputView)
        XCTAssertNotNil(textField.pickerInputView?.pickerData)
    }

    func testActions() {
        XCTAssertNil(textField.pickerInputView?.onDone)
        XCTAssertNil(textField.pickerInputView?.onSelect)
        textField.loadPicker(data: [0: ["first", "second", "third"]], onSelect: { _ in
            print("select")
        }, onDone: { _ in
            print("done")
        })
        XCTAssertNotNil(textField.pickerInputView?.onDone)
        XCTAssertNotNil(textField.pickerInputView?.onSelect)
    }
    
    func testUpdatePickerInputSettings() {
        XCTAssertNil(textField.pickerInputView?.settings)
        textField.loadPicker(data: [0: ["first", "second", "third"]])
        textField.updatePickerInput(with: PickerInputSettings())
        XCTAssertNotNil(textField.pickerInputView?.settings)
    }
    
    func testUpdateData() {
        let originalVal = [0: ["first", "second", "third"]]
        let updatedVal = [0: ["first section"], 1: ["second section"]]
        textField.loadPicker(data: originalVal)
        XCTAssertNotNil(textField.pickerInputView?.pickerData)
        XCTAssertTrue(textField.pickerInputView?.pickerData.keys.count == 1)
        
        textField.updatePickerInput(with: updatedVal)
        XCTAssertNotNil(textField.pickerInputView?.pickerData)
        XCTAssertTrue(textField.pickerInputView?.pickerData.keys.count == 2)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
