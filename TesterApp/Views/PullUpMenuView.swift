//
//  PullUpMenuView.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/15/21.
//

import Foundation
import UIKit

protocol PullUpMenuDelegate: class {
    func itemSelected(index: Int)
}

public class PullUpMenuView: UIView {
    
    private var layout = true
    private let PADDING: CGFloat = 10
    private let CORNER_RADIUS: CGFloat = 15
    private let OPACITY: Float = 0.8
    
    private var gestureRecognizer: UITapGestureRecognizer!
    private var dragGestureRecognizer: UISwipeGestureRecognizer!
    
    weak var delegate: PullUpMenuDelegate?
    
    public init(frame: CGRect, elements: [String]) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        
        //Prevents view from adding same views multiple times
        if(layout) {
            layout = false
            
            self.backgroundColor = .black
            self.layer.opacity = OPACITY
            self.layer.cornerRadius = CORNER_RADIUS
            
            gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            self.addGestureRecognizer(gestureRecognizer)
            
            let dragBar = UIView(frame: CGRect(x: (self.bounds.width / 2) - 25, y: 15, width: 50, height: 10))
            dragBar.layer.cornerRadius = 5
            dragBar.backgroundColor = .darkGray
            dragBar.layer.opacity = 0.9
            self.addSubview(dragBar)
            
            let titleLabel = UILabel(frame: CGRect(x: PADDING, y: dragBar.frame.maxY + PADDING, width: self.bounds.width - (PADDING * 2), height: 25))
            titleLabel.text = "Options"
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
            self.addSubview(titleLabel)
            
        }
        
    }
    
    @objc private func viewTapped() {
        hide()
    }
    
    public func toggle() {
        if(self.frame.minY == UIScreen.main.bounds.height) {
            //Menu is hidden
            show()
        }else{
            //Menu is showing
            hide()
        }
    }
    
    public func hide() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: self.frame.height)
        }, completion: nil)
    }
    
    public func show() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - (self.frame.height - 50), width: UIScreen.main.bounds.width, height: self.frame.height)
        }, completion: nil)
    }
    
}

//MARK: Gesture Recognizer Functions

extension PullUpMenuView: UIGestureRecognizerDelegate {
    
    
    
}
