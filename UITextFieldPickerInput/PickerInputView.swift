//
//  TrixPicker.swift
//  Trix Calculator
//
//  Created by Omran Aleid on 2020-04-12.
//  Copyright © 2020 Convert Caffeine Into Code. All rights reserved.
//

import UIKit

public class PickerInputView: UIPickerView {
        
    public var pickerData: [Int: [Selectable]] = [:]
    public var textField: UITextField
    private(set) var onSelect: SelectHandler?
    private(set) var onDone: SelectHandler?
    private(set) var selectedValue: [Int: Selectable] = [:]
    private(set) var overlayedView: UIView?
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onPressOverlay))
        return gesture
    }()
    
    public var settings: PickerInputSettings? {
        didSet {
            guard let settings = settings else { return }
            apply(settings: settings)
        }
    }
    
    public lazy var toolBar: UIToolbar = {
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(done))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))

        doneButton.tag = PickerInputConstants.doneBtnTag.rawValue
        cancelButton.tag = PickerInputConstants.cancelBtnTag.rawValue
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }()

    init(pickerData: [Int: [Selectable]],
         textField: UITextField,
         onSelect: SelectHandler? = nil,
         onDone: SelectHandler? = nil,
         overlayedView: UIView? = nil) {
        
        self.textField = textField
        self.pickerData = pickerData
        self.onSelect = onSelect
        self.onDone = onDone
        
        super.init(frame: .zero)
        
        delegate = self
        dataSource = self
        textField.inputView = self
        textField.inputAccessoryView = toolBar
        setDefultValues()
        setOverlay(view: overlayedView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Public
public extension PickerInputView {
    
    func setOverlay(view: UIView?) {
        self.overlayedView = view
        guard let overlayedView = self.overlayedView else { return }
        PickerInputUIHelper.addOverlay(overlayedView)
    }
    
    func updatePickerInput(with settings: PickerInputSettings) {
        self.settings = settings
    }
    
    func updatePickerInput(with data: [Int: [Selectable]]) {
        pickerData = data
        reloadAllComponents()
    }
    
    func updatePickerInput(with componentData: [Selectable], component: Int) {
        guard pickerData.keys.contains(component) else { return }
        pickerData[component] = componentData
        reloadComponent(component)
    }
    
    func dismissPicker() {
        PickerInputUIHelper.removeOverlay(self.overlayedView)
        textField.resignFirstResponder()
    }
}

// MARK: Actions
private extension PickerInputView {
    
    @objc func done() {
        onDone?(selectedValue)
        dismissPicker()
    }
    
    @objc func cancel() {
        dismissPicker()
    }
    
    @objc func onPressOverlay() {
        if settings?.hideWhenTouchOverlay ?? false {
            dismissPicker()
        }
    }
    
    func setDefultValues() {
        pickerData.forEach { (key, value) in
            selectedValue[key] = value.first
        }
    }
    
    func apply(settings: PickerInputSettings) {
            
        if let doneBtn = getItem(for: PickerInputConstants.doneBtnTag.rawValue) {
            doneBtn.title = settings.doneButtonTitle
        }
        
        if let cancelBtn = getItem(for: PickerInputConstants.cancelBtnTag.rawValue) {
            cancelBtn.title = settings.cancelButtonTitle
        }
        
        toolBar.tintColor = settings.toolBarTintColor
        toolBar.barTintColor = settings.toolBarBarTintColor
        toolBar.isTranslucent = settings.toolBarIsTranslucent
        toolBar.barStyle = settings.toolBarStyle
        toolBar.isHidden = settings.isToolBarHidden
        
        if settings.hideDoneButton {
            toolBar.items?.removeAll(where: { (item) -> Bool in
                return item.tag == PickerInputConstants.doneBtnTag.rawValue
            })
        }
        
        if settings.hideCancelButton {
            toolBar.items?.removeAll(where: { (item) -> Bool in
                return item.tag == PickerInputConstants.cancelBtnTag.rawValue
            })
        }
        
        if let overlayView = self.overlayedView {
            PickerInputUIHelper.updateOverlayView(for: overlayView, backgroundColor: settings.overlayViewBackgroundColor)
        }
        
        guard let overlayedView = self.overlayedView,
            let overlayView = PickerInputUIHelper.overlayView(for: overlayedView) else {
                return
        }
        
        settings.hideWhenTouchOverlay ? overlayView.addGestureRecognizer(self.tapGesture) : overlayView.gestureRecognizers?.removeAll()
    }
    
    func getItem(for tag: Int) -> UIBarButtonItem? {
        return toolBar.items?.filter { $0.tag == tag }.first
    }
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension PickerInputView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerData.keys.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        guard pickerData.keys.count > 0, let componentValues = pickerData[component] else { return }
        
        selectedValue[component] = componentValues[row]
        onSelect?(selectedValue)
        
        if settings?.hideWhenSelect ?? false {
            dismissPicker()
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard pickerData.keys.count > 0,
            let componentValues = pickerData[component] else { return ""}
        return componentValues[row].selectableText
    }
}
