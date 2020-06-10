//
//  PickerInputProtocols.swift
//  TextFieldPickerInput
//
//  Created by Omran Aleid on 2020-05-14.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

public typealias SelectHandler = (_ selected: [Int: Selectable]) -> Void

public protocol Selectable {
    var selectableText: String { get }
    var selectableValue: Any { get }
}

extension UITextField {
    
    public var pickerInputView: PickerInputView? {
        return self.inputView as? PickerInputView
    }

    public func loadPicker(data: [Int: [Selectable]],
                           overlayedView: UIView? = nil,
                           onSelect: SelectHandler? = nil,
                           onDone: SelectHandler? = nil) {
        
        _ = PickerInputView(pickerData: data,
                            textField: self,
                            onSelect: onSelect,
                            onDone: onDone,
                            overlayedView: overlayedView)
    }
    
    public func updatePickerInput(with settings: PickerInputSettings) {
        guard let pickerInput = self.inputView as? PickerInputView else { return }
        pickerInput.updatePickerInput(with: settings)
    }
    
    public func updatePickerInput(with data: [Int: [Selectable]]) {
        guard let pickerInput = self.inputView as? PickerInputView else { return }
        pickerInput.updatePickerInput(with: data)
    }
    
    public func updatePickerInput(with componentData: [Selectable], component: Int) {
        guard let pickerInput = self.inputView as? PickerInputView else { return }
        pickerInput.updatePickerInput(with: componentData, component: component)
    }
    
    public var pickerInputOverlayView: UIView? {
        guard let container = self.pickerInputView?.overlayedView else { return nil }
        return PickerInputUIHelper.overlayView(for: container)
    }
}
