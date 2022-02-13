//
//  WelcomeMessageViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 09/01/2022.
//

import UIKit

class WelcomeMessageViewController: UIViewController {
    // of course username comes from previous screen
    var username:String!
    let welcomeLabel:UILabel = UILabel(textColor: .black, font: UIFont(name:"HelveticaNeue-Light", size: screenWidth*(22/390))!, no_lines:2,translatesMaskInConstraints: false)
    var infoWelcomeLabel = UILabel(textColor:.systemGray, font: UIFont(name: "HelveticaNeue", size: screenWidth*(14/390))!,text:"Find people to follow and start sharing photos. You can change your username anytime", textAlignment: .center,no_lines:0, translatesMaskInConstraints: false)
    let nextButton = NextButton()
    @objc let changeUsernameButton:UIButton = {
        let the_button = UIButton(title: "Change Username", titleColor: .InstagramBlue, backgroundColor:.white,font: UIFont(name: "HelveticaNeue-Bold", size: screenWidth*(14/390))!, translatesMaskInConstraints: false)
        return the_button
    }()
    var signIn:UILabel = {
        let label = UILabel(textColor: .lightGray, font: UIFont(name: "HelveticaNeue", size: screenWidth*(13/320))!, textAlignment: .center, translatesMaskInConstraints: false)
        let string = "Already have an account? Sign In"
        // Turn this string into NSMutableAttributedString such that we could mutate the contents of the string
        let attributedText = NSMutableAttributedString(string: string)
        // change "Sign up" part color to blue (start at index 25 and stop at index 32)
        attributedText.addAttribute(.foregroundColor, value: UIColor.InstagramBlue, range: NSRange(location: 25, length: 7))
        // change "Sign up" part font to bold
        // ipod touch width = 320
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: screenWidth*(13/320))!, range: NSRange(location: 25, length: 7))
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        // or just create a seperate string for "Sign up" that we will modify and add to original screen
        return label
    }()
    var contract:UILabel = {
        // ipod touch width = 320
        let label = UILabel(textColor: .lightGray, font: UIFont(name: "HelveticaNeue", size: screenWidth*(13/320))!, textAlignment: .center, no_lines:2, translatesMaskInConstraints: false)
        let string = "By signing up, you agree to our Terms, Data Policy and Cookies Policy"
        // Turn this string into NSMutableAttributedString such that we could mutate the contents of the string
        let attributedText = NSMutableAttributedString(string: string)
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: screenWidth*(13/320))!, range: NSRange(location: 32, length: 18))
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: screenWidth*(13/320))!, range: NSRange(location: 54, length: 15))
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        // or just create a seperate string for "Sign up" that we will modify and add to original screen
        return label
    }()
    var separatorView = UIView(backgroundColor: .lightGray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // set textValue in initializers that we willm set later
        view.backgroundColor = .white
        nextButton.translatesAutoresizingMaskIntoConstraints = true
        welcomeLabel.text = "Welcome to Instagram, \(username ?? "gengenwilson")"
        buttonSwitches(button: nextButton, on: true)
        separatorView.alpha = 0.5
        view.addSubview(welcomeLabel)
        view.addSubview(infoWelcomeLabel)
        view.addSubview(nextButton)
        view.addSubview(changeUsernameButton)
        view.addSubview(signIn)
        view.addSubview(separatorView)
        view.addSubview(contract)
        signIn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signInTouched(_:))))
        changeUsernameButton.addTarget(self, action: #selector(changeUsername), for: .touchUpInside)
        print(screenWidth)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center label
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        welcomeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: view.width*(70/100)).isActive = true
        // y coordinate
        welcomeLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center label
        infoWelcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        infoWelcomeLabel.widthAnchor.constraint(equalToConstant: screenWidth*(85/100)).isActive = true
        // y coordinate
        infoWelcomeLabel.topAnchor.constraint(equalTo:welcomeLabel.bottomAnchor, constant:25 ).isActive = true
        
        nextButton.frame = CGRect(x: 25, y: infoWelcomeLabel.bottom+25, width: screenWidth*(340/390), height: 45)
        
        changeUsernameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        changeUsernameButton.topAnchor.constraint(equalTo:nextButton.bottomAnchor, constant:20).isActive = true
        changeUsernameButton.widthAnchor.constraint(lessThanOrEqualTo:view.widthAnchor).isActive = true
        
        
        // build from bottom
        signIn.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        signIn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenWidth*(40/390)).isActive = true
        signIn.widthAnchor.constraint(lessThanOrEqualTo:view.widthAnchor).isActive = true
        
        // 25 units of space between sign in and separatorView
        separatorView.frame = CGRect(x:0, y: signIn.top-26, width: screenWidth, height: 1)
        
        contract.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        contract.widthAnchor.constraint(lessThanOrEqualToConstant:screenWidth*(85/100)).isActive = true
        contract.bottomAnchor.constraint(equalTo:separatorView.topAnchor, constant:-20).isActive = true
    }
    @objc func changeUsername(_ sender:UIButton){
        print("username")
        // use custom transition we made
        customInstagramTransition(isDismiss: true)
        // animated is false, if not we will have 2 animations
        customPresentVC(UsernameViewController(), animated: false)
    }
    
    @objc func signInTouched(_ gesture: UITapGestureRecognizer) {
        // the signIn part represent 75/100 of the label, so it's easy
        print("mani")
        let threshold = signIn.width*(7.5/10)+signIn.originX
        // get location of user touch
        let gestureLocation = gesture.location(in: view)
        print("treshold = \(threshold) and gesture location = \(gestureLocation.x)")
        // check if location is in <<sign up>> area
        if (gestureLocation.x > threshold){
            print("go to next page")
            // use custom transition we made
            customInstagramTransition(isDismiss: true)
            // animated is false, if not we will have 2 animations
            customPresentVC(LoginViewController(), animated: false)
        }
    }
    

}
