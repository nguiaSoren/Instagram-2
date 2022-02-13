//
//  HomeViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 10/01/2022.
//

import UIKit

class HomeViewController: UIViewController {
    let homeTableView:UITableView = UITableView()
    let formatter = DateFormatter()
    // selected
    var moreButtonIndex:IndexPath!, likeButtonIndex:IndexPath!

    var posts = [InstagramPost]()
    // list of all the rows whose more button has been touched
    // we need to create it, in order to keep track of the already expanded cell , such that when we reaload
    // the rows when more button is touched, we dont turn the "already expanded cell" to their initial state
    var expandedRow = [Int]()
    // list of all the rows whose likeButton has been touched
    var likedRows = [Int]()
    // list of all the rows that has been unliked
    // we need it in order to update the number of likes
    var unlikedRows = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(homeTableView)
        homeTableView.separatorStyle = .none
        homeTableView.backgroundColor = .white
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(PostsTableViewCell.self, forCellReuseIdentifier: PostsTableViewCell.identifier)
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let someDateTime = formatter.date(from: "2016/10/08 00:00:00")
        let someDateTime2 = formatter.date(from: "2022/01/24 03:39:00")
        let birthday = formatter.date(from: "2002/11/26 00:00:00")
        posts.append(InstagramPost(id: 1, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime2!, legendPost: "Friedrich Nietzsche ✍️,really good philosopher, you should read more of his books, he talks about truth", numberOfLikes: 0, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 1, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 1, date: someDateTime!)], mediaSize: CGSize(width:1080, height: 1349), myImage: UIImage(named:"1")!, likedBy: [InstagramUser]()))
        
        posts.append(InstagramPost(id: 2, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "", numberOfLikes: 0, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!)], mediaSize: CGSize(width:1957, height: 1459), myImage: UIImage(named:"11")!,likedBy: [InstagramUser]()))
        
        posts.append(InstagramPost(id: 3, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "LeBron's height can be attributed to luck. He was around 5'7 when he was 11 and was told by a doctor he would only grow to be 6'3. James was able to beat the odds by growing to 6′8", numberOfLikes: 2, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 0, date: someDateTime!)], mediaSize: CGSize(width:2880, height: 1800), myImage: UIImage(named:"8")!,likedBy: [InstagramUser]()))
        
        posts.append(InstagramPost(id: 4, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "The average 11-year-old boy stands around 4'9, so LeBron was pretty tall for his age.", numberOfLikes: 3054, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 1, date: someDateTime!)], mediaSize: CGSize(width:3024, height: 2972), myImage: UIImage(named:"4")!,likedBy: [InstagramUser]()))
        
        posts.append(InstagramPost(id: 5, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "this is the image", numberOfLikes: 20300, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!)], mediaSize: CGSize(width:1080, height: 1349), myImage: UIImage(named:"1")!,likedBy: [InstagramUser]()))
        posts.append(InstagramPost(id: 6, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "this is the image", numberOfLikes: 100000, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!),InstagramComment(profilePicture: UIImage(named:"sophia")! , comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 1, date: someDateTime!)], mediaSize: CGSize(width:1957, height: 1459), myImage: UIImage(named:"11")!,likedBy: [InstagramUser]()))
        posts.append(InstagramPost(id: 7, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "Michael Jordan earned a majority of his current wealth from endorsements. In over four decades, he's earned $1.7 billion (pre-tax) off the court from brands like Nike, Coca-Cola, McDonald's, Wheaties, Chevrolet, etc, and is still involved with brands such as Nike, Hanes, Gatorade, and Upper Deck.", numberOfLikes: 219080, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!)], mediaSize: CGSize(width:2880, height: 1800), myImage: UIImage(named:"8")!,likedBy: [InstagramUser]()))
        posts.append(InstagramPost(id: 8, author:InstagramUser(fullName:["firstName":"soren Nguia"], birthday: birthday, safeEmail: "nguia@gmail.com", password: "mani", username: "soren_nj", profilePictureUrl: URL(string: "mani.com"), profilePicture: UIImage(named: "13")!, posts:[InstagramPost](), followers: [InstagramUser](), following: [InstagramUser](), bio:""), postMediaUrl: URL(string:"mani.com"), creationDate: someDateTime!, legendPost: "Satoru Gojo is one of the main protagonists of Jujutsu Kaisen. He is a special grade jujutsu sorcerer and a teacher at the Tokyo Jujutsu High.", numberOfLikes: 34, comments: [InstagramComment(profilePicture: UIImage(named:"sophia")!, comment:"this is a really nice picture", authorUsername: "sophia", no_likes: 3, date: someDateTime!)], mediaSize: CGSize(width:3024, height: 2972), myImage: UIImage(named:"4")!,likedBy: [InstagramUser]()))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = CGRect(x: 0, y:0, width: screenWidth, height: screenHeight)
    }

}

