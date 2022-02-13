//
//  FullNameViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 09/01/2022.
//

import UIKit

class FullNameViewController: UIViewController {
    
    // title H1 and H2
    let addYourNameLabel = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue-Light", size: 25)!, text: "Add Your Name", translatesMaskInConstraints: false)
    var infoNameLabel = UILabel(textColor:.lightGray, font: UIFont(name: "HelveticaNeue", size: 14)!,text: "Add your name so friends can find you", textAlignment: .center,no_lines: 0, translatesMaskInConstraints: false)
    
    // textField
    private let fullNameTextField:UITextField = UITextField(placeholder:"Full name", cornerRadius:5, borderWidth:0.15, borderColor: UIColor.darkGray)
    
    // add nextButton
    private let nextButton = NextButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addYourNameLabel)
        view.addSubview(infoNameLabel)
        view.addSubview(fullNameTextField)
        view.addSubview(nextButton)
        fullNameTextField.delegate = self


        // add action for when the user type
        fullNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // https://stackoverflow.com/questions/55699058/problems-with-first-responder-when-using-a-custom-uiwindow
        // toogle keyboard as soon as view appear
        fullNameTextField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center label
        addYourNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        addYourNameLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        // y coordinate
        addYourNameLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center label
        infoNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        infoNameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: screenWidth*(245/390)).isActive = true
        // y coordinate
        infoNameLabel.topAnchor.constraint(equalTo: addYourNameLabel.bottomAnchor, constant: 10).isActive = true
        
        fullNameTextField.frame = CGRect(x: 13, y: infoNameLabel.bottom+20, width: screenWidth*(364/390), height: 45)
        nextButton.frame = CGRect(x: 13, y: fullNameTextField.bottom+15, width: screenWidth*(364/390), height: 45)
        
        nextButton.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant:15).isActive = true
        // dynamic width because 364 might simply be above some screen width
        nextButton.widthAnchor.constraint(equalToConstant:screenWidth*(364/390)).isActive = true
        // height has to be  and can be 45 everywhere
        nextButton.heightAnchor.constraint(equalToConstant:45).isActive = true
        // start at same level as infoTextField
        nextButton.leftAnchor.constraint(equalTo:view.leftAnchor, constant:13).isActive = true
        // remplacer les contraintes d'en haut par ce code
       // nextButton.frame = CGRect(x: 13, y: fullNameTextField.bottom+15, width: screenWidth*(364/390), height: 45)
    }
    
    
    
    func nextOrReturnTouched(){
        // register fullName
        nextButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            // Call nextButton.stopAnimating() and other methods after a delay of 1 second
            self.nextButton.stopAnimating()
            print("mani")
        }
    }
    
    @objc func nextButtonTouched(sender: UIButton){
      //  guard let fullName = fullNameTextField.text else{return }
        if (nextButton.alpha == 1){
            nextOrReturnTouched()
            print("nextButton touched")
            }
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
// the bug is because of indicatorView pack

extension FullNameViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (nextButton.alpha == 1){
            print("here oh")
            nextOrReturnTouched()
        }
        return false
    }
    
    /// Track every time the user makes change to the Textfield
    @objc func textFieldDidChange(_ textField: UITextField) {
       guard let fullName = fullNameTextField.text else{return}
       // prevent user from entering space at the beginning
        fullNameTextField.no_empty_Field()
       // if info isn't empty (>4), change button custom state to on, otherwise change state to off
       buttonSwitches(button: nextButton, on: fullName.count >= 4)
      
    }
    
}
