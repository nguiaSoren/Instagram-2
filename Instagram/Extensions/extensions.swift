//
//  extensions.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 01/01/2022.
//

import Foundation
import UIKit


extension UIViewController{
    func presentSimpleAlertView(title:String, message:String, actionTitle:String){
        let alertController:UIAlertController = UIAlertController(title:title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    func customPresentVC(_ viewController: UIViewController, animated: Bool){
        let vcToPresent = viewController
        vcToPresent.modalPresentationStyle = .fullScreen
        present(vcToPresent, animated: animated, completion: nil)
    }
    
    ///          We make our custom transition for when we will dismiss the viewController or present it  (instead of using the one by default which is a bit weird)
    public func customInstagramTransition(isDismiss: Bool){
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = .reveal
//        We do it like this because for the moment we only have dismiss and present
        if isDismiss == true {
        transition.subtype = CATransitionSubtype.fromLeft
        }else{
            transition.subtype = CATransitionSubtype.fromRight
        }
        self.view.window?.layer.add(transition, forKey: nil)
    }
    
}
extension UIScreen {
    
    var height: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    var width:  CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    var centerX:CGFloat {
        return UIScreen.main.bounds.size.width/2
    }
    
    var centerY:CGFloat {
        return UIScreen.main.bounds.size.height/2
    }
    var bottom:CGFloat {
        return UIScreen.main.bounds.origin.y + UIScreen.main.bounds.size.height
    }
}
extension UIView {
    
    var height:CGFloat {
        return self.frame.size.height
    }
    var width:CGFloat {
        return self.frame.size.width
    }
    
    var bottom:CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    var top:CGFloat {
        return self.frame.origin.y
    }
    var right:CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    var left :CGFloat {
        return self.frame.origin.x
    }
    var centerX:CGFloat {
        return self.frame.origin.x + self.frame.size.width/2
    }
    
    var centerY: CGFloat {
        return self.frame.origin.y + self.frame.size.height/2
    }
    var originX:CGFloat {
        return self.frame.origin.x
    }
    var originY:CGFloat {
        return self.frame.origin.y
    }
    var minX:CGFloat{
        return self.frame.minX
    }
    var minY:CGFloat{
        return self.frame.minY
    }
    
    var maxX:CGFloat{
        return self.frame.maxX
    }
    
    var maxY:CGFloat{
        return self.frame.maxY
    }
    

    
    convenience init(frame:CGRect = CGRect(x:0, y:0, width:mainScreen.width,height:mainScreen.height),translatesMaskInConstraints:Bool = true, backgroundColor:UIColor = .white) {
        self.init(frame:frame)
        self.translatesAutoresizingMaskIntoConstraints = translatesMaskInConstraints
        self.backgroundColor = backgroundColor
        
        
        
        
    }
 
    /// https://medium.com/@tate.pravin/swift-uiview-tapping-animation-extension-1f9a188b53b6
    func showAnimation(_ completionBlock: @escaping () -> Void) {
      isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
                            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {  (done) in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completionBlock()
            }
        }
    }
    
}


extension UIImageView {
    
