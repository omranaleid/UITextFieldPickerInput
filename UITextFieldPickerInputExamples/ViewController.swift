//
//  ViewController.swift
//  UITextFieldPickerInputExamples
//
//  Created by Omran Aleid on 2020-06-05.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit
import UITextFieldPickerInput

class ViewController: UIViewController {
    
    private lazy var textField: UITextField = {
        let tf = UITextField(frame: CGRect(x: 0, y: 0, width: 250, height: 40))
        tf.borderStyle = .roundedRect
        tf.placeholder = "Press me to display picker"
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        textField.center = view.center
        textField.addTarget(self, action: #selector(onTextField), for: .touchDown)
    }

    @objc func onTextField() {
        
        // 1- Create your data
        // all component data should confir to protocol Selectable
        // the structure is [numberOfComponent: [Selectable]]
        let data: [Int: [Selectable]] = [
            0: [Cat(id: 1, name: "cat1", extraInfo: "asdasd"), Cat(id: 2, name: "cat2", extraInfo: "asdasd")],
            1: [Dog(id: 1, name: "dog1", extraInfo: "asdasd"), Dog(id: 2, name: "dog2", extraInfo: "asdasd")]
        ]
        
        // 2- load the picker into your text field by passing the data Dictionary
        // get the selected objects -> [numberOfComponent: selectedValue]
        textField.loadPicker(data: data, onSelect: { [weak self] selected in
            var displayedText = ""
            if let selectedCat = selected[0] as? Cat {
                print(selectedCat.extraInfo)
                print(selectedCat.id)
                print(selectedCat.name)
                displayedText = "Cat: \(selectedCat.name)"
            }
            if let selectedDog = selected[1] as? Dog {
                print(selectedDog.extraInfo)
                print(selectedDog.id)
                print(selectedDog.name)
                displayedText.append(" Dog: \(selectedDog.name)")
            }
            
            self?.textField.text = displayedText
        }) { selectedDone in
            print(selectedDone)
        }
        
//        // 4- you can update the default settings
//        var settings: PickerInputSettings = PickerInputSettings()
//        settings.cancelButtonTitle = "remove"
//
//        textField.updatePickerInput(with: settings)
//
//        // 5- trigger the textFiled becomeFirstResponder to show the picker
//        textField.becomeFirstResponder()
//
//        // 6- try to update the picker data
//        textField.updatePickerInput(with: [Cat(id: 1, name: "updated cat 1", extraInfo: "foo"),
//                                           Cat(id: 2, name: "updated cat 2", extraInfo: "foo")],
//                                    component: 0)
    }
}