extension HomeViewController:UITableViewDataSource,UITableViewDelegate{
/////////dfghjkl
    func getCurrentCellIndexPath(_ sender: UIButton, with tableView:UITableView) -> IndexPath? {
        // Converts a point from the coordinate space of the current object to the specified coordinate space.
        // print(sender.layer.frame.origin) = (348.0, 43.0)
        let buttonPosition = sender.convert(CGPoint.zero, to:tableView)
        // we got the true y coordinates after having it converted
        // print(buttonPosition) = (348.0, 577.6666666666666)
        
        // use new coordinate from homeTableview space to get the indexPath of the buttonPosition
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
        cell.backgroundColor = .systemBackground
        // use function to configure cell
        cell.configure(post: posts[indexPath.row])
        // add target to likeButton
        cell.likeButton.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        cell.moreButton.addTarget(self, action: #selector(moreButtonTouched), for: .touchUpInside)
        // check if current row (current row) has been liked (before)
        if (likedRows.contains(indexPath.row)){
            // update the like symbol
            cell.likeButton.setImage(UIImage(named:"heart_filled"), for: .normal)
            // update the number of likes
            cell.updateNoLikes(post: posts[indexPath.row])
        // check if current row (current row) has been unliked
        } else if (unlikedRows.contains(indexPath.row)){
            // update the like symbol
            cell.likeButton.setImage(UIImage(named:"heart"), for: .normal)
            // update the number of likes
            cell.updateNoLikes(post: posts[indexPath.row])
        }
        // check if current row (cell) has already been expanded and if true, set  corresponding constraints
        (expandedRow.contains(indexPath.row)) ? cell.moreButtonTouchedChanges(): nil
        return cell
    }
    
    @objc func likeButtonTouched(sender:UIButton){
        // la facon de faire ca est très mauvaise, on doit  check if currentUser is in the list of likedBy to set the status of the likeButton; but since we are not there yet it's allright; we will only substitute later
        // get selectedIndex
        likeButtonIndex = getCurrentCellIndexPath(sender, with: homeTableView)
        // update ButtonImage
        let buttonImage = (sender.currentImage == UIImage(named: "heart")) ? UIImage(named:"heart_filled"):UIImage(named:"heart")
        sender.setImage(buttonImage, for: .normal)
        // update number of likes according to previous update
        (buttonImage == UIImage(named:"heart_filled")) ? (posts[likeButtonIndex.row].numberOfLikes += 1) : (posts[likeButtonIndex.row].numberOfLikes -= 1)
       
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
        homeTableView.beginUpdates()
        // reload at specific row; by reload, we mean everything << cellForRowAt indexPath, height,
        homeTableView.reloadRows(at:[likeButtonIndex], with: .none)
        // finish updating
        homeTableView.endUpdates()
    }
    
    @objc func moreButtonTouched(sender:UIButton){
        // get selectedIndex
        moreButtonIndex = getCurrentCellIndexPath(sender, with: homeTableView)
        // add selectedIndex.row to rowTouched array
        expandedRow.append(moreButtonIndex.row)
        // tell view we are gonna start update
        homeTableView.beginUpdates()
        // reload at specific row; by reload, we mean everything << cellForRowAt indexPath, height,
        homeTableView.reloadRows(at: [moreButtonIndex], with: .none)
        // finish updating
        homeTableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // get ratio of post media
        let (aRatio,bRatio) = posts[indexPath.row].mediaRatio
        // use ratio of post media to calculate corresponding height
        let imageHeight = ((screenWidth-10)*CGFloat(bRatio))/CGFloat(aRatio)
        let containerViewHeight:CGFloat = 60
        var reactionViewHeight:CGFloat = {
        // we will use attributedText to get an estimated height of the label, the topAnchorConstraint, the buttons height, etc; We gonna sum up all of this to get an estimated size
        // like button, comment button, etc
            
        let buttonWidthHeight = screenWidth*(25/390)
        // create attributedText for nolIKES
        let attributedNoLikes = NSMutableAttributedString(string:"\(posts[indexPath.row].numberOfLikes)",attributes: [NSAttributedString.Key.font : UIFont(name:"HelveticaNeue-Medium", size:14)!])
        //  if there is 0 LIKE, it is hidden and as a consequence, its height is 0; if there are likes, get estimated height from size method from NSMutableAttributedString
        let noLikesHeight = (posts[indexPath.row].numberOfLikes == 0) ? 0: attributedNoLikes.size().height
            // if there is 0 like, that view doesn't exist and so its topAnchor constant is 0; if there is, predefined topAnchorConstant
        let noLikesTopAnchorConstant = (posts[indexPath.row].numberOfLikes == 0) ? 0: screenWidth*(14/390)
        let attributedUsername = NSMutableAttributedString(string:posts[indexPath.row].author.username!,attributes: [NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-Medium", size: 15)!])
        // get estimated height from size method; if there is no legend, it is hidden and as a consequence, its height is 0
        let legendUsernameHeight = (posts[indexPath.row].legendPost.isEmpty) ? 0:attributedUsername.size().height
        // if there is no legend, that view doesn't exist and so its topAnchor constant is 0; if there is, predefined topAnchorConstant
        let legendTopAnchorHeight = (posts[indexPath.row].legendPost.isEmpty) ? 0:screenWidth*(8/390)
        // if there is no comment, that view doesn't exist and so its height is 0; if there is, predefined height
        let viewCommentHeight = (posts[indexPath.row].comments.count == 0) ? 0: screenWidth*(20/390)
        // if there is no comment, that view doesn't exist and so its topAnchor constant is 0; if there is, predefined topAnchorConstant
        let viewCommentTopAnchorConstant = (posts[indexPath.row].comments.count == 0) ? 0:screenHeight*(10/844)
        // create mutableAttributedString with correct font (we need to use correct font to get a good sze estimation, if not it might use the system font)
        let attributedPostLifeTime = NSMutableAttributedString(string:"100",attributes: [NSAttributedString.Key.font:UIFont(name:"HelveticaNeue-Medium", size:14)!])
        // get estimated height from size method
        let attributedPostLifeTimeHeight = attributedPostLifeTime.size().height
        // set attributedText topAnchorConstant
        let attributedPostLifeTimeTopAnchorConstant = screenWidth*(8/390)
        // 11 is like/comment/share button y
        // sum up all of the estimated height of the labels, the topAnchorConstraint, the buttons height, etc to get reactionContainerViewHeight
        return 11+buttonWidthHeight + noLikesTopAnchorConstant + noLikesHeight + legendTopAnchorHeight + legendUsernameHeight + viewCommentTopAnchorConstant + viewCommentHeight + attributedPostLifeTimeHeight + attributedPostLifeTimeTopAnchorConstant
        }()
        // case where moreButton has (already) been touched
        if (expandedRow.contains(indexPath.row)){
            let legend = PostsTableViewCell().makeLegendText(post: posts[indexPath.row])
            let firstHeight = legend.size().height
            // boundingRect = Returns the bounding rectangle (CGRect) necessary to draw the string.
            // https://stackoverflow.com/questions/28362844/confused-by-nsstringdrawingoptions-item-meaning
            //https://geek-is-stupid.github.io/2015-07-16-how-to-calculate-the-height-of-the-text-depends-on-width-and-font-its-by-using-swift/
            // 13 is x of legend and -20 is the constant, legend.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor, constant:-20);
            // so total width of label is screenWidth-20-13
            let bounds = legend.boundingRect(with: CGSize(width:screenWidth-33, height:.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            let size = CGSize(width: round(bounds.width), height: round(bounds.height))
            let newHeight = size.height
            reactionViewHeight -= firstHeight
            reactionViewHeight += newHeight
        }
        
        // sum all View to get height; we add 10 to leave a bit of space at the end
        return containerViewHeight+imageHeight+reactionViewHeight+10
    }
    

}
