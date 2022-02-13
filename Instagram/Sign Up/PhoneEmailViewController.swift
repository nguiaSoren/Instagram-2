//
//  PhoneEmailViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 06/01/2022.
//

import UIKit

// bien sur on va mettre des initializers pour recevoir les données du previous screen
class PhoneEmailViewController: UIViewController {
    // add return button
    // we will use dynamic frame that will adapt to the size of the scrren
    let returnButton:UIButton = UIButton(frame: CGRect(x: screenWidth*(3/390), y: screenHeight*(43/844), width: screenWidth*(43/390), height: screenWidth*(43/390)))
    // add nextButton
    private let nextButton = NextButton()
    // constraints for nextButton
    fileprivate var topConstraint1: NSLayoutConstraint?
    fileprivate var topConstraint2: NSLayoutConstraint?
    // boolean to check state of current screen; We will need it later
    var isEmail = false
    
    // title add info Title
    let addInfoTitle = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue-Light", size: screenWidth*(25/390))!, text: "Add Phone or Email", translatesMaskInConstraints: false)
    // create textField that we will change when user wanna switch
    private let infoTextField:UITextField = UITextField(frame:CGRect(x: 45, y: screenHeight*(179/844), width: screenWidth*(300/390), height: 45), placeholder:"Phone number", cornerRadius:5, borderWidth:0.15, borderColor: UIColor.darkGray)
    private var infoMessageLabel:UILabel = UILabel(textColor: .systemGray, font: UIFont(name:"HelveticaNeue", size: 12)!, text: "You may receive SMS updates from Instagram and can opt out at any time.", textAlignment: .left,no_lines:0,translatesMaskInConstraints: false)
    