    convenience init(named name: String = "", contentMode: UIView.ContentMode = .scaleToFill, frame:CGRect = CGRect(x: 0, y: 0, width: 0, height: 0), translatesMaskInConstraints:Bool = true, maskToBounds:Bool = true, cornerRadius:CGFloat = 0) {
//    guard let image = UIImage(named: name) else {
  //    return nil
// }
        let image = UIImage(named: name)
        self.init(image: image)
        self.contentMode = contentMode
        self.frame = frame
        self.translatesAutoresizingMaskIntoConstraints = translatesMaskInConstraints
        self.layer.masksToBounds = maskToBounds
        self.layer.cornerRadius = cornerRadius
  }
}


extension UIButton{
    //    By providing default values in convenience init, we won't need to call them when we will initiate objects.
    //    we will only call them if we want to modify them (like the frame that we only want to set in the viewDidLayoutSubviews() )
    //    Set translatesAutoresizingMaskIntoConstraints to True by default, If we need to use constraint, we will set it to False.
    convenience init(frame:CGRect = CGRect(x:0, y:0, width:0,height:0), title:String = "", titleColor:UIColor = .white, type:UIButton.ButtonType = .custom, backgroundColor:UIColor = .white, cornerRadius:CGFloat = 0, font: UIFont = UIFont.systemFont(ofSize: 14),alpha: CGFloat = 1, tintColor: UIColor = .blue, translatesMaskInConstraints:Bool = true) {
        self.init(type:type)
        self.frame = frame
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = translatesMaskInConstraints
        self.titleLabel?.font = font
        self.alpha = alpha
        self.tintColor = tintColor
        
    }

}

    


extension UILabel {
//    By providing default values in convenience init, we won't need to call them when we will initiate objects.
//    we will only call them if we want to modify them (like the frame that we only want to set in the viewDidLayoutSubviews() )
//    Set translatesAutoresizingMaskIntoConstraints  to True by default, If we need to use constraint, we will set it to False
    convenience init(frame:CGRect = CGRect(x:0, y:0, width:0,height:0),textColor:UIColor = .gray, font: UIFont, text:String = "", textAlignment:NSTextAlignment = .center, borderWidth:CGFloat = 0,no_lines:Int  = 1, translatesMaskInConstraints:Bool = true) {
        self.init(frame:frame)
        self.textColor = textColor
        self.font = font
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = translatesMaskInConstraints
        self.textAlignment = textAlignment
        self.layer.borderWidth = borderWidth
        self.numberOfLines = no_lines
    }
    
    
  /*  func labelIsTruncated(text:String, font:UIFont) -> Bool {
        CGSize size = [self.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
        if (size.width > label.bounds.size.width) {
           ...
        }
    }*/

        

    
    
}

extension UITextField {
    //    By providing default values in convenience init, we won't need to call them when we will initiate objects.
    //    we will only call them if we want to modify them (like the frame that we only want to set in the viewDidLayoutSubviews() )
    //    Set translatesAutoresizingMaskIntoConstraints to True by default, If we need to use constraint, we will set it to False.
    //    We want a space at the leftView, So we create a UIVIEW object with all frame equal to 0 except the height, our space
 
    convenience init(frame:CGRect = CGRect(x:0, y:0, width:0,height:0),placeholder:String,cornerRadius:CGFloat,borderWidth:CGFloat,backgroundColor:UIColor = UIColor.systemGray6,borderColor:UIColor = UIColor.systemGray,translatesMaskInConstraints: Bool = true, leftView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height:0)),leftViewMode: UITextField.ViewMode = .always, autoCorrection:UITextAutocorrectionType = .no) {
        self.init(frame:frame)
        self.placeholder = placeholder
        // screenHeight*(5/844), dynamic corner radius
        self.layer.cornerRadius = screenHeight*(cornerRadius/844)
        // screenWidth*(0.25/390), dynamic borderWidth
        self.layer.borderWidth = screenWidth*(borderWidth/390)
        self.backgroundColor = backgroundColor
        self.layer.borderColor = borderColor.cgColor
//        Assign our leftView to leftView attribute
        self.leftView = leftView
//        Set leftViewMode
        self.leftViewMode = leftViewMode
        self.translatesAutoresizingMaskIntoConstraints = translatesMaskInConstraints
        self.autocorrectionType = autoCorrection
        self.clearButtonMode = .always
        
    }
    /// when we don't want the user to input to inout nothing and push next or return button (prevent user from entering space at the beginning)
    func no_empty_Field(){
        guard let theText = self.text else{return}
        // prevent user from entering space at the beginning
        if (theText.isEmpty || theText == " "){
            self.text = ""
        }
        
    }
   
}


extension UIColor {
    
    static var InstagramBlue: UIColor  { return UIColor(red: 58.0/255, green: 172.0/255, blue: 227.0/255, alpha: 1.0) }
    static var FacebookBlue: UIColor { return UIColor(red:23.0/155, green: 89.0/155, blue: 242.0/155, alpha: 1.0) }
    static var darkBlue: UIColor { return UIColor(red:32.0/155, green: 51.0/155, blue: 84.0/155, alpha: 1.0) }
    static var transparent:UIColor {return UIColor(white:1.0, alpha: 0)}
}





extension Int {
    // display int with commas extension
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
    // display int with abbreviations
    var roundedWithAbbreviations: String {
         let number = Double(self)
         let thousand = number / 1000
         let million = number / 1000000
         if million >= 1.0 {
             return "\(round(million*10)/10)M"
         }
         else if thousand >= 1.0 {
             return "\(round(thousand*10)/10)K"
         }
         else {
             return "\(self)"
         }
     }
}

extension String {
    // find position (index) of given character
    public func index(of char: Character) -> Int? {
        if let idx = self.firstIndex(of: char) {
            return self.distance(from: startIndex, to: idx)
        }
        return nil
    }
}
// for confirmationCheckingViewController; resend code part
extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}


