//
//  CommentsViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 26/01/2022.
//

import UIKit

class CommentsViewController: UIViewController {
    var legendLeftTopConstant:CGFloat = 14
    var profilePictureLeftConstant:CGFloat = 10
    // style is grouped because I need it to move along with the tableView
    // screenHeight*(110/844) is the textFieldView
    var theView:TextFieldViewComment!
    let commentsTableView:UITableView = UITableView(frame: CGRect(x: 0, y: screenHeight*(93/844), width: screenWidth, height: screenHeight-screenHeight*(93/844) - screenHeight*(140/844)), style: .grouped)
    var post:InstagramPost!
  //  var comment
    let formatter = DateFormatter()
    var headerView:UIView = UIView()
    var postLifeTimeLabel:UILabel = UILabel(textColor: .systemGray4, font: UIFont(name:"HelveticaNeue-Medium", size:12)!, translatesMaskInConstraints: false)
    var legend = UILabel(textColor: .black, font: UIFont(name: "HelveticaNeue-Medium", size: 15)!, textAlignment: .left,  no_lines: 0, translatesMaskInConstraints: false)
    var profilePicture = UIImageView()
    var likeButtonIndex:IndexPath!
    // list of all the rows whose likeButton has been touched
    var likedRows = [Int]()
    // list of all the rows that has been unliked
    // we need it in order to update the number of likes
    var unlikedRows = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        theView = TextFieldViewComment(frame2: CGRect(x: 0, y: commentsTableView.bottom, width: screenWidth, height: screenHeight*(140/844)), username: currentUser.username!, profilePicture: currentUser.profilePicture)
        view.addSubview(theView)
       