    // make phone switch area components
    private var phoneTitle:UILabel = UILabel(textColor: .black, font: UIFont(name: "HelveticaNeue-Medium", size: screenWidth*(17/390))!, text: "Phone")
    private var phoneSeparatorView = UIView(backgroundColor: .black)
    // make email switch area components
    private var emailSeparatorView = UIView(backgroundColor: .black)
    private var emailTitle:UILabel = UILabel(textColor: .black, font: UIFont(name: "HelveticaNeue-Medium", size: screenWidth*(17/390))!, text: "Email")
    var errorMessage = UILabel(textColor: .red, font:  UIFont(name:"HelveticaNeue", size: 12)!, text: "Please enter a valid email.",textAlignment:.left, no_lines:0,translatesMaskInConstraints: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // in this view, the keyboard never dismiss
        view.addSubview(returnButton)
        view.addSubview(addInfoTitle)
        view.addSubview(phoneTitle)
        view.addSubview(emailTitle)
        view.addSubview(phoneSeparatorView)
        view.addSubview(emailSeparatorView)
        view.addSubview(infoTextField)
        view.addSubview(errorMessage)
        view.addSubview(nextButton)
        view.addSubview(infoMessageLabel)
        // initially hide wrongEmail message
        errorMessage.isHidden = true
        // email page isn't highlighted
        emailSeparatorView.alpha = 0.5; emailTitle.alpha = 0.5
        returnButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        // add action for when the user type
        infoTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        // set delegate
        infoTextField.delegate = self
        // clear button is always there
        infoTextField.clearButtonMode = .always
        // make textField targeted for specific phone number only
        infoTextField.keyboardType = .phonePad
        // update leftView of phoneArea
        infoTextField.leftView = phoneFieldLeftView()
        
        addGestureToView()
        returnButton.setImage(UIImage(named: "left"), for: .normal)
        // I tried to initialize in viewDidLayoutSubviews() but it didn't work that well
        // https://stackoverflow.com/questions/49346171/how-to-change-layout-constraint-programmatically-in-swift
        // I want the nextButton to go lower when I display the wrongEmailMessage, so I will create 2 constraints.
        // topConstraint1 is the normal topAnchor constraint for nextButton(normal position)
        topConstraint1 = nextButton.topAnchor.constraint(equalTo:infoTextField.bottomAnchor, constant:20)
        // topConstraint2 is constraint we will activate if  wrongEmailMessage is displayed (make it go lower)
        topConstraint2 = nextButton.topAnchor.constraint(equalTo: errorMessage.bottomAnchor, constant:10)
        // activate first constraint (normal one)
        topConstraint1?.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // https://stackoverflow.com/questions/55699058/problems-with-first-responder-when-using-a-custom-uiwindow
        // toogle keyboard as soon as view appear
        infoTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center label
        addInfoTitle.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        addInfoTitle.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
       addInfoTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center the label
        infoMessageLabel.center.x = view.center.x
        // label has a dynamic width that will adjust itself
        infoMessageLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 16/25).isActive = true
        infoMessageLabel.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: screenHeight*(15/844)).isActive = true
        
        // dynamic width
        errorMessage.widthAnchor.constraint(lessThanOrEqualToConstant: view.width*(300/390)).isActive = true
        // start at same level as infoTextField
        errorMessage.leftAnchor.constraint(equalTo:view.leftAnchor, constant:45).isActive = true
        errorMessage.topAnchor.constraint(equalTo:infoTextField.bottomAnchor, constant:15).isActive = true
  
        // dynamic width and height
        nextButton.widthAnchor.constraint(equalToConstant:screenWidth*(300/390)).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant:45).isActive = true
        // start at same level as infoTextField
        nextButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:45).isActive = true
        // we want dynamic width and y coordinate
        infoTextField.frame = CGRect(x: 45, y: emailSeparatorView.bottom+25, width: screenWidth*(300/390), height: 45)
        phoneTitle.frame = CGRect(x:screenWidth*(94/390), y: addInfoTitle.bottom+22, width: screenWidth*(65/390), height: screenHeight*(24/844))
        emailTitle.frame = CGRect(x:screenWidth*(234/390), y: addInfoTitle.bottom+22, width: screenWidth*(65/390), height: screenHeight*(24/844))
        phoneSeparatorView.frame = CGRect(x: screenWidth*(45/390), y: phoneTitle.bottom+8, width: screenWidth*(150/390), height: 1)
        // 45+150 = 195, given the fact that on original model (iphone 12), those separatorviews have a total of 300/390
        emailSeparatorView.frame = CGRect(x: screenWidth*(195/390), y: emailTitle.bottom+8, width: screenWidth*(150/390), height: 1)
    }
    
    func addGestureToView(){
        // we add gesture to the screen
        let switchGesture = UITapGestureRecognizer(target: self, action: #selector(viewTouched))
        view.addGestureRecognizer(switchGesture)
        view.isUserInteractionEnabled = true
    }
    
    func nextBNormalConstraints(){
        // deactivate the second one (the old one) and // activate the second one
        (errorMessage.isHidden) ? (topConstraint2?.isActive = false) : (topConstraint1?.isActive = false);
        (errorMessage.isHidden) ? (topConstraint1?.isActive = true) :  (topConstraint2?.isActive = true)
    }

    
    @objc func nextButtonTouched(sender: UIButton){
        guard let info = infoTextField.text else{return}
        (errorMessage.isHidden && !info.isEmpty && nextButton.alpha == 1) ? nextOrReturnTouched() : nil
    }

    
    @objc func viewTouched(_ gesture: UITapGestureRecognizer){
        /// we will use this function to switch between phone and email textField and Keyboard
        // So, the first step is to find the location of the gesture:
            // get location of user touch
        let gestureLocation = gesture.location(in: view)
        let phoneSep = phoneSeparatorView, emailSep = emailSeparatorView
          //  check if locations corresponds to phone area
        if ((phoneSep.minX...phoneSep.maxX).contains(gestureLocation.x) && (phoneTitle.minY...phoneSep.minY).contains(gestureLocation.y) && (isEmail)){
            // switch to phone screen
            switchScreen(isEmailValue: false, placeholder: "Phone number", infoLabelHiddenValue: false, keyboardType:.phonePad, leftView: phoneFieldLeftView())
        
          // check if location corresponds to email area, check if user touched in email Area
        } else if ((emailSep.minX...emailSep.maxX).contains(gestureLocation.x) && (emailTitle.minY...emailSep.minY).contains(gestureLocation.y) && (!isEmail)){
            // switch to email screen
            switchScreen(isEmailValue: true, placeholder: "Email Address", infoLabelHiddenValue: true, keyboardType:.emailAddress, leftView:UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0)))
        }
    }

    
    @objc func dismissController (sender: UIButton){
        // use custom transition we made
        customInstagramTransition(isDismiss: true)
        // animated is false, if not we will have 2 animations
        dismiss(animated: false, completion: nil)
    }
    
    func nextOrReturnTouched(){
        nextButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            // Call nextButton.stopAnimating() and other methods after a delay of 1 second
            self.nextButton.stopAnimating()
            // if email format is wrong, change borderWidth and border color message a
            infoTextField.layer.borderColor = UIColor.red.cgColor; infoTextField.layer.borderWidth = 0.50
            errorMessage.text = (isEmail) ? "Please enter a valid email.": "Looks like your phone number maybe incorrect. Please try entering your full number, including the country code."
            // and display emailError message
            errorMessage.isHidden = false
            nextBNormalConstraints()
        }
    }
}



