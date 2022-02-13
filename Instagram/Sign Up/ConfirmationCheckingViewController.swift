//
//  ConfirmationCheckingViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 08/01/2022.
//

import UIKit

// bien sur on va mettre des initializers pour recevoir les données du previous screen
class ConfirmationCheckingViewController: UIViewController {
    // add return button
    // we will use dynamic frame that will adapt to the size of the scrren
    let returnButton:UIButton = UIButton(frame: CGRect(x: screenWidth*(3/390), y: screenHeight*(43/844), width: screenWidth*(43/390), height: screenWidth*(43/390)))
    // add nextButton
    private let nextButton = NextButton()
    // constraints for nextButton
    fileprivate var topConstraint1: NSLayoutConstraint?
    fileprivate var topConstraint2: NSLayoutConstraint?
    // will take value from previous screen (either email or phone number), but has a default value = "benaja@gmail.com"
    let emailPhoneNumber:String! = nil
    // Confirmation Code title
    let enterConfirmationCodeLabel = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue-Light", size: screenWidth*(25/390))!, text: "Enter Confirmation Code", translatesMaskInConstraints: false)
    var infoConfirmationCodeLabel = UILabel(textColor:.black, font: UIFont(name: "HelveticaNeue", size: screenWidth*(14/390))!, textAlignment: .center,no_lines: 0, translatesMaskInConstraints: false)
    // textField
    private let confirmationCodeTextField:UITextField = UITextField(placeholder:"Confirmation Code", cornerRadius:5, borderWidth:0.15, borderColor: UIColor.darkGray)
 
