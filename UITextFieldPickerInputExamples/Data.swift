//
//  Data.swift
//  UITextFieldPickerInputExamples
//
//  Created by Omran Aleid on 2020-06-05.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import Foundation
import UITextFieldPickerInput

struct Cat {
    
    var id: Int
    var name: String
    var extraInfo: String
}

extension Cat: Selectable {
    
    var selectableValue: Any {
        return id
    }
    
    var selectableText: String {
        return name
    }
}

struct Dog {
    
    var id: Int
    var name: String
    var extraInfo: String
}

extension Dog: Selectable {
    
    var selectableValue: Any {
        return id
    }
    
    var selectableText: String {
        return name
    }
}

