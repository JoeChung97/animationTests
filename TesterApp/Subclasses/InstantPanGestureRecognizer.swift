//
//  InstantPanGestureRecognizer.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/20/21.
//

import Foundation
import UIKit.UIGestureRecognizerSubclass

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if(self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
    
}