    // error Message
    let errorMessage = UILabel(textColor: .red, font:  UIFont(name:"HelveticaNeue-Light", size: 12)!, text: "That code isn’t valid. You can request a new one.",textAlignment:.left, no_lines:0,translatesMaskInConstraints: false)
    // boolean to check if user already touched "resend code part", in that case, he has to wait for the message to arrive
    var hasTriedBefore = false
    var coordinates:CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(infoConfirmationCodeLabel)
        view.addSubview(enterConfirmationCodeLabel)
        view.addSubview(confirmationCodeTextField)
        view.addSubview(errorMessage)
        view.addSubview(nextButton)
        view.addSubview(returnButton)
        setInfoCodeLabel()
        errorMessage.isHidden = true
        // refer to phone emailViewController
        topConstraint1 = nextButton.topAnchor.constraint(equalTo: confirmationCodeTextField.bottomAnchor, constant:15)
        topConstraint2 = nextButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant:10)
        // activate first constraint (normal one)
        topConstraint1?.isActive = true
        
        confirmationCodeTextField.delegate = self
        // add action for when the user type
        confirmationCodeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        confirmationCodeTextField.keyboardType = .numberPad
        // add action to nextButton target
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        
        infoConfirmationCodeLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(resendCode(_:))))
        returnButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        returnButton.setImage(UIImage(named: "left"), for: .normal)
        print(screenWidth)
        print(screenHeight)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // https://stackoverflow.com/questions/55699058/problems-with-first-responder-when-using-a-custom-uiwindow
        // toogle keyboard as soon as view appear
        confirmationCodeTextField.becomeFirstResponder()
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // center label
        enterConfirmationCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        enterConfirmationCodeLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        // y coordinate
        enterConfirmationCodeLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: screenHeight*(70/844)).isActive = true

        // center label
        infoConfirmationCodeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        infoConfirmationCodeLabel.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth*(245/390)).isActive = true
        // y coordinate
        infoConfirmationCodeLabel.topAnchor.constraint(equalTo: enterConfirmationCodeLabel.bottomAnchor, constant: 10).isActive = true

        confirmationCodeTextField.frame = CGRect(x: 13, y: infoConfirmationCodeLabel.bottom+20, width: screenWidth*(364/390), height: 45)
        
           // customRect(x:13, y:infoConfirmationCodeLabel.bottom+20, width:364, height:45)

        // dynamic width
        errorMessage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        // start at same level as infoTextField
        errorMessage.leftAnchor.constraint(equalTo:view.leftAnchor, constant: screenWidth*(13/390)).isActive = true
        // we want the message to be 15y below the textField
        errorMessage.topAnchor.constraint(equalTo:confirmationCodeTextField.bottomAnchor, constant: 15).isActive = true
        
        // dynamic width because 364 might simply be above some screen width
        nextButton.widthAnchor.constraint(equalToConstant:screenWidth*(364/390)).isActive = true
        // height has to be  and can be 45 everywhere
        nextButton.heightAnchor.constraint(equalToConstant:45).isActive = true
        // start at same level as infoTextField
        nextButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:13).isActive = true

    }
    
    func setInfoCodeLabel(){
        let string = "Enter the confirmation code we sent to \(emailPhoneNumber ?? "benajasoren@gmail.com"). Resend Confirmation code"
       // let prefix = string.substring(to: range.startIndex)
        // we need to calculate the string length because it will change depending of the "emailPhoneNumber" value
        let len = string.count
        // Turn this string into NSMutableAttributedString such that we could mutate the contents of the string
        let attributedText = NSMutableAttributedString(string: string)
        // change " Resend Confirmation code" part color to blue and bold, ("Resend Confirmation code").len = 24
        attributedText.addAttribute(.foregroundColor, value: UIColor.InstagramBlue, range: NSRange(location:len-25, length: 25))
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size:screenWidth*(14/390) )!, range: NSRange(location: len-25, length:25))
        infoConfirmationCodeLabel.attributedText = attributedText
        infoConfirmationCodeLabel.isUserInteractionEnabled = true
    }
    
    // same function as phoneEmailViewController
    func nextBNormalConstraints(){
        (errorMessage.isHidden) ? (topConstraint2?.isActive = false): (topConstraint1?.isActive = false)
        (errorMessage.isHidden) ? (topConstraint1?.isActive = true): (topConstraint2?.isActive = true)
    }
    
    func nextOrReturnTouched(){
        nextButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            // Call nextButton.stopAnimating() and other methods after a delay of 1 second
            self.nextButton.stopAnimating()
            // if email format is wrong, change borderWidth and border color message a
            confirmationCodeTextField.layer.borderColor = UIColor.red.cgColor; confirmationCodeTextField.layer.borderWidth = 0.50
            // if the user touches "Resend Confirmation code", set  hasTriedBefore = false and the user has to wait for 3 minutes before the message arrives
            errorMessage.text = (hasTriedBefore) ? "Please wait a few minutes before you try again.": "That code isn’t valid. You can request a new one."
            // and display emailError message
            errorMessage.isHidden = false
            nextBNormalConstraints()
        }
    }
    
    
    @objc func nextButtonTouched(sender: UIButton){
        guard let code = confirmationCodeTextField.text else{return}
        (errorMessage.isHidden && !code.isEmpty && nextButton.alpha == 1) ? nextOrReturnTouched(): nil
    }
    
    @objc func resendCode(_ gesture: UITapGestureRecognizer) {
        // max.y - character.height
       // let termsRange = ("Enter the confirmation code we sent to \(emailPhoneNumber ?? "benajasoren@gmail.com"). Resend Confirmation code" as NSString).range(of: "Resend Confirmation code")
      //  if gesture.didTapAttributedTextInLabel(label: infoConfirmationCodeLabel, inRange: termsRange) {
          //  print("Tapped terms")
       // }
        print("mani")

    }
    
    @objc func dismissController (sender: UIButton){
        // use custom transition we made
        customInstagramTransition(isDismiss: true)
        // animated is false, if not we will have 2 animations
        dismiss(animated: false, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



// THIS EXTENSION IS FOR TEXTFIELD DELEGATE AND OTHER(S) METHOD(S) INVOLVING TEXTFIELD
extension ConfirmationCheckingViewController:UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let info = confirmationCodeTextField.text else{return false}
        if (errorMessage.isHidden && !info.isEmpty && nextButton.alpha == 1){
           // nextOrReturnTouched()
            return false
        }
        return false
    }
    
     /// Track every time the user makes change to the Textfield
     @objc func textFieldDidChange(_ textField: UITextField) {
        guard let code = confirmationCodeTextField.text else{return}
        // prevent user from entering space at the beginning
        confirmationCodeTextField.no_empty_Field()
        // if info isn't empty (>2), change button custom state to on, otherwise change state to off
        buttonSwitches(button: nextButton, on: code.count >= 4)
        // check if the infoTextField is already back to normal before switching it back to normal.
        if (errorMessage.isHidden == false){
            // turn back infoTextField to original state (borderWidth and borderColor) when user
            confirmationCodeTextField.layer.borderWidth = 0.15; confirmationCodeTextField.layer.borderColor = UIColor.darkGray.cgColor
            // hide wrondMessage text
            errorMessage.isHidden = true
            nextBNormalConstraints()
        }
     }
}
