//
//  PickerInputSettings.swift
//  TextFieldPickerInput
//
//  Created by Omran Aleid on 2020-05-14.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

public struct PickerInputSettings {
    
    public var cancelButtonTitle: String = "Cancel"
    public var doneButtonTitle: String = "Done"
    public var toolBarStyle: UIBarStyle = .black
    public var toolBarIsTranslucent: Bool = true
    public var toolBarTintColor: UIColor = .black
    public var toolBarBarTintColor: UIColor = .lightGray
    public var hideDoneButton: Bool = false
    public var hideCancelButton: Bool = false
    public var isToolBarHidden: Bool = false
    public var hideWhenSelect: Bool = false
    
    public init(cancelButtonTitle: String = "Cancel",
                doneButtonTitle: String = "Done",
                toolBarStyle: UIBarStyle = .black,
                toolBarIsTranslucent: Bool = true,
                toolBarTintColor: UIColor = .black,
                toolBarBarTintColor: UIColor = .lightGray,
                hideDoneButton: Bool = false,
                hideCancelButton: Bool = false,
                isToolBarHidden: Bool = false,
                hideWhenSelect: Bool = false) {
        
        self.cancelButtonTitle = cancelButtonTitle
        self.doneButtonTitle = doneButtonTitle
        self.toolBarStyle = toolBarStyle
        self.toolBarIsTranslucent = toolBarIsTranslucent
        self.toolBarTintColor = toolBarTintColor
        self.toolBarBarTintColor = toolBarBarTintColor
        self.hideDoneButton = hideDoneButton
        self.hideCancelButton = hideCancelButton
        self.isToolBarHidden = isToolBarHidden
        self.hideWhenSelect = hideWhenSelect
    }
}
