//
//  MenuButton.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/16/21.
//

import Foundation
import UIKit

public class MenuButton: UIButton {
    
    private var layout = true
    private var menuHidden = true
    
    let SIZE_RATIO: CGFloat = 0.5
    let CORNER_RADIUS: CGFloat = 10.0
    let PADDING: CGFloat = 10.0
    
    var menuOne: UIButton!
    var menuTwo: UIButton!
    var menuThree: UIButton!
    
    public override func layoutSubviews() {
        
        //Prevents view from adding same views multiple times
        if(layout) {
            layout = false
            
            self.backgroundColor = .black
            self.layer.cornerRadius = self.frame.width / 2
            self.setTitle("+", for: .normal)
            self.setTitleColor(.white, for: .normal)
            self.clipsToBounds = false
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.6
            self.layer.shadowColor = UIColor.darkGray.cgColor
            self.layer.zPosition = 10
            
            menuOne = UIButton(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height))
            menuOne.backgroundColor = .black
            menuOne.layer.cornerRadius = menuOne.frame.width / 2
            menuOne.setTitle("1", for: .normal)
            menuOne.setTitleColor(.white, for: .normal)
            menuOne.clipsToBounds = false
            menuOne.layer.shadowRadius = 5
            menuOne.layer.shadowOpacity = 0.6
            menuOne.layer.shadowColor = UIColor.darkGray.cgColor
            menuOne.layer.zPosition = 0
            menuOne.isEnabled = false
            self.superview?.addSubview(menuOne)
            
            menuTwo = UIButton(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height))
            menuTwo.backgroundColor = .black
            menuTwo.layer.cornerRadius = menuTwo.frame.width / 2
            menuTwo.setTitle("2", for: .normal)
            menuTwo.setTitleColor(.white, for: .normal)
            menuTwo.clipsToBounds = false
            menuTwo.layer.shadowRadius = 5
            menuTwo.layer.shadowOpacity = 0.6
            menuTwo.layer.shadowColor = UIColor.darkGray.cgColor
            menuTwo.layer.zPosition = 0
            menuTwo.isEnabled = false
            self.superview?.addSubview(menuTwo)
            
            menuThree = UIButton(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: self.frame.width, height: self.frame.height))
            menuThree.backgroundColor = .black
            menuThree.layer.cornerRadius = menuThree.frame.width / 2
            menuThree.setTitle("3", for: .normal)
            menuThree.setTitleColor(.white, for: .normal)
            menuThree.clipsToBounds = false
            menuThree.layer.shadowRadius = 5
            menuThree.layer.shadowOpacity = 0.6
            menuThree.layer.shadowColor = UIColor.darkGray.cgColor
            menuThree.layer.zPosition = 0
            menuThree.isEnabled = false
            self.superview?.addSubview(menuThree)
            
        }
        
    }
    
    public func showMenu() {
        
        if(menuHidden) {
            
            menuHidden = false
            
            UIView.animate(withDuration: 0.36, delay: 0.0, options: [], animations: {
                self.menuOne.frame = CGRect(x: self.menuOne.frame.minX, y: self.menuOne.frame.minY - 60, width: self.menuOne.frame.width, height: self.menuOne.frame.height)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.42, delay: 0.0, options: [], animations: {
                self.menuTwo.frame = CGRect(x: self.menuTwo.frame.minX, y: self.menuTwo.frame.minY - 120, width: self.menuTwo.frame.width, height: self.menuTwo.frame.height)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.48, delay: 0.0, options: [], animations: {
                self.menuThree.frame = CGRect(x: self.menuThree.frame.minX, y: self.menuThree.frame.minY - 180, width: self.menuThree.frame.width, height: self.menuThree.frame.height)
            }, completion: nil)
            
            menuOne.isEnabled = true
            menuTwo.isEnabled = true
            menuThree.isEnabled = true
            
        }else{
            
            menuHidden = true
            
            UIView.animate(withDuration: 0.36, delay: 0.0, options: [], animations: {
                self.menuOne.frame = CGRect(x: self.menuOne.frame.minX, y: self.menuOne.frame.minY + 60, width: self.menuOne.frame.width, height: self.menuOne.frame.height)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.42, delay: 0.0, options: [], animations: {
                self.menuTwo.frame = CGRect(x: self.menuTwo.frame.minX, y: self.menuTwo.frame.minY + 120, width: self.menuTwo.frame.width, height: self.menuTwo.frame.height)
            }, completion: nil)
            
            UIView.animate(withDuration: 0.48, delay: 0.0, options: [], animations: {
                self.menuThree.frame = CGRect(x: self.menuThree.frame.minX, y: self.menuThree.frame.minY + 180, width: self.menuThree.frame.width, height: self.menuThree.frame.height)
            }, completion: nil)
            
            menuOne.isEnabled = false
            menuTwo.isEnabled = false
            menuThree.isEnabled = false
            
        }
        
        //Code to make a button wiggle
        /*UIView.animate(withDuration: 0.1, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.menuOne.frame = CGRect(x: self.menuOne.frame.minX - 5, y: self.menuOne.frame.minY + 5, width: self.menuOne.frame.width, height: self.menuOne.frame.height)
        }, completion: nil)*/
        
    }
    
}
