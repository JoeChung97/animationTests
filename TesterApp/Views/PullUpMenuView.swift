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

public class PullUpMenuView: UIView {
    
    private var layout = true
    private let PADDING: CGFloat = 10
    private let CORNER_RADIUS: CGFloat = 15
    private let OPACITY: Float = 0.8
    private var animationProgress: CGFloat = 0.0
    private var currentState: State = .open
    
    private var panGestureRecognizer: InstantPanGestureRecognizer!
    private var transitionAnimator: UIViewPropertyAnimator!
    
    private var titleLabel: UILabel!
    
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
            
            panGestureRecognizer = InstantPanGestureRecognizer(target: self, action: #selector(viewPanned))
            self.addGestureRecognizer(panGestureRecognizer)
            
            let dragBar = UIView(frame: CGRect(x: (self.bounds.width / 2) - 25, y: 15, width: 50, height: 10))
            dragBar.layer.cornerRadius = 5
            dragBar.backgroundColor = .darkGray
            dragBar.layer.opacity = 0.9
            self.addSubview(dragBar)
            
            titleLabel = UILabel(frame: CGRect(x: PADDING, y: dragBar.frame.maxY + PADDING, width: self.bounds.width - (PADDING * 2), height: 25))
            titleLabel.text = "Options"
            titleLabel.textColor = .white
            titleLabel.textAlignment = .center
            self.addSubview(titleLabel)
            
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
            var fraction = -translation.y / 250
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: self).y
            let shouldClose = yVelocity > 0
            if(yVelocity == 0) {
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
    
    private func toggle() {
        let state = currentState.opposite
        transitionAnimator = UIViewPropertyAnimator(duration: 1, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - (self.frame.height - 50), width: UIScreen.main.bounds.width, height: self.frame.height)
                self.titleLabel.layer.opacity = 1
            case .closed:
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 35, width: UIScreen.main.bounds.width, height: self.frame.height)
                self.titleLabel.layer.opacity = 0
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
