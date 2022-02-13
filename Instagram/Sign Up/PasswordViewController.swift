//
//  PasswordViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 05/01/2022.
//

import UIKit
import BEMCheckBox

// bien sur on va mettre des initializers pour recevoir les données du previous screen
class PasswordViewController: UIViewController {
    let createPasswordLabel = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue-Light", size: screenWidth*(25/390))!, text: "Create a Password", translatesMaskInConstraints: false)
    let infoPasswordLabel = UILabel(textColor:.darkGray, font: UIFont(name:"HelveticaNeue", size: screenWidth*(14/390))!, text: "We can remember the password, so you won't need to enter it on your iCloud® devices.",no_lines: 0, translatesMaskInConstraints: false)
    private let passwordTextField:UITextField = UITextField(placeholder:"Password", cornerRadius:5, borderWidth:0.25, borderColor: UIColor.darkGray)
    private let nextButton = NextButton()
    private var savePasswordLabel:UILabel = UILabel(textColor: .lightGray, font: UIFont(name:"HelveticaNeue", size: 12)!, text: "Save Password", textAlignment: .left,translatesMaskInConstraints: false)
    // add return button
    // we will use dynamic frame that will adapt to the size of the scrren
    let returnButton:UIButton = UIButton(frame: CGRect(x: screenWidth*(3/390), y: screenHeight*(43/844), width: screenWidth*(43/390), height: screenWidth*(43/390)))

    var checkBox:BEMCheckBox {
        // it would have been better to use passswordTextfield, but its frame will be initialized later
        let value = (screenHeight < 812) ? screenHeight*(270/844) : screenHeight*(220/844)
        
        let box = BEMCheckBox(frame: CGRect(x:15, y:value, width:16, height:16) )
        box.animationDuration = 0
        box.onAnimationType = .fade
        box.offAnimationType = .fade
        box.setOn(true, animated: false)
        box.boxType = .square
        return box
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(returnButton)
        view.addSubview(createPasswordLabel)
        view.addSubview(infoPasswordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
      //  view.addSubview(savePasswordLabel)
       // view.addSubview(checkBox)
        passwordTextField.delegate = self
        // we are entering a password
        passwordTextField.isSecureTextEntry = true
        // clear button is always there
        passwordTextField.clearButtonMode = .always
        // add action for when the user type
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        touchEndsViewEditing(view)
        // add target to buttons
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        returnButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        returnButton.setImage(UIImage(named: "left"), for: .normal)
        print(screenHeight)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center the label
        createPasswordLabel.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        createPasswordLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        createPasswordLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center the label
        infoPasswordLabel.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        infoPasswordLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 80/100).isActive = true
        infoPasswordLabel.topAnchor.constraint(equalTo:createPasswordLabel.bottomAnchor, constant:15).isActive = true
        
       // fixed height of 45 on all screen
        passwordTextField.frame = CGRect(x: 13, y: infoPasswordLabel.bottom+15, width: screenWidth*(364/390), height: 45)
        
//        // warning message and usernameTextField got the same origin
//        savePasswordLabel.frame.origin.x = checkBox.right+5
//        savePasswordLabel.center.y = checkBox.center.y
//        // label has a dynamic width that will adjust itself and be correct
//        savePasswordLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        // dynamic width and height
        nextButton.widthAnchor.constraint(equalToConstant:screenWidth*(364/390)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant:45).isActive = true
        // start at same level as infoTextField
        nextButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:13).isActive = true
        nextButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
    }
    
    
    @objc func nextButtonTouched(sender: UIButton){
        if (self.nextButton.alpha == 1){
            passwordTextField.endEditing(true)
                // use custom transition we made
                self.nextButton.startAnimating()
                // Call nextButton.stopAnimating() and other methods after a delay of 5 second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
                    // use custom transition we made
                    customInstagramTransition(isDismiss: false)
                    self.nextButton.stopAnimating()
                    self.customPresentVC(PhoneEmailViewController(), animated: false)
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
extension PasswordViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss keyboard when return touched
        passwordTextField.resignFirstResponder()
        return true
    }
    
    // every time the user type
    @objc func textFieldDidChange(_ textField: UITextField) {
        passwordTextField.no_empty_Field()
        guard let password = passwordTextField.text else{return}
        // check if password is okay with my passwordChecker later
        if (password.count > 7 ){
            // if passsword isn't empty, change button custom state to on
            buttonSwitches(button: nextButton, on: true)
            // check if username is in database (just for testing)
        } else{
            // if passsword is empty, change button custom state to on
            buttonSwitches(button: nextButton, on: false)
    
        }
    }
    
    // au cas ou on dismiss , genre touchEndsViewEditing(view)
    // si on ecrit pas ca, si le user dismiss sans toucher l'ecran, le button va rester le meme , meme si il doit changer
}
