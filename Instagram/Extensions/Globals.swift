//
//  Globals.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 01/01/2022.
//

protocol PostsTableViewCellDelegate {
    // https://stackoverflow.com/questions/39947076/uitableviewcell-buttons-with-action/39947434#39947434
    // https://stackoverflow.com/questions/27616980/ios-swift-how-to-create-a-protocol-instance
}

import Foundation
import UIKit
import NVActivityIndicatorView




// Public informations
// don't modify those, please
public let mainScreen:UIScreen = UIScreen.main
public let screenWidth:CGFloat = UIScreen.main.width
public let screenHeight:CGFloat = UIScreen.main.height
public var currentUser = InstagramUser(fullName: ["firstName":"Benaja Soren"], birthday: Date(), safeEmail: "nguiasoren@gmail.com", password: "azertyone123", username: "soren obounou", profilePictureUrl: URL(string: "soren.com"), profilePicture: UIImage(named: "14")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:"")




// CLASS




class NextButton:UIButton{
    let title2:String = "Next"
    let backgroundColor2:UIColor = UIColor.InstagramBlue
    let cornerRadius2:CGFloat = screenHeight*(5/844)
    let font2:UIFont = UIFont(name: "HelveticaNeue-Bold", size: 16)!
    let alpha2:CGFloat = 0.74
    let translatesAutoresizingMaskIntoConstraints2: Bool = false
    let activityIndicatorView = NVActivityIndicatorView(frame:CGRect() , type: .circleStrokeSpin, color:.white)

