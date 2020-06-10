//
//  PickerInputUIHelper.swift
//  UITextFieldPickerInput
//
//  Created by Omran Aleid on 2020-06-10.
//  Copyright © 2020 Omran Aleid. All rights reserved.
//

import UIKit

class PickerInputUIHelper {
        
    internal static func addOverlay(_ view: UIView?) {
        let screenRect = UIScreen.main.bounds
        let coverView = UIView(frame: screenRect)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        coverView.tag = PickerInputConstants.overlayViewTag.rawValue
        view?.translatesAutoresizingMaskIntoConstraints = false
        view?.addSubview(coverView)
    }
    
    internal static func removeOverlay(_ view: UIView?) {
        view?.subviews.filter {$0.tag == PickerInputConstants.overlayViewTag.rawValue}.forEach {
            $0.removeFromSuperview()
        }
    }
    
    internal static func updateOverlayView(for view: UIView, backgroundColor: UIColor) {
        guard let overlayView = overlayView(for: view) else { return }
        overlayView.backgroundColor = backgroundColor
    }
    
    internal static func overlayView(for view: UIView?) -> UIView? {
        guard let view = view else { return nil }
        return view.subviews.filter({$0.tag == PickerInputConstants.overlayViewTag.rawValue}).first
    }
}
