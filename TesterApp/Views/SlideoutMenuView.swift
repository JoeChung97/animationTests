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
    func signOutPressed()
    func helpPressed()
    func becomeTechnicianPressed()
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
    
    //Constants
    private let PADDING: CGFloat = 10
    private let BACKGROUND_COLOR = UIColor(red: 3/255, green: 252/255, blue: 182/255, alpha: 1)
    private let BUBBLE_COLOR = UIColor(red: 2/255, green: 235/255, blue: 169/255, alpha: 0.9)
    
    weak var delegate: SlideoutMenuDelegate?
    
    //Layout/Animation helpers
    private var layout = true
    private var animationProgress: CGFloat = 0.0
    private var currentState: State = .closed
    
    private var panGestureRecognizer: InstantPanGestureRecognizer!
    private var transitionAnimator: UIViewPropertyAnimator!
    
    //UI Components
    private var tableView: UITableView!
    private var profileImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var signOutButton: UIButton!
    private var helpButton: UIButton!
    private var becomeTechnicianButton: UIButton!
    
    //Array of menu selection elements
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
            
            self.backgroundColor = BACKGROUND_COLOR
            self.clipsToBounds = true
            
            panGestureRecognizer = InstantPanGestureRecognizer(target: self, action: #selector(viewPanned))
            panGestureRecognizer.cancelsTouchesInView = false
            panGestureRecognizer.delegate = self
            self.addGestureRecognizer(panGestureRecognizer)
            
            beginBubbles()
            
            let closeButton = UIButton(frame: CGRect(x: (PADDING * 2), y: (PADDING * 2), width: 20, height: 20))
            closeButton.layer.cornerRadius = closeButton.frame.height / 2
            closeButton.backgroundColor = .clear
            closeButton.layer.borderWidth = 2
            closeButton.layer.borderColor = UIColor.white.cgColor
            closeButton.setTitleColor(.white, for: .normal)
            closeButton.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            closeButton.setTitle("X", for: .normal)
            self.addSubview(closeButton)
            
            profileImageView = UIImageView(frame: CGRect(x: PADDING, y: (PADDING * 6), width: 50, height: 50))
            profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
            profileImageView.backgroundColor = .white
            self.addSubview(profileImageView)
            
            usernameLabel = UILabel(frame: CGRect(x: profileImageView.frame.maxX + PADDING, y: (PADDING * 6), width: 200, height: 50))
            usernameLabel.textColor = .white
            usernameLabel.font = UIFont.systemFont(ofSize: 12)
            usernameLabel.textAlignment = .left
            usernameLabel.text = "Username"
            self.addSubview(usernameLabel)
            
            tableView = UITableView(frame: CGRect(x: PADDING, y: profileImageView.frame.maxY + (PADDING * 4), width: self.bounds.width - (PADDING * 2), height: 400))
            tableView.backgroundColor = .clear
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
            self.addSubview(tableView)
            tableView.reloadData()
            
            let signOutImageView = UIImageView(frame: CGRect(x: PADDING, y: UIScreen.main.bounds.maxY - (PADDING * 5), width: 20, height: 20))
            signOutImageView.layer.cornerRadius = signOutImageView.bounds.height / 2
            signOutImageView.backgroundColor = .white
            self.addSubview(signOutImageView)
            
            signOutButton = UIButton(frame: CGRect(x: signOutImageView.frame.maxX + PADDING, y: UIScreen.main.bounds.maxY - (PADDING * 5), width: 50, height: 20))
            signOutButton.setTitleColor(.white, for: .normal)
            signOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            signOutButton.setTitle("Sign Out", for: .normal)
            signOutButton.addTarget(self, action: #selector(signOutPressed), for: .touchUpInside)
            self.addSubview(signOutButton)
            
            helpButton = UIButton(frame: CGRect(x: PADDING, y: signOutImageView.frame.minY - (PADDING + 20), width: 50, height: 20))
            helpButton.setTitleColor(.white, for: .normal)
            helpButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            helpButton.contentHorizontalAlignment = .left
            helpButton.setTitle("Help", for: .normal)
            helpButton.addTarget(self, action: #selector(helpPressed), for: .touchUpInside)
            self.addSubview(helpButton)
            
            becomeTechnicianButton = UIButton(frame: CGRect(x: PADDING, y: helpButton.frame.minY - (PADDING + 20), width: 200, height: 20))
            becomeTechnicianButton.setTitleColor(.white, for: .normal)
            becomeTechnicianButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            becomeTechnicianButton.contentHorizontalAlignment = .left
            becomeTechnicianButton.setTitle("Become a Company Technician", for: .normal)
            becomeTechnicianButton.addTarget(self, action: #selector(becomeTechnicianPressed), for: .touchUpInside)
            self.addSubview(becomeTechnicianButton)
            
        }
        
    }
    
    //Handles animations and menu state when view is panned
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
        generateBubble()
        generateBubble()
    }
    
    //Creates a floating "Bubble"
    //Spawns at random x point below menu
    //When "Bubble" gets out of view, it is removed and respawns a new one
    private func generateBubble() {
        let x = CGFloat.random(in: 0 ..< self.bounds.maxX)
        let size = CGFloat.random(in: 10 ..< 75)
        let bubble1 = UIView(frame: CGRect(x: x, y: self.bounds.maxY + size, width: size, height: size))
        bubble1.layer.zPosition = -100
        bubble1.layer.cornerRadius = size / 2
        bubble1.backgroundColor = BUBBLE_COLOR
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
    
    //Either closes or opens menu depending on current state
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
    
    //MARK: Delegate Button Actions
    
    @objc private func becomeTechnicianPressed(sender: UIButton) {
        toggle()
        delegate?.becomeTechnicianPressed()
    }
    
    @objc private func helpPressed(sender: UIButton) {
        toggle()
        delegate?.helpPressed()
    }
    
    @objc private func signOutPressed(sender: UIButton) {
        toggle()
        delegate?.signOutPressed()
    }
    
}

//MARK: TableView Functions

extension SlideoutMenuView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
        cell.backgroundColor = .clear
        cell.menuTitleLabel.text = elements[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuItemSelected(index: indexPath.row)
    }
    
}


//MARK: Gesture Recognizer Delegate

extension SlideoutMenuView: UIGestureRecognizerDelegate {
    
    //Allows user to press menu buttons without triggering gesture recognizer
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if((touch.view?.isDescendant(of: signOutButton) ?? false) ||
            (touch.view?.isDescendant(of: helpButton) ?? false) ||
            (touch.view?.isDescendant(of: becomeTechnicianButton) ?? false)) {
            return false
        }
        
        return true
    }
    
}
