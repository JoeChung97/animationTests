//
//  LoadingView.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/15/21.
//

import Foundation
import UIKit

public class LoadingView: UIView {
    
    private var layout = true
    
    let BAR_WIDTH: CGFloat = 5.0
    let BAR_HEIGHT_RATIO: CGFloat = 0.75
    let CORNER_RADIUS: CGFloat = 10.0
    let PADDING: CGFloat = 10.0
    
    private var topBar: UIView!
    private var rightTopAngledBar: UIView!
    private var rightBar: UIView!
    private var rightBottomAngledBar: UIView!
    private var bottomBar: UIView!
    private var leftBottomAngledBar: UIView!
    private var leftBar: UIView!
    private var leftTopAngledBar: UIView!
    
    public override func layoutSubviews() {
        
        //Prevents view from adding same views multiple times
        if(layout) {
            layout = false
            self.backgroundColor = .black
            self.layer.opacity = 0.85
            self.layer.cornerRadius = CORNER_RADIUS
            //self.versionOne()
            //self.versionTwo()
            //self.versionThree()
            self.versionFour()
        }
        
    }
    
    //Three resizing bars to indicate loading
    private func versionOne() {
        let height = self.frame.height * BAR_HEIGHT_RATIO
        let x = (self.frame.width / 2) - (BAR_WIDTH / 2)
        let y = (self.frame.height / 2) - (height / 2)
        let middleBar = UIView(frame: CGRect(x: x, y: y, width: BAR_WIDTH, height: height))
        middleBar.backgroundColor = .blue
        middleBar.layer.cornerRadius = BAR_WIDTH / 2
        self.addSubview(middleBar)
        
        let leftBar = UIView(frame: CGRect(x: x - PADDING, y: y, width: BAR_WIDTH, height: height))
        leftBar.backgroundColor = .blue
        leftBar.layer.cornerRadius = BAR_WIDTH / 2
        self.addSubview(leftBar)
        
        let rightBar = UIView(frame: CGRect(x: x + PADDING, y: y, width: BAR_WIDTH, height: height))
        rightBar.backgroundColor = .blue
        rightBar.layer.cornerRadius = BAR_WIDTH / 2
        self.addSubview(rightBar)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            middleBar.frame = CGRect(x: x, y: y, width: self.BAR_WIDTH, height: height - (height * 0.8))
        }, completion: nil)
        
        UIView.animate(withDuration: 0.69, delay: 0.1, options: [.repeat, .autoreverse], animations: {
            leftBar.frame = CGRect(x: x - self.PADDING, y: y, width: self.BAR_WIDTH, height: height - (height * 0.6))
        }, completion: nil)
        
        UIView.animate(withDuration: 0.83, delay: 0.05, options: [.repeat, .autoreverse], animations: {
            rightBar.frame = CGRect(x: x + self.PADDING, y: y, width: self.BAR_WIDTH, height: height - (height * 0.73))
        }, completion: nil)
    }
    
    //Two circle "ripples" that move to indicate loading
    private func versionTwo() {
        
        let wh = self.frame.height * 0.1
        let x = (self.frame.width / 2) - (wh / 2)
        let y = (self.frame.height / 2) - (wh / 2)
        let circle = UIView(frame: CGRect(x: x, y: y, width: wh, height: wh))
        circle.layer.cornerRadius = wh / 2
        circle.backgroundColor = .clear
        circle.layer.borderWidth = 2.5
        circle.layer.borderColor = UIColor.red.cgColor
        self.addSubview(circle)
        
        let wh2 = self.frame.height * 0.1
        let x2 = (self.frame.width / 2) - (wh2 / 2)
        let y2 = (self.frame.height / 2) - (wh2 / 2)
        let circle2 = UIView(frame: CGRect(x: x2, y: y2, width: wh2, height: wh2))
        circle2.layer.cornerRadius = wh2 / 2
        circle2.backgroundColor = .clear
        circle2.layer.borderWidth = 2.5
        circle2.layer.borderColor = UIColor.blue.cgColor
        self.addSubview(circle2)
        
        UIView.animate(withDuration: 1.5, delay: 0.0, options: [.repeat], animations: {
            circle.bounds = CGRect(x: x, y: y, width: 50, height: 50)
            circle.layer.cornerRadius = circle.frame.width / 2
            circle.layer.opacity = 0
        }, completion: nil)
        
        UIView.animate(withDuration: 1.93, delay: 0.1, options: [.repeat], animations: {
            circle2.bounds = CGRect(x: x2, y: y2, width: 50, height: 50)
            circle2.layer.cornerRadius = circle2.frame.width / 2
            circle2.layer.opacity = 0
        }, completion: nil)
        
    }
    
    //Three circles that move up and down to indicate loading
    private func versionThree() {
        
        let wh: CGFloat = 5
        let x = (self.bounds.width / 2) - (wh / 2)
        let y = ((self.bounds.height / 2) - (wh / 2)) - 10
        let middleCircle = UIView(frame: CGRect(x: x, y: y, width: wh, height: wh))
        middleCircle.layer.cornerRadius = wh / 2
        middleCircle.backgroundColor = .white
        self.addSubview(middleCircle)
        
        let leftCircle = UIView(frame: CGRect(x: x - 10, y: y, width: wh, height: wh))
        leftCircle.layer.cornerRadius = wh / 2
        leftCircle.backgroundColor = .white
        self.addSubview(leftCircle)
        
        let rightCircle = UIView(frame: CGRect(x: x + 10, y: y, width: wh, height: wh))
        rightCircle.layer.cornerRadius = wh / 2
        rightCircle.backgroundColor = .white
        self.addSubview(rightCircle)
        
        UIView.animate(withDuration: 0.67, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            middleCircle.frame = CGRect(x: middleCircle.frame.minX, y: middleCircle.frame.minY + 20, width: wh, height: wh)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.92, delay: 0.03, options: [.repeat, .autoreverse], animations: {
            leftCircle.frame = CGRect(x: leftCircle.frame.minX, y: leftCircle.frame.minY + 20, width: wh, height: wh)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.69, delay: 0.12, options: [.repeat, .autoreverse], animations: {
            rightCircle.frame = CGRect(x: rightCircle.frame.minX, y: rightCircle.frame.minY + 20, width: wh, height: wh)
        }, completion: nil)
        
    }
    
    private func versionFour() {
        
        let height = self.frame.height * 0.25
        let x = (self.frame.width / 2) - (2.5 / 2)
        let y: CGFloat = 10
        topBar = UIView(frame: CGRect(x: x, y: y, width: 2.5, height: height))
        topBar.backgroundColor = .blue
        topBar.layer.cornerRadius = 2.5 / 2
        self.addSubview(topBar)
        
        rightTopAngledBar = UIView(frame: CGRect(x: x + 8, y: y + 2.5, width: 2.5, height: height))
        rightTopAngledBar.backgroundColor = .blue
        rightTopAngledBar.layer.cornerRadius = 2.5 / 2
        rightTopAngledBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        self.addSubview(rightTopAngledBar)
        
        rightBar = UIView(frame: CGRect(x: x + 10, y: y + 10, width: 2.5, height: height))
        rightBar.backgroundColor = .blue
        rightBar.layer.cornerRadius = 2.5 / 2
        rightBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.addSubview(rightBar)
        
        rightBottomAngledBar = UIView(frame: CGRect(x: x + 8, y: y + 18, width: 2.5, height: height))
        rightBottomAngledBar.backgroundColor = .blue
        rightBottomAngledBar.layer.cornerRadius = 2.5 / 2
        rightBottomAngledBar.transform = CGAffineTransform(rotationAngle: (3 * CGFloat.pi) / 4)
        self.addSubview(rightBottomAngledBar)
        
        bottomBar = UIView(frame: CGRect(x: x, y: y + 21, width: 2.5, height: height))
        bottomBar.backgroundColor = .blue
        bottomBar.layer.cornerRadius = 2.5 / 2
        self.addSubview(bottomBar)
        
        leftBottomAngledBar = UIView(frame: CGRect(x: x - 8, y: y + 18, width: 2.5, height: height))
        leftBottomAngledBar.backgroundColor = .blue
        leftBottomAngledBar.layer.cornerRadius = 2.5 / 2
        leftBottomAngledBar.transform = CGAffineTransform(rotationAngle: (5 * CGFloat.pi) / 4)
        self.addSubview(leftBottomAngledBar)
        
        leftBar = UIView(frame: CGRect(x: x - 10, y: y + 10, width: 2.5, height: height))
        leftBar.backgroundColor = .blue
        leftBar.layer.cornerRadius = 2.5 / 2
        leftBar.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.addSubview(leftBar)
        
        leftTopAngledBar = UIView(frame: CGRect(x: x - 8, y: y + 2.5, width: 2.5, height: height))
        leftTopAngledBar.backgroundColor = .blue
        leftTopAngledBar.layer.cornerRadius = 2.5 / 2
        leftTopAngledBar.transform = CGAffineTransform(rotationAngle: (7 * CGFloat.pi) / 4)
        self.addSubview(leftTopAngledBar)
        
        beginAnimationChain()
        
    }
    
    func beginAnimationChain() {
        let height = self.frame.height * 0.25
        let x = (self.frame.width / 2) - (2.5 / 2)
        let y: CGFloat = 10
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.topBar.frame = CGRect(x: x, y: y - 5, width: 2.5, height: height)
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.topBar.frame = CGRect(x: x, y: y, width: 2.5, height: height)
            }, completion: {_ in
                self.animationStepTwo()
            })
        })
    }
    
    func animationStepTwo() {
        let height = self.frame.height * 0.25
        let x = (self.frame.width / 2) - (2.5 / 2)
        let y: CGFloat = 10
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.rightTopAngledBar.transform = CGAffineTransform(translationX: -5, y: -5)
        }, completion: {_ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.rightTopAngledBar.transform = CGAffineTransform(translationX: 5, y: 5)
                //self.rightTopAngledBar.frame.
            }, completion: {_ in
                self.beginAnimationChain()
            })
        })
    }
    
}
