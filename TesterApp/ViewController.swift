//
//  ViewController.swift
//  TesterApp
//
//  Created by Joseph Chung on 4/2/21.
//

import UIKit

class ViewController: UIViewController {

    var profilePicView: AnimatedProfilePicView!
    var loadingView: LoadingView!
    var menu: SlideoutMenuView!
    var pullUpMenu: PullUpMenuView!
    
    var submitButton: UIButton!
    var menuButton: MenuButton!
    
    var slideUpGestureRecognizer: UISwipeGestureRecognizer!
    var slideDownGestureRecognizer: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*for _ in 0 ..< 100 {
            let u1 = User.generateRandomUser()
            print(u1.printed())
            print("----------")
        }*/
        
        gestureRecognizerSetup()
        menuSetup()
        pullUpMenuSetup()
        loadingViewSetup()
        profilePicSetup()
        //buttonSetup()
        menuButtonSetup()
    }
    
    private func gestureRecognizerSetup() {
        slideUpGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(slideUp))
        slideUpGestureRecognizer.direction = .up
        self.view.addGestureRecognizer(slideUpGestureRecognizer)
        
        slideDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(slideDown))
        slideDownGestureRecognizer.direction = .down
        self.view.addGestureRecognizer(slideDownGestureRecognizer)
    }
    
    private func menuButtonSetup() {
        menuButton = MenuButton(frame: CGRect(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100, width: 50, height: 50))
        menuButton.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        self.view.addSubview(menuButton)
    }
    
    private func buttonSetup() {
        let y = (UIScreen.main.bounds.height - 50) - 60
        submitButton = UIButton(frame: CGRect(x: 50, y: y, width: UIScreen.main.bounds.width - 100, height: 60))
        submitButton.backgroundColor = .black
        submitButton.setTitleColor(.white, for: .normal)
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(submitButton)
    }
    
    private func profilePicSetup() {
        let wh: CGFloat = 100
        let x = (UIScreen.main.bounds.width / 2) - (wh / 2)
        let y: CGFloat = 100
        profilePicView = AnimatedProfilePicView(frame: CGRect(x: x, y: y, width: wh, height: wh))
        self.view.addSubview(profilePicView)
    }
    
    private func loadingViewSetup() {
        let wh: CGFloat = 50
        let x = (UIScreen.main.bounds.width / 2) - (wh / 2)
        let y = (UIScreen.main.bounds.height / 2) - (wh / 2)
        loadingView = LoadingView(frame: CGRect(x: x, y: y, width: wh, height: wh))
        self.view.addSubview(loadingView)
    }

    private func menuSetup() {
        menu = SlideoutMenuView(frame: CGRect(x: -250, y: 0, width: 250, height: UIScreen.main.bounds.height), elements: ["Home", "Profile", "Settings"])
        menu.delegate = self
        UIApplication.shared.windows.first?.addSubview(menu)
    }
    
    private func pullUpMenuSetup() {
        pullUpMenu = PullUpMenuView(frame: CGRect(x: 0, y: self.view.frame.maxY - 250, width: UIScreen.main.bounds.width, height: 300), elements: ["Home", "Profile", "Settings"])
        self.view.addSubview(pullUpMenu)
    }
    
    @objc private func slideUp() {
        //pullUpMenu.show()
    }
    
    @objc private func slideDown() {
        //pullUpMenu.hide()
    }
    
    @objc func buttonAction(sender: UIButton!) {
        sender.animate()
    }
    
    @objc func menuButtonAction(sender: MenuButton!) {
        sender.showMenu()
    }

    @IBAction func toggle(_ sender: Any) {
        menu.toggle()
    }
    
}

//MARK: SlideOutMenu Delegate Functions

extension ViewController: SlideoutMenuDelegate {
    
    func signOutPressed() {
        print("Sign Out Pressed!")
    }
    
    func helpPressed() {
        print("Help Pressed!")
    }
    
    func becomeTechnicianPressed() {
        print("Become Technician Pressed!")
    }
    
    func menuItemSelected(index: Int) {
        print("Index Selected: " + String(index))
    }
    
}
