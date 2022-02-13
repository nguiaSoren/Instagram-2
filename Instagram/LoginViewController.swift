//
//  ViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 01/01/2022.
//

import UIKit



class LoginViewController: UIViewController {
    
    let logo:UIImageView = UIImageView(named:"Logo", contentMode: .scaleAspectFill, frame:customRect(x: 113, y: 184, width: 165, height: 59))
    private let usernameTextField:UITextField = UITextField(frame:customRect(x:13, y:291, width:368, height:45), placeholder:"Phone number, username or email", cornerRadius:5, borderWidth:0.25, borderColor: UIColor.darkGray)
    
    let passwordTextField:UITextField = UITextField(frame:customRect(x:13, y:352, width:368, height:45), placeholder:"Password", cornerRadius:5, borderWidth:0.25, borderColor: UIColor.darkGray)
    
    let forgotPasswordButton:UILabel = UILabel(frame:customRect(x:265, y:413, width:120, height:16), textColor: UIColor.InstagramBlue, font: UIFont(name: "HelveticaNeue-Bold", size: 13)!, text:"Forgot password?",textAlignment: .left)
    
    let LoginButton = UIButton(frame:customRect(x:13, y:463, width:364, height:45),title: "Log in",backgroundColor: UIColor.InstagramBlue, cornerRadius: screenHeight*(5/844), font: UIFont(name: "HelveticaNeue-Bold", size: 16)!, alpha: 0.74)
    
    let separatorView:UIView = UIView(frame: customRect(x:13, y:547, width:148, height:0.25),backgroundColor: UIColor.darkGray)
    let separatorView2:UIView = UIView(frame:customRect(x:229, y:547, width:148, height:0.25), backgroundColor: UIColor.darkGray)
    let orLabel:UILabel = UILabel(textColor: .darkGray, font: UIFont(name:"HelveticaNeue-Bold", size: 13)!,text: "OR",translatesMaskInConstraints: false)
    
    // https://stackoverflow.com/questions/51488929/why-do-i-get-a-thread-1-exc-bad-access-code-exc-i386-gpflt
    var signUp:UILabel = {
        let label = UILabel(textColor: .lightGray, font: UIFont(name: "HelveticaNeue", size: 12)!, textAlignment: .center, translatesMaskInConstraints: false)
        let string = "Don't have an account? Sign up"
        // Turn this string into NSMutableAttributedString such that we could mutate the contents of the string
        let attributedText = NSMutableAttributedString(string: string)
        // change "Sign up" part color to blue (start at index 23 and stop at index 30)
        attributedText.addAttribute(.foregroundColor, value: UIColor.InstagramBlue, range: NSRange(location: 23, length: 7))
        // change "Sign up" part font to bold
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Bold", size: 12)!, range: NSRange(location: 23, length: 7))
        label.attributedText = attributedText
        label.isUserInteractionEnabled = true
        // or just create a seperate string for "Sign up" that we will modify and add to original screen
        return label
    }()
    // for the moment
    var continueWithFacebook:UILabel = {
        let label = UILabel(textColor:UIColor.InstagramBlue, font: UIFont(name:"HelveticaNeue-Bold", size: 14)!, textAlignment: .center, translatesMaskInConstraints: false)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "facebook")
        // set CGrect of image attached to label
        attachment.bounds = customRect(x:0, y: 0, width: 23, height: 23)
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string:"continue with facebook")
        myString.append(attachmentString)
        label.attributedText = myString
        //in case the person has a long name
        label.numberOfLines = 0
        return label
    }()

    let separatorView3:UIView = UIView(frame: customRect(x:0, y:769, width:screenWidth, height:0.5),backgroundColor: UIColor.darkGray)
    
    
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(LoginButton)
        view.addSubview(forgotPasswordButton)
        view.addSubview(separatorView)
        view.addSubview(separatorView2)
        view.addSubview(separatorView3)
        view.addSubview(signUp)
        view.addSubview(continueWithFacebook)
        view.addSubview(orLabel)
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        touchEndsViewEditing(view)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signUp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(signUpTouched(_:))))
        // center the label
        // frame: customRect(x:185, y: 539, width: 25, height: 16)
        signUp.center.x = view.center.x

        // label has a dynamic with that will adjust itself and center the shit
        orLabel.center.x = view.center.x
        orLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 1/3).isActive = true
        orLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(539/844)).isActive = true
        
        
        // label has a dynamic with that will adjust itself
        signUp.widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: 1/3).isActive = true
        signUp.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(795/844)).isActive = true
        continueWithFacebook.center.x = view.center.x
        continueWithFacebook.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(598/844)).isActive = true
        continueWithFacebook.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 2/3).isActive = true
    }
    
    @objc func signUpTouched(_ gesture: UITapGestureRecognizer) {
        /* don’t have an account sign up
         Treshold = don’t have an account.length / / Label.length

         21/31

         C’est sensé arrondir et j’ai vu que ça marche
         */
        // "Don't have an account?""HelveticaNeue", size: 12, represents 8/11 of the label so, we just need to
        // get a gesture location superior to 8/11 of the actual label width
        // example: signUP width = 178.0 with origin = 108.0
        let threshold = signUp.width*(8/11)+signUp.originX
        // get location of user touch
        let gestureLocation = gesture.location(in: view)
        print("treshold = \(threshold) and gesture location = \(gestureLocation.x)")
        // check if location is in <<sign up>> area
        if (gestureLocation.x > threshold){
            print("go to next page")
            // use custom transition we made
            customInstagramTransition(isDismiss: false)
            // animated is false, if not we will have 2 animations
            customPresentVC(UsernameViewController(), animated: false)
        }
        
    }
    

}















extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // remove optional
        guard let username = usernameTextField.text, let password = passwordTextField.text else {return true}
        // if user touched return and both textField aren't empty, proceed
        if (!username.isEmpty && !password.isEmpty){
            LoginButton.alpha = 1.0
            LoginButton.backgroundColor = .FacebookBlue
            textField.endEditing(true)
        // if textField is current responder, passwordTextField.becomeFirstResponder()
        }else if (textField == usernameTextField) {
            passwordTextField.becomeFirstResponder()
        }
        return false
    }

    
    // au cas ou on dismiss , genre touchEndsViewEditing(view)
    // si on ecrit pas ca, si le user dismiss sans toucher l'ecran, le button va rester le meme , meme si il doit changer
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {return}
        if (!username.isEmpty && !password.isEmpty){
            LoginButton.alpha = 1.0
            LoginButton.backgroundColor = .FacebookBlue
            textField.endEditing(true)
        }
    }
   
    
}


        
    