// THIS EXTENSION IS FOR TEXTFIELD DELEGATE AND OTHER(S) METHOD(S) INVOLVING TEXTFIELD
extension PhoneEmailViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let info = infoTextField.text else{return false}
        if (errorMessage.isHidden && !info.isEmpty && nextButton.alpha == 1){
            nextOrReturnTouched()
            return false
        }
        return false

    }
     /// Track every time the user makes change to the Textfield
     @objc func textFieldDidChange(_ textField: UITextField) {
        guard let info = infoTextField.text else{return}
        // prevent user from entering space at the beginning
        infoTextField.no_empty_Field()
        // if info isn't empty (>2), change button custom state to on, otherwise change state to off
        buttonSwitches(button: nextButton, on: info.count >= 2)
        // check if the infoTextField is already back to normal before switching it back to normal.
        if (errorMessage.isHidden == false){
            // turn back infoTextField to original state (borderWidth and borderColor) when user
            infoTextField.layer.borderWidth = 0.15; infoTextField.layer.borderColor = UIColor.darkGray.cgColor
            // hide wrondMessage text
            errorMessage.isHidden = true
            nextBNormalConstraints()
        }
     }
    
    /// Generate a custom LeftView for a phone number textField
    func phoneFieldLeftView() -> UIView {
        // set textField leftview
        // we didnt use camel notation because it's already used by the system and it can lead to confusion
        let left_view = UIView(translatesMaskInConstraints: false)
        left_view.backgroundColor = infoTextField.backgroundColor
        // create leftView with constraints, if not, it's gonna play bitch
        left_view.widthAnchor.constraint(equalToConstant:infoTextField.width*(105/300)).isActive = true
        // on adobeXD model, width = 300, so here, infoTextField.width*(65/300) = 300*(65/300) = 65, if it was another, we would have mutplied by the ratio 65/300
        let indicatif:UILabel = UILabel(frame:CGRect(x: infoTextField.width*(11/300), y: infoTextField.height*(14/45), width: infoTextField.width*(65/300), height: infoTextField.height*(18/45)),textColor: .InstagramBlue, font: UIFont.systemFont(ofSize: 15, weight: .medium), text: "KR +82", textAlignment: .left)
        let vertivalSeparatorView:UIView = UIView(frame: CGRect(x:infoTextField.width*(93/300), y: infoTextField.height*(10/45), width: 1, height: infoTextField.height*(26/45)),backgroundColor:.systemGray2)
        // add indicatif to left_view
        left_view.addSubview(indicatif)
        // add vertivalSeparatorView to left_view
        left_view.addSubview(vertivalSeparatorView)
        return left_view
    }
}



// THIS EXTENSION IS FOR SWITCHING CURRENT SCREEN
extension PhoneEmailViewController {
    /// Use this function to change screen when user touched one part of screen
    func switchScreen(isEmailValue:Bool,placeholder:String,infoLabelHiddenValue:Bool, keyboardType:UIKeyboardType, leftView:UIView){
        isEmail = isEmailValue
        // update alpha values of email and phone areas
        emailSeparatorView.alpha = (emailSeparatorView.alpha == 0.5) ? 1: 0.5
        emailTitle.alpha = (emailTitle.alpha == 0.5) ? 1: 0.5
        phoneSeparatorView.alpha = (phoneSeparatorView.alpha == 0.5) ? 1: 0.5
        phoneTitle.alpha = (phoneTitle.alpha == 0.5) ? 1: 0.5
        // change placeHolder in textField (showing user we switched area)
        infoTextField.placeholder = placeholder
        // display it for phone and hide it for email
        infoMessageLabel.isHidden = infoLabelHiddenValue
        // hide error message
        errorMessage.isHidden = true
        // Resign the current responder (dismisss the keyboard), such that we could change keyboard type
        infoTextField.resignFirstResponder()
        // make textField targeted for emailAddress or phone number only
        infoTextField.keyboardType = keyboardType
        // infoTextField rebecome firstResponder(make keyboard appear again)
        infoTextField.becomeFirstResponder()
        // update leftView of area
        infoTextField.leftView = leftView
        // turn TextField back to normal
        infoTextField.layer.borderWidth = 0.15; infoTextField.layer.borderColor = UIColor.darkGray.cgColor
        // make the textField empty
        infoTextField.text = ""
        // update constraints
        nextBNormalConstraints()
    }
    
}