    override init(frame:CGRect) {
        super.init(frame: frame)
        self.setTitle(title2, for:.normal)
        self.backgroundColor = backgroundColor2
        self.layer.cornerRadius = cornerRadius2
        self.titleLabel?.font = font2
        self.alpha = alpha2
        self.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints2
        self.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.addTarget(self, action: #selector(touched), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // add first Target, don't forget that we can add several targets for action. The user could set the others
    @objc func touched(_ sender:UIButton){
        // it will be animated by default
        if (self.alpha == 1){
            self.showAnimation {
                // it will start animating by defaut
            //    self.startAnimating()
            }
        }
    }
    // the coder can start animating and only stopAnimating() when it got to what he wanted
    func startAnimating(){
        // we activate here, because we will only have the real frame(height,width) here ( in init, it's still 0.0, 0.0)
        // use constraints to center the activity indicator view in the button
        activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        // use constraints to set custom size for the activity indicator view
        activityIndicatorView.heightAnchor.constraint(equalToConstant:20).isActive = true
        activityIndicatorView.widthAnchor.constraint(equalToConstant:20).isActive = true
        //hide title
        self.setTitleColor(.clear, for: .normal)

        // start animating
        activityIndicatorView.startAnimating()
    }
    
    func stopAnimating(){
        activityIndicatorView.stopAnimating()
        //show  title
        self.setTitleColor(.white, for: .normal)
    }
}

class TextFieldViewComment:UIView{
   //  https://stackoverflow.com/questions/43332739/how-to-override-init-in-the-subclass-in-swift-3
    let commentTextField = UITextField(placeholder: "", cornerRadius: 20,borderWidth: 1, backgroundColor: .white,translatesMaskInConstraints: false)
    var username:String = " "
    var profilePictureView:UIImageView = {
        let imageView = UIImageView(translatesMaskInConstraints: false)
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()
    let rightView = UIView(translatesMaskInConstraints: false,backgroundColor:.black)
    let postButton = UIButton(title: "Post", titleColor: .InstagramBlue, backgroundColor:.transparent, translatesMaskInConstraints: false)
    
    

    init(frame2: CGRect,username:String,profilePicture:UIImage) {
        super.init(frame:frame2)
        self.addSubview(profilePictureView)
        self.addSubview(commentTextField)
        self.backgroundColor = .blue
        self.username = username
        self.profilePictureView.image = profilePicture
       // rightView.addSubview(postButton)
        commentTextField.placeholder = "Add a comment as \(username)..."
        commentTextField.font = UIFont(name:"HelveticaNeue-Light", size: 13)
        // in case username is too long, we gotta make sure user doesn't set very long username
        commentTextField.adjustsFontSizeToFitWidth = true
        commentTextField.minimumFontSize = 10
        commentTextField.textColor = .darkGray
        commentTextField.rightView = postButton
        commentTextField.rightViewMode = .always
       
       // setConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        print(self.height)
        print(self.width)
        
        let bottomConstraint:CGFloat = (self.height > 111) ? -40: -20
        let textViewHeight:CGFloat = (self.height < 95) ? 35: 45
        let cornerRadius:CGFloat = (self.height < 95) ? 15: 20
        // profilePicture.x(20) + profilePicture.height(textViewHeight) + txtFieldleftAnchor(10) + rightAnchor(20)
        let commentFieldAnchorConstant:CGFloat = -(20 + textViewHeight + 10 + 20)
        
        profilePictureView.leftAnchor.constraint(equalTo:self.leftAnchor, constant: 20).isActive = true
        profilePictureView.widthAnchor.constraint(equalToConstant:textViewHeight).isActive = true
        profilePictureView.heightAnchor.constraint(equalToConstant:textViewHeight).isActive = true
        profilePictureView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomConstraint).isActive = true
        // set textField Constraints
        
        commentTextField.leftAnchor.constraint(equalTo: profilePictureView.rightAnchor,constant: 10).isActive = true
        commentTextField.widthAnchor.constraint(equalTo:self.widthAnchor,constant: commentFieldAnchorConstant).isActive = true
        commentTextField.heightAnchor.constraint(equalToConstant: textViewHeight).isActive = true
        commentTextField.centerYAnchor.constraint(equalTo:profilePictureView.centerYAnchor).isActive = true
        commentTextField.layer.cornerRadius = cornerRadius
        
        postButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        postButton.widthAnchor.constraint(equalToConstant:60).isActive = true
     
    }

 
}












// FUNCTIONS
public func emailChecker(email: String) -> Bool{
    let emailChecker1 = NSPredicate(format: "SELF MATCHES %@ ","^(?=.*[a-z])(?=.*[@])(?=.*[.]).{3,}$")
    return emailChecker1.evaluate(with: email)
}

public func passwordChecker(password: String) -> Bool{
    let passwordChecker1 = NSPredicate(format: "SELF MATCHES %@ ","^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])(?=.*[$@$#!%*?&]).{8,}$")
    return passwordChecker1.evaluate(with: password)
}

/// dismiss textField keyboard when view is touched, end all editing
public func touchEndsViewEditing(_ view:UIView){
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
}


public func navControllerPushVc(_ viewControllerToPresent:UIViewController,_ navController:UINavigationController?){
    let navVC = viewControllerToPresent
    navVC.modalPresentationStyle = .fullScreen
    navController?.pushViewController(navVC, animated: true)
}


/// This function uses the adobeXD template to return dynamic frame
public func customRect(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat) -> CGRect{
    /* x, y, width, height represent the coordinates ot the object on adobeXD, by multiplying  the screenWidth or
    the screenHeight by the ratio of those, we get dynamic frame on all iphone */
    // iphone 12: width = 390, height = 844
    let new_frame = CGRect(x:screenWidth*(x/390), y: screenHeight*(y/844), width: screenWidth*(width/390), height: screenHeight*height/844)
    return new_frame
}

/// when to show the user he can use the button
public func buttonSwitches(button:UIButton, on:Bool){
    if (on){
        button.alpha = 1
        button.backgroundColor = .FacebookBlue
    }else{
        button.alpha = 0.74
        button.backgroundColor = .InstagramBlue
    }
}
// calculate greatest common divisor
func gcd (_ n1: Int, _ n2: Int) -> Int {
    if n2 != 0 {
    return gcd(n2, n1 % n2)
    } else {
    return n1
    }
}

// reduce fraction
func reduceQuotient(_ a: Int, _ b: Int) -> (aReduced: Int, bReduced: Int) {
    // return tuple
    var aReduced = a
    var bReduced = b
   
    if b == 0 {
        print("\(a) : \(b) is not a fraction")
            return (a, b)
    }
   
    let greatestCommonDivisor = gcd(a, b)
    aReduced = a / greatestCommonDivisor
    bReduced = b / greatestCommonDivisor

    return (aReduced, bReduced)
}


// let (x, y) = reduceQuotient(100, 50)
// print(x, ":", y)

public func postTimeDifference(from firstDate: Date, to secondDate:Date, post:Bool) -> String{
    // To convert seconds to months in Swift we need to notice not every month is equal in length. To account for this, let’s use the average number of days in a month, that is, 30.4369
    // To convert seconds to years in Swift you need to remember that a year is not exactly 365 days in length. On average it is 365.2422 days long:
    let oneMinute = 60.0, oneHour = 60.0*60.0, oneDay = 60.0*60.0*24.0, oneWeek = 60.0*60.0*24.0*7.0, oneMonth = 60.0 * 60.0 * 24.0 * 30.4369, oneYear = 60.0 * 60.0 * 24.0 * 365.2422
    // This is the number of seconds between the two dates and we want it to be positive
    let no_seconds = abs(firstDate.timeIntervalSinceReferenceDate - secondDate.timeIntervalSinceReferenceDate)
    // if number of second is less than 1 minute, display in second(s)
    if (no_seconds < oneMinute){
        // we don't want comma , so we convert to int
        let no_seconds2 = Int(floor(no_seconds))
        if (post) {
            return (no_seconds2 > 1) ? "\(no_seconds2) seconds ago": "\(no_seconds2) second ago"
        } else{
            return "\(no_seconds2)s"
        }
    // check if number of seconds is in one minute
    } else if (no_seconds >= oneMinute && no_seconds < oneHour){
       // round down with floor; number of minute(s)
        let no_minutes = Int(floor(no_seconds/60.0))
        // return number of minutes
        if (post){
            return (no_minutes > 1) ? "\(no_minutes) minutes ago": "\(no_minutes) minute ago"
        } else{
            return "\(no_minutes)min"
        }
    // check if number of second is in a day
    } else if (no_seconds >= oneHour && no_seconds < oneDay){
        //  number of hour(s)
        let no_hours = Int(floor(no_seconds / oneHour))
        // return number of hours
        if (post){
            return (no_hours > 1) ? "\(no_hours) hours ago":"\(no_hours) hour ago"
        } else{
            return "\(no_hours)h"
        }
    // check if number of seconds is in a week
    } else if (no_seconds >= oneDay && no_seconds < oneWeek){
        let no_days = Int(floor(no_seconds / oneDay))
        // return nmber of days
        if (post){
            return (no_days > 1) ? "\(no_days) days ago":"\(no_days) day ago"
        } else{
            return "\(no_days)d"
        }
        
    // check if number of seconds is in a week
    } else if (no_seconds >= oneWeek && no_seconds < oneMonth){
        // number of week(s)
        let no_weeks = Int(floor(no_seconds/oneWeek))
        // return number of week(s)
        if (post){
            return (no_weeks > 1) ? "\(no_weeks) weeks ago":"\(no_weeks) week ago"
        } else{
            return "\(no_weeks)w"
        }
    } else if (no_seconds >= oneMonth && no_seconds < oneYear){
        // number of months
        let no_months = Int(floor(no_seconds / oneMonth))
        // return number of month(s)
        if (post){
            return (no_months > 1) ? "\(no_months) months ago":"\(no_months) week ago"
        } else{
            // for comments, we don't display months but weeks
            let value = Int((no_seconds/oneMonth) * 4)
            return "\(value)w"
        }
       
    } else if (no_seconds > oneYear){
        // number of years
        let no_years = Int(floor(no_seconds / oneYear))
        // return number of years
        if (post){
            return (no_years > 1) ? "\(no_years) years ago":"\(no_years) year ago"
        } else{
            // for comments, we don't display months but weeks
            let value = Int((no_seconds/oneMonth) * 4)
            return "\(value)w"
        }
        
    }
    return "00"
}


// class


class QueryUser:InstagramUser {
    var foundInUsername:Bool = false
    var foundInName:Bool = false
    // A lazy var is a property whose initial value is not calculated until the first time it's called.
    // if we don't use lazy var, it will tell us that we need the foundInUsername and  foundInName, or ils sont
    // set dans le init() method
    lazy var foundInBoth:Bool  = (foundInUsername && foundInName)
    init(fullName:[String:String]?, birthday:Date?, safeEmail:String?, password:String?,username: String?, profilePictureUrl:URL?,profilePicture:UIImage,posts:[InstagramPost],followers: [InstagramUser] ,following: [InstagramUser],bio:String?,foundInUsername:Bool,foundInName:Bool){
        self.foundInUsername = foundInUsername
        self.foundInName = foundInName
        super.init(fullName:fullName, birthday:birthday, safeEmail:safeEmail, password:password,username:username, profilePictureUrl:profilePictureUrl, profilePicture: profilePicture,
                   posts:posts,followers:followers ,following:following, bio: bio) // use the init of parent class (InstagramUser)
    }
    // I didn't use mutating because By using static keyword before method name means, we call method by struct/class name (Not by an object) so we don't have any object here.
    // By using mutating keyword, we are mutating 'self' object. So while using static we don't have any object to mutate.
    static func lookForUser(with username: String , for user: inout InstagramUser){

    }
    static func lookForUser(with fullName: [String:String] , for user: inout InstagramUser){

    }
    static func filterQueryUsers(queryUsers: inout [QueryUser]){

    // filtrer en fonction de l'username and name
    }
}



/*
// creer cette main collection dans firebase
// Search_user contains a collection of User whose title is safeEmail
// We will use this struct for the query in the searhController, those are the infos that will be displayed
struct User {
    var fullName:[String]? // on peut check si le nom inputted est dans le full name
    var username: String? // ou si ca correspond à l'username et de la, si ca passe, on peut prendre l'email
    var safeEmail:String? /*  les users avec ces caracteristiques la, on prend leur safeEmail
    pour pouvoir les chercher dans la base de données generale(instagramUser). Puisque le titre de chaque collection commence avec
    le safeEmail et sera separé par - or _ etc */
    // on donne priorité si l'username a ete used for the query
    var profilePictureUrl:URL? // put var profilePictureUrl:URL? = url of the default one
   // var profilePicure:UIImage? // put var profilePictureImage:UIImage? = default's image
}

public var profileIsCurrentUser:Bool = false
// safeEmail of currentUser
public var safeEmail = String()
 
var followButton:UIButton = {
   self.isHidden = profileIsCurrentUser
}()
var messageButton:UIButton = {
   self.isHidden = profileIsCurrentUser
}()
 
var editProfileButton:UIButton = {
   self.isHidden = !profileIsCurrentUser
}()

var userSelected = User(["soren"],"soren_nj", "nguiasoren@gmail.com")
var currentUser =  User(["soren"],"soren_nj", "nguiasoren@gmail.com")
profileIsCurrentUser = (userSelected.safeEmail == safeEmail)

var ProfileViewController:UIController = ProfileViewController(profileIsCurrentUser,userSelected) */

//print("mani oh",profileIsCurrentUser)





/* public func setUpBarController(_ theViewController:UIViewController,_ imageName:String,_ selectedImageName:String) -> UIViewController{
//    We embed every view in a navigation controller
    let theVC:UIViewController = UINavigationController(rootViewController: theViewController)
    let item = UITabBarItem()
    item.image = UIImage(named: imageName)
    item.selectedImage = UIImage(named: selectedImageName)
    theVC.tabBarItem = item
    return theVC
}


 public func setUpTabController() -> UITabBarController{
    let tabController = UITabBarController()
    tabController.viewControllers = [setUpBarController(HomeViewController(),"home", "home-full"), setUpBarController(SearchViewController(), "search", "search-full"), setUpBarController(TikTokViewController(), "tiktok", "tiktok-white"),setUpBarController(ShopViewController(),"shopping-bag","shopping-bag-full"),setUpBarController(ProfileViewController(),"user", "user-full")]
    tabController.tabBar.barTintColor = UIColor(red:1, green:0, blue:0, alpha:1)
    return tabController
}
*/


