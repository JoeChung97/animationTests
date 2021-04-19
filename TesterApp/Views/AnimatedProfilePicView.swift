//
//  AnimatedProfilePicView.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/16/21.
//

import Foundation
import UIKit

/*
 A view with a shadow and ripple effects
 that displays a user's profile picture
 */
public class AnimatedProfilePicView: UIView {
    
    private var layout = true
    
    let SIZE_RATIO: CGFloat = 0.5
    let CORNER_RADIUS: CGFloat = 10.0
    let PADDING: CGFloat = 10.0
    
    public override func layoutSubviews() {
        
        //Prevents view from adding same views multiple times
        if(layout) {
            layout = false
            
            self.layer.cornerRadius = CORNER_RADIUS
            self.clipsToBounds = false
            self.layer.shadowOpacity = 0.8
            self.layer.shadowRadius = 5
            self.layer.shadowColor = UIColor.darkGray.cgColor
            self.backgroundColor = .white
            
            let wh = self.frame.width * SIZE_RATIO
            let x = (self.frame.width / 2) - (wh / 2)
            let y = PADDING
            let imageView = UIImageView(frame: CGRect(x: x, y: y, width: wh, height: wh))
            imageView.layer.cornerRadius = wh / 2
            imageView.backgroundColor = .lightGray
            self.addSubview(imageView)
            
            //Adding ripple effects
            
            let ripple1 = UIView(frame: CGRect(x: x, y: y, width: wh, height: wh))
            ripple1.layer.cornerRadius = wh / 2
            ripple1.layer.borderWidth = 2.5
            ripple1.layer.borderColor = UIColor.black.cgColor
            self.addSubview(ripple1)
            
            let ripple2 = UIView(frame: CGRect(x: x, y: y, width: wh, height: wh))
            ripple2.layer.cornerRadius = wh / 2
            ripple2.layer.borderWidth = 2.5
            ripple2.layer.borderColor = UIColor.black.cgColor
            self.addSubview(ripple2)
            
            UIView.animate(withDuration: 1.5, delay: 0.0, options: .repeat, animations: {
                ripple1.bounds = CGRect(x: x, y: y, width: self.bounds.width, height: self.bounds.height)
                ripple1.layer.opacity = 0
                ripple1.layer.cornerRadius = ripple1.frame.width / 2
            }, completion: nil)
            
            UIView.animate(withDuration: 1.5, delay: 0.69, options: .repeat, animations: {
                ripple2.bounds = CGRect(x: x, y: y, width: self.bounds.width, height: self.bounds.height)
                ripple2.layer.opacity = 0
                ripple2.layer.cornerRadius = ripple2.frame.width / 2
            }, completion: nil)
            
        }
        
    }
    
}
