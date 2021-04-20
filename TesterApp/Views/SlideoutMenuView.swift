//
//  SlideoutMenuView.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/12/21.
//

import Foundation
import UIKit

protocol SlideoutMenuDelegate: class {
    func menuItemSelected(index: Int)
}

private enum State {
    case open
    case closed
}

extension State {
    var opposite: State {
        switch self {
        case .open:
            return .closed
        case .closed:
            return .open
        }
    }
}

public class SlideoutMenuView: UIView {
    
    private let PADDING: CGFloat = 10
    
    weak var delegate: SlideoutMenuDelegate?
    
    private var layout = true
    private var animationProgress: CGFloat = 0.0
    private var currentState: State = .closed
    
    private var panGestureRecognizer: InstantPanGestureRecognizer!
    private var transitionAnimator: UIViewPropertyAnimator!
    
    private var tableView: UITableView!
    private var elements: [String] = []
    
    public init(frame: CGRect, elements: [String]) {
        super.init(frame: frame)
        self.elements = elements
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        
        //Prevents view from adding same views multiple times
        if(layout) {
            layout = false
            
            self.backgroundColor = UIColor(red: 3/255, green: 252/255, blue: 182/255, alpha: 1)
            self.clipsToBounds = true
            
            panGestureRecognizer = InstantPanGestureRecognizer(target: self, action: #selector(viewPanned))
            self.addGestureRecognizer(panGestureRecognizer)
            
            let titleLabel = UILabel(frame: CGRect(x: PADDING, y: PADDING, width: self.bounds.width - (PADDING * 2), height: 25))
            titleLabel.text = "Menu Title"
            titleLabel.textAlignment = .center
            self.addSubview(titleLabel)
            
            beginBubbles()
            
            tableView = UITableView(frame: CGRect(x: PADDING, y: titleLabel.frame.maxY + PADDING, width: self.bounds.width - (PADDING * 2), height: 400))
            tableView.backgroundColor = .clear
            tableView.delegate = self
            tableView.dataSource = self
            self.addSubview(tableView)
            tableView.reloadData()
        }
        
    }
    
    @objc private func viewPanned(recognizer: InstantPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            toggle()
            animationProgress = transitionAnimator.fractionComplete
            transitionAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: self)
            var fraction = translation.x / self.frame.width
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let xVelocity = recognizer.velocity(in: self).x
            let shouldClose = xVelocity < 0
            if(xVelocity == 0) {
                transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            switch currentState {
            case .open:
                if !shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            case .closed:
                if shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if !shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            }
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            break
        }
    }
    
    public func beginBubbles() {
        generateBubble()
        generateBubble()
        generateBubble()
    }
    
    private func generateBubble() {
        let x = CGFloat.random(in: 0 ..< self.bounds.maxX)
        let size = CGFloat.random(in: 10 ..< 75)
        let bubble1 = UIView(frame: CGRect(x: x, y: self.bounds.maxY - size, width: size, height: size))
        bubble1.layer.cornerRadius = size / 2
        bubble1.backgroundColor = UIColor(red: 2/255, green: 235/255, blue: 169/255, alpha: 0.9)
        self.addSubview(bubble1)
        
        let duration = Double.random(in: 9.86 ..< 18.52)
        let delay = Double.random(in: 0.0 ..< 1.345)
        UIView.animate(withDuration: duration, delay: delay, options: [], animations: {
            let choice = Int.random(in: 0 ... 1)
            if(choice == 0) {
                let y = CGFloat.random(in: 0 ..< self.bounds.maxY)
                bubble1.frame = CGRect(x: self.bounds.maxX + bubble1.frame.width, y: y, width: bubble1.frame.width, height: bubble1.frame.height)
            }else{
                let x = CGFloat.random(in: 0 ..< self.bounds.maxX)
                bubble1.frame = CGRect(x: x, y: self.bounds.minY - bubble1.frame.width, width: bubble1.frame.width, height: bubble1.frame.height)
            }
        }, completion: { [weak self] _ in
            bubble1.removeFromSuperview()
            self?.generateBubble()
        })
    }
    
    /*public func toggle() {
        if(self.frame.minX == 0) {
            UIView.animate(withDuration: 0.25, animations: {
                self.frame = CGRect(x: self.frame.width * -1, y: self.PADDING, width: self.frame.width, height: self.frame.height)
                //self.window?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.frame = CGRect(x: 0, y: self.PADDING, width: self.frame.width, height: self.frame.height)
                //self.window?.frame = CGRect(x: self.frame.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            })
        }
    }*/
    
    public func toggle() {
        let state = currentState.opposite
        transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.frame = CGRect(x: 0, y: self.PADDING, width: self.frame.width, height: self.frame.height)
            case .closed:
                self.frame = CGRect(x: self.frame.width * -1, y: self.PADDING, width: self.frame.width, height: self.frame.height)
            }
        })
        transitionAnimator.addCompletion({ position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            default:
                break
            }
        })
        transitionAnimator.startAnimation()
    }
    
}

//MARK: TableView Functions

extension SlideoutMenuView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.backgroundColor = .clear
        cell.textLabel?.text = elements[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(elements[indexPath.row] + " Selected!")
        
    }
    
}
