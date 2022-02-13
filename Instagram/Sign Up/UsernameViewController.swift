//
//  UsernameViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 05/01/2022.
//

import UIKit


class UsernameViewController: UIViewController {
    let createUsernameLabel = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue-Light", size: 25)!, text: "Create Username", translatesMaskInConstraints: false)
    let infoUsernameLabel = UILabel(textColor:.darkGray, font: UIFont(name:"HelveticaNeue", size: 14)!, text: "Pick a username for your new account. You can always change it later",no_lines: 0, translatesMaskInConstraints: false)
    private let usernameTextField:UITextField = UITextField(placeholder:"username", cornerRadius:5, borderWidth:0.25, borderColor: UIColor.darkGray)
    private let nextButton = NextButton(frame: customRect(x:13, y:264, width:368, height:45))
    private var warningMessage:UILabel = UILabel(textColor: .red, font: UIFont(name:"HelveticaNeue-Light", size: 12)!, text: "please choose a username", textAlignment: .left,translatesMaskInConstraints: false)
    let cancelButton:UIButton = UIButton(frame: CGRect(x: screenWidth*(3/390), y: screenHeight*(43/844), width: screenWidth*(41/390), height: screenWidth*(41/390)))
    // constraints for nextButton
    fileprivate var topConstraint1: NSLayoutConstraint?
    fileprivate var topConstraint2: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cancelButton)
        view.addSubview(createUsernameLabel)
        view.addSubview(infoUsernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(nextButton)
        view.addSubview(warningMessage)
        
        usernameTextField.delegate = self
        // clear button is always there
        usernameTextField.clearButtonMode = .always
        touchEndsViewEditing(view)
        // add action for when the user type
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        // initially hide the warning message
        warningMessage.isHidden = true

        cancelButton.setImage(UIImage(named: "close"), for: .normal)
        
        // I tried to initialize in viewDidLayoutSubviews() but it didn't work that well
        // https://stackoverflow.com/questions/49346171/how-to-change-layout-constraint-programmatically-in-swift
        // I want the nextButton to go lower when I display the wrongEmailMessage, so I will create 2 constraints.
        // topConstraint1 is the normal topAnchor constraint for nextButton(normal position)
        topConstraint1 = nextButton.topAnchor.constraint(equalTo:usernameTextField.bottomAnchor, constant:18)
        // topConstraint2 is constraint we will activate if  wrongEmailMessage is displayed (make it go lower)
        topConstraint2 = nextButton.topAnchor.constraint(equalTo:warningMessage.bottomAnchor, constant:10)
        // activate first constraint (normal one)
        topConstraint1?.isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center the label
        createUsernameLabel.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        createUsernameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        createUsernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center the label
        infoUsernameLabel.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        infoUsernameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 80/100).isActive = true
        infoUsernameLabel.topAnchor.constraint(equalTo:createUsernameLabel.bottomAnchor, constant:17).isActive = true

        usernameTextField.frame = CGRect(x: 13, y: infoUsernameLabel.bottom+31, width: screenWidth*(364/390), height: 45)
        // warning message and usernameTextField got the same origin
        warningMessage.frame.origin.x = usernameTextField.left
        // label has a dynamic width that will adjust itself and be correct
        warningMessage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        warningMessage.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor,constant:15).isActive = true
       
        
        // dynamic width and height
        nextButton.widthAnchor.constraint(equalToConstant:screenWidth*(368/390)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant:45).isActive = true
        // start at same level as usernameTextField
        nextButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 13).isActive = true
    }
    
    func nextBNormalConstraints(){
        (warningMessage.isHidden) ? (topConstraint2?.isActive = false): (topConstraint1?.isActive = false)
        (warningMessage.isHidden) ? (topConstraint1?.isActive = true): (topConstraint2?.isActive = true)
    }
  
  
  
    
    @objc func nextButtonTouched(sender: UIButton){
        guard let username = usernameTextField.text else{return}
        nextButton.startAnimating()
        if (warningMessage.isHidden && !username.isEmpty ){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
                usernameTextField.endEditing(true)
                // Call nextButton.stopAnimating() and other methods after a delay of 1 second
                self.nextButton.stopAnimating()
                // use custom transition we made
                self.customInstagramTransition(isDismiss: false)
                // animated is false, if not we will have 2 animations
                self.customPresentVC(PasswordViewController(), animated: false)
            }
         }
    }
    
    @objc func dismissController (sender: UIButton){
        // use custom transition we made
        customInstagramTransition(isDismiss: true)
        // animated is false, if not we will have 2 animations
        dismiss(animated: false, completion: nil)
    }
    

}

// THIS EXTENSION IS FOR TEXTFIELD DELEGATE AND OTHER(S) METHOD(S) INVOLVING TEXTFIELD

extension UsernameViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        return true
    }
    // every time the user type
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let username = usernameTextField.text else{return}
        usernameTextField.no_empty_Field()
        
        // check if username isn't empty
        if (!username.isEmpty){
            // if username is empty, change button custom state to on
            buttonSwitches(button: nextButton, on: true)
            // check if username is in database (just for testing)
            if (username.count > 7){
                // just for testing
                // if username is already in database, tell the user
                // update warning messaage
                warningMessage.text = "The username \(username) is not available"
                // change border color and borderWidth of textField
                usernameTextField.layer.borderColor = UIColor.red.cgColor
                usernameTextField.layer.borderWidth = 0.5
                // Make message visible to user
                warningMessage.isHidden = false
                nextBNormalConstraints()
            } else{
                /* it's better to add an observer later on, because here , it will change the color whenever we type,
                  even if the color is the same*/
                
                // change border color and borderWidth of textField
                usernameTextField.layer.borderColor = UIColor.systemGray.cgColor
                usernameTextField.layer.borderWidth = 0.25
                // Hide message from user
                warningMessage.isHidden = true
                nextBNormalConstraints()
                
            }
        } else{
            //  update warning messaage
            warningMessage.text = "please choose a username"
            // display warning message
            warningMessage.isHidden = false
            // if username is empty, change button custom state to off
            buttonSwitches(button: nextButton, on: false)

            // change border color and borderWidth of textField
            usernameTextField.layer.borderColor = UIColor.red.cgColor
            usernameTextField.layer.borderWidth = 0.5
            nextBNormalConstraints()
        }
        
    }
    // au cas ou on dismiss , genre touchEndsViewEditing(view)
    // si on ecrit pas ca, si le user dismiss sans toucher l'ecran, le button va rester le meme , meme si il doit changer

    
}
