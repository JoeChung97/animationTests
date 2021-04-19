//
//  Extensions.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/16/21.
//

import Foundation
import UIKit

extension UIButton {
    
    //Adds a UIActivityIndicator to the center of a button
    func toggleLoadingIndicator() {
        let x = (self.bounds.size.width / 2)
        let y = (self.bounds.size.height / 2)
        let indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: x, y: y)
        indicator.color = .white
        indicator.startAnimating()
        setTitleColor(.clear, for: .normal)
        self.addSubview(indicator)
    }
    
    func animate() {
        
        //Turns button into a circle with a loading indicator
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            self.bounds = CGRect(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.height, height: self.bounds.height)
            self.layer.cornerRadius = self.bounds.height / 2
            self.setTitleColor(.clear, for: .normal)
        }, completion: {_ in
            self.toggleLoadingIndicator()
        })
        
        //Makes button take up whole screen and disappear
        /*UIView.animate(withDuration: 0.25, delay: 0.0, options: [], animations: {
            self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.layer.opacity = 0
        }, completion: nil)*/
        
    }
    
}