        view.backgroundColor = .white
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        commentsTableView.register(CommentsTableViewCell.self, forCellReuseIdentifier:CommentsTableViewCell.identifier)
        commentsTableView.separatorStyle = .singleLine
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let someDateTime = formatter.date(from: "2016/10/08 00:00:00")
        let birthday = formatter.date(from: "2002/11/26 00:00:00")
        post = InstagramPost(id: 8, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "Satoru Gojo is one of the main protagonists of Jujutsu Kaisen.\nHe is a special grade jujutsu sorcerer and a teacher at the Tokyo Jujutsu High.LeBron's height can be attributed to luck.\nHe was around 5'7 when he was 11 and was told by a doctor he would only grow to be 6'3. James was able to beat the odds by growing to 6′8", numberOfLikes: 34, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 30, date: someDateTime!), InstagramComment(profilePicture: UIImage(named:"3")!, comment:"LeBron's height can be attributed to luck. He was around 5'7 when he was 11 and was told by a doctor he would only grow to be 6'3. James was able to beat the odds by growing to 6′8", authorUsername: "sophia", no_likes:12390, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"5")!, comment:"The average 11-year-old boy stands around 4'9, so LeBron was pretty tall for his age.Friedrich Nietzsche ✍️,really good philosopher, you should read more of his books, he talks about truth", authorUsername: "sophia", no_likes:0, date: someDateTime!), InstagramComment(profilePicture: UIImage(named:"5")!, comment:"Michael Jordan earned a majority of his current wealth from endorsements. In over four decades, he's earned $1.7 billion (pre-tax) off the court from brands like Nike, Coca-Cola, McDonald's, Wheaties, Chevrolet , etc, and is still involved with brands such as Nike, Hanes, Gatorade, and Upper Deck.", authorUsername: "sophia", no_likes:320, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 30, date: someDateTime!), InstagramComment(profilePicture: UIImage(named:"3")!, comment:"LeBron's height can be attributed to luck. He was around 5'7 when he was 11 and was told by a doctor he would only grow to be 6'3. James was able to beat the odds by growing to 6′8", authorUsername: "sophia", no_likes:12390, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"5")!, comment:"The average 11-year-old boy stands around 4'9, so LeBron was pretty tall for his age.Friedrich Nietzsche ✍️,really good philosopher, you should read more of his books, he talks about truth", authorUsername: "sophia", no_likes:0, date: someDateTime!), InstagramComment(profilePicture: UIImage(named:"5")!, comment:"Michael Jordan earned a majority of his current wealth from endorsements. In over four decades, he's earned $1.7 billion (pre-tax) off the court from brands like Nike, Coca-Cola, McDonald's, Wheaties, Chevrolet, etc, and is still involved with brands such as Nike, Hanes, Gatorade, and Upper Deck. Michael Jordan earned a majority of his current wealth from endorsements. In over four decades, he's earned $1.7 billion (pre-tax) off the court from brands like Nike, Coca-Cola, McDonald's, Wheaties, Chevrolet, etc, and is still involved with brands such as Nike, Hanes, Gatorade, and Upper Deck.", authorUsername: "sophia", no_likes:3200000, date: someDateTime!)], mediaSize: CGSize(width:3024, height: 2972), myImage: UIImage(named:"4")!,likedBy: [InstagramUser]())
        headerView.backgroundColor = .systemBackground
        // transparent black
        headerView.layer.borderColor = UIColor(red:0.0, green: 0.0, blue: 0.0, alpha: 0.3).cgColor
        headerView.layer.borderWidth = 0.25
        view.addSubview(commentsTableView)
        commentsTableView.tableHeaderView = headerView
        commentsTableView.backgroundColor = .systemBackground

        headerView.addSubview(profilePicture)
        headerView.addSubview(legend)
        headerView.addSubview(postLifeTimeLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0, y: 0, width: commentsTableView.width, height: setHeaderViewHeight())
    }
    

    func setHeaderViewHeight() -> CGFloat{
        // set profilePicture frame
        profilePicture.frame = CGRect(x: profilePictureLeftConstant, y: 14, width: 40, height: 40)
        // round it
        profilePicture.layer.cornerRadius = 20
        profilePicture.layer.masksToBounds = false
        profilePicture.clipsToBounds = true
        profilePicture.contentMode = .scaleToFill
        // set image
        profilePicture.image = post.author.profilePicture
        // set legend constraint
        legend.topAnchor.constraint(equalTo:headerView.topAnchor, constant: legendLeftTopConstant).isActive = true
        legend.leftAnchor.constraint(equalTo:profilePicture.rightAnchor, constant: legendLeftTopConstant).isActive = true
        legend.widthAnchor.constraint(lessThanOrEqualTo:headerView.widthAnchor,constant: -84).isActive = true
        legend.attributedText = makeLegendText(post: post)
        // set postLifeTimeLabel constraint
        postLifeTimeLabel.topAnchor.constraint(equalTo:legend.bottomAnchor, constant: 14).isActive = true
        postLifeTimeLabel.leftAnchor.constraint(equalTo:legend.leftAnchor).isActive = true
        postLifeTimeLabel.widthAnchor.constraint(lessThanOrEqualTo:headerView.widthAnchor).isActive = true
        // set text
        postLifeTimeLabel.text = postTimeDifference(from:post.creationDate, to: Date(), post: false)
        
        let attributedPostLifeTime = NSMutableAttributedString(string:"100",attributes: [NSAttributedString.Key.font:UIFont(name:"HelveticaNeue-Medium", size:12)!])
        // get estimated height from size method
        let attributedPostLifeTimeHeight = attributedPostLifeTime.size().height
         // 10 (profilePicture.x) + 40(profilePicture.width) + 14 (leftAnchor) +20(rightAnchor)
        let bounds = legend.attributedText!.boundingRect(with: CGSize(width:screenWidth-84, height:.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
        let legendSize = CGSize(width: round(bounds.width), height: round(bounds.height))
        // return compounded height
        // 10 (profilePicture.x) + 40(profilePicture.width) + 14 (leftAnchor) +20(rightAnchor)
        return 14 + legendSize.height + 14 + attributedPostLifeTimeHeight + 10
    }
    
    // the legendText of commentsViewController's headerView has a line spacing of 4, while normal cells will use the normal makeLegendText of postsTableViewCell
    func makeLegendText(post:InstagramPost) -> NSMutableAttributedString{
        let legendText:NSMutableAttributedString = {
            if (!post.legendPost.isEmpty){
                let string = post.author.username! + " " + post.legendPost
                // find index of space (" ") such that we could set username font to bold (username is separated from legend by the first space).
                let spaceIndex = string.index(of:" ")
                let attributedText = NSMutableAttributedString(string: string)
                // change username part color to black
                attributedText.addAttribute(.foregroundColor, value:UIColor.black, range: NSRange(location:0, length: spaceIndex!))
                // change "Username" to bold part font to bold
                attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Medium", size: 15)!, range: NSRange(location: 0, length:spaceIndex!))
                // change rest to normal font, we need to do that (again) to be able to get a good estimation of the size later on
                attributedText.addAttribute(.font, value: UIFont(name:"Arial", size:14)!, range: NSRange(location:spaceIndex!+1, length:attributedText.length-(spaceIndex!+1)))
                 // *** Create instance of `NSMutableParagraphStyle`
                 let paragraphStyle = NSMutableParagraphStyle()

                 // *** set LineSpacing property in points ***
                 paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points

                 // *** Apply attribute to string ***
                 attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
             
                return attributedText
            }
            return NSMutableAttributedString(string:"")
        }()
        return legendText
    }
    
    
  

}

extension CommentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: CommentsTableViewCell.identifier, for: indexPath) as! CommentsTableViewCell
        cell.configure(comment:post.comments[indexPath.row], post: post)
        cell.updateNoLikes(comment: post.comments[indexPath.row])
        cell.likeButton.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        if (likedRows.contains(indexPath.row)){
            // update the like symbol
            cell.likeButton.setImage(UIImage(named:"heart_filled"), for: .normal)
            // update the number of likes
            cell.updateNoLikes(comment: post.comments[indexPath.row])
        // check if current row (current row) has been unliked
        } else if (unlikedRows.contains(indexPath.row)){
            // update the like symbol
            cell.likeButton.setImage(UIImage(named:"heart_gray"), for: .normal)
            // update the number of likes
            cell.updateNoLikes(comment: post.comments[indexPath.row])
        }
        
        return cell
        //return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2.5 // Whatever line spacing you want in points
        paragraphStyle.lineBreakMode = .byCharWrapping
        let attributedComment = NSMutableAttributedString(string: post.comments[indexPath.row].comment,attributes: [NSAttributedString.Key.font : UIFont(name:"HelveticaNeue-Light", size: 12)!, NSAttributedString.Key.paragraphStyle : paragraphStyle])
      
        // we use 120/30/40/50 instead of 110 in height, because the textLineBreakMode is byWordWrapping; it will go to the nextLine if the current Word can't suffice in current line and because of this repetitive behavior, the height will increase. We can simply use the normal heightConstraint 110 if we set the lineBreakMode to .byCharWrapping
      // case we use emojis
        let framesetter = CTFramesetterCreateWithAttributedString(attributedComment)
        let size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0, length: attributedComment.length), nil, CGSize(width:screenWidth-110, height: .greatestFiniteMagnitude), nil)
        let attributedCommentHeight = round(size.height)
        

        // profilePicture.y(14)+ attributedCommentHeight+ noLikesLabel.topAnchorconstant(14) + replyButton.heightConstant(15) + extraSpace I want(10)
        return 14 + attributedCommentHeight + 14 + 15 + 10
    }
    @objc func likeButtonTouched(sender:UIButton){
        // la facon de faire ca est très mauvaise, on doit  check if currentUser is in the list of likedBy to set the status of the likeButton; but since we are not there yet it's allright; we will only substitute later
        // get selectedIndex
        likeButtonIndex = HomeViewController().getCurrentCellIndexPath(sender, with: commentsTableView)
        // update ButtonImage
        let buttonImage = (sender.currentImage == UIImage(named: "heart_gray")) ? UIImage(named:"heart_filled"):UIImage(named:"heart_gray")
        sender.setImage(buttonImage, for: .normal)
        // update number of likes according to previous update
        (buttonImage == UIImage(named:"heart_filled")) ? (post.comments[likeButtonIndex.row].no_likes += 1) : (post.comments[likeButtonIndex.row].no_likes -= 1)
       
        if (buttonImage ==  UIImage(named:"heart_filled")) {
            likedRows.append(likeButtonIndex.row)
            // if index is in unliked row list, remove it from there because we just added it to likedRow
            if let index = unlikedRows.firstIndex(of: likeButtonIndex.row) {unlikedRows.remove(at: index)}
        } else{
            unlikedRows.append(likeButtonIndex.row)
            // if index is in likedRow, remove it from there because we just added it to unlikedRow
            if let index = likedRows.firstIndex(of: likeButtonIndex.row) {likedRows.remove(at: index)}
        }
        // tell view we are gonna start update
        commentsTableView.beginUpdates()
        // reload at specific row; by reload, we mean everything << cellForRowAt indexPath, height,
        commentsTableView.reloadRows(at:[likeButtonIndex], with: .none)
        // finish updating
        commentsTableView.endUpdates()
    }

}
