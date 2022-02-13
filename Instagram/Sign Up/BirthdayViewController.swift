//
//  BirthdayViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 09/01/2022.
//

import UIKit

class BirthdayViewController: UIViewController {
    let cakeImage = UIImageView(image: UIImage(named: "cake"))
    let addBirthdayLabel:UILabel = UILabel(textColor: .black, font: UIFont(name:"HelveticaNeue-Light", size: screenWidth*(25/390))!, text: "Add Your Birthday")
    var infoBirthdayLabel = UILabel(textColor:.black, font: UIFont(name: "HelveticaNeue", size: screenWidth*(14/390))!, textAlignment: .center,no_lines: 2, translatesMaskInConstraints: false)
    let dateTextField = UITextField(placeholder: "mani", cornerRadius: 5, borderWidth:1, borderColor: .InstagramBlue)

    let infoBirthdayLabel2 = UILabel(textColor:.lightGray, font: UIFont(name: "HelveticaNeue", size: screenWidth*(12/390))!,text:"You need to enter the date you were born.", textAlignment:.left)
    let infoBirthdayLabel3 = UILabel(font:UIFont(name: "HelveticaNeue", size: screenWidth*(12/390))!, text: "Use your own birthday, even if this account is for business, a pet or something else",no_lines: 2, translatesMaskInConstraints: true)
    let separatorView = UIView(backgroundColor: .lightGray)
    let nextButton = NextButton()
    let birthdayDatePicker:UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        // Set some of UIDatePicker properties
        datePicker.datePickerMode = .date
      // negative value (-) to subtract and positive value to add date component. If value = 1, maximum year = 2023
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        // 2022-100 = 1922, can be translated by minimum age = 100 years old
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -100, to: Date())
        // Add an event to call onDidChangeDate function when value is changed.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(cakeImage)
        view.addSubview(addBirthdayLabel)
        view.addSubview(infoBirthdayLabel)
        view.addSubview(dateTextField)
        view.addSubview(infoBirthdayLabel2)
        view.addSubview(infoBirthdayLabel3)
        view.addSubview(separatorView)
        view.addSubview(nextButton)
        view.addSubview(birthdayDatePicker)
        cakeImage.translatesAutoresizingMaskIntoConstraints = false
        addBirthdayLabel.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = true
        dateTextField.clearButtonMode = .never
        dateTextField.text = datePickerValueChanged(birthdayDatePicker)
        dateTextField.backgroundColor = .white
        nextButton.addTarget(self, action: #selector(nextTouched), for: .touchUpInside)
        buttonSwitches(button: nextButton, on: true)
        setInfoLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center label
        cakeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width and height
        cakeImage.widthAnchor.constraint(equalToConstant: screenWidth/4).isActive = true
        cakeImage.heightAnchor.constraint(equalToConstant: screenWidth/4).isActive = true
        // y coordinate
        cakeImage.topAnchor.constraint(equalTo:view.topAnchor, constant: screenHeight*(60/844)).isActive = true
        
        // center title label
        addBirthdayLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        addBirthdayLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        addBirthdayLabel.topAnchor.constraint(equalTo:cakeImage.bottomAnchor, constant: screenHeight*(15/844)).isActive = true
        // center info birthday label
        infoBirthdayLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        infoBirthdayLabel.widthAnchor.constraint(lessThanOrEqualTo:view.widthAnchor, multiplier: 70/100).isActive = true
        infoBirthdayLabel.topAnchor.constraint(equalTo:addBirthdayLabel.bottomAnchor, constant: screenHeight*(15/844)).isActive = true
        
        // textField
        dateTextField.frame = CGRect(x: 20, y:infoBirthdayLabel.bottom+20, width: screenWidth*(350/390), height: 45)
        // infoLabel below dateTextField
        infoBirthdayLabel2.frame = CGRect(x:dateTextField.left, y: dateTextField.bottom+2, width:screenWidth, height:screenWidth*(20/390))
        
        // build other frames from  bottom
        birthdayDatePicker.widthAnchor.constraint(equalToConstant:screenWidth).isActive = true
        birthdayDatePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        birthdayDatePicker.heightAnchor.constraint(equalToConstant: screenHeight/3.5).isActive = true
        birthdayDatePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        // set nextButton at the top of birthdayPicker
        nextButton.frame = CGRect(x:13, y:birthdayDatePicker.top-45, width: screenWidth*(364/390), height: 45)
        // set separatorView
        separatorView.frame = CGRect(x:0, y: nextButton.top-10, width: screenWidth, height: 1)
        separatorView.alpha = 0.2
        // info label 3
        infoBirthdayLabel3.frame = CGRect(x: 25, y: separatorView.top-45, width: screenWidth*(345/390), height: 40)
    }
    
    func setInfoLabel(){
        let string = "This won't be a part of your public profile. Why do I need to provide my birthday?"
        // we need to calculate the string length because it will change depending of the "emailPhoneNumber" value
        let len = string.count
        let attributedText = NSMutableAttributedString(string: string)
        // spacing between line
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle,value: style,range: NSMakeRange(0,len))
        attributedText.addAttribute(.foregroundColor, value: UIColor.darkBlue, range: NSRange(location:len-38, length: 38))
        // order of label will stay the same (1st line = This won't be a part of your public profile. , 2nd line = Why do I need to provide my birthday?) because I used screenWidth and constraints to dynamically allocate font size and width (it works on one device that way, so it works on all)
        attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Medium", size:screenWidth*(15/390))!, range: NSRange(location: len-38, length:38))
        // if we want to add action to the "Why do I need to provide my birthday?" part, just check if location.y = label.height.4 and the x
        // since there is a lot of spacing, we can divide the shit into 4 parts and as a consequence the last part is the one with the "Why do I need to provide my birthday?" part
        infoBirthdayLabel.attributedText = attributedText
        infoBirthdayLabel.isUserInteractionEnabled = true
    }
    
    func calcAge(_ birthday: String) -> Int {
        /// Calculate age
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM/dd/yyyy"
        let birthdayDate = dateFormater.date(from: birthday)
        let calendar: NSCalendar! = NSCalendar(calendarIdentifier: .gregorian)
        let now = Date()
        let calcAge = calendar.components(.year, from: birthdayDate!, to: now, options: [])
        let age = calcAge.year
        return age!
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) -> String{
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format value , "MMM d, yyyy" -> Jan 9, 2022; MM-dd-yyyy HH:mm --> 09-12-2018 14:11; etc
        dateFormatter.dateFormat = "MMM d, yyyy"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        // update textField
        dateTextField.text = selectedDate
        // update rightView
        rightView(age:calcAge(selectedDate) )
        return selectedDate
    }
    @objc func nextTouched(sender: UIButton){
        ///  function when value that look when birthdayDatePicker is changed.
        nextButton.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            // Call nextButton.stopAnimating() and other methods after a delay of 1 second
            self.nextButton.stopAnimating()
            print("mani")
        }
    }
    
    func rightView(age:Int){
        let textFieldWidth = dateTextField.width
        // make rightView
        let rightView = UIView(translatesMaskInConstraints: false,backgroundColor: dateTextField.backgroundColor!)
        // if you don't set constraint, rightView will never work
        rightView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        rightView.widthAnchor.constraint(equalToConstant:textFieldWidth*(90/350)).isActive = true
        // set text Value
        let txt = (age > 1) ? "\(age) years old":"\(age) year old"
        let label = UILabel(textColor:.orange, font:UIFont(name: "HelveticaNeue", size:textFieldWidth*(13/350))!, text:txt ,translatesMaskInConstraints: false)
        rightView.addSubview(label)
        // center label in view
        label.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        // set label leftAnchor and widthAnchro constraint
        label.leftAnchor.constraint(equalTo:rightView.leftAnchor).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualToConstant: rightView.width).isActive = true
        // apply to dataTextfield
        dateTextField.rightView = rightView
        dateTextField.rightViewMode = .always
    }

}
