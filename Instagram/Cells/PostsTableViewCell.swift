//
//  PostsTableViewCell.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 10/01/2022.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    static let identifier = "PostsTableViewCell"
    let profileContainerView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:60))
    let profileImage = UIImageView()
    let username = UILabel(textColor: .black, font: UIFont(name:"HelveticaNeue-Bold", size:16)!,textAlignment: .left, translatesMaskInConstraints: false)
    
    let optionButton = UIButton(translatesMaskInConstraints: false)
    private let postImage1 = UIImageView()
    let reactionContainerView = UIView(translatesMaskInConstraints: false)
    let likeButton = UIButton()
    let commentButton = UIButton()
    let shareButton = UIButton()
    let savePostButton = UIButton()

    var noLikesLabel = UILabel( textColor: .black, font: UIFont(name:"HelveticaNeue-Medium", size:14 )!, textAlignment:.left,translatesMaskInConstraints: false)
    // no space in userName
    var legend = UILabel(textColor:.black,font:UIFont(name:"Arial", size:14)!, textAlignment: .left,translatesMaskInConstraints:false)
    var moreButton = UIButton(title:"more", titleColor:.systemGray3,backgroundColor: .systemBackground, font: UIFont(name:"Arial", size:14)!,translatesMaskInConstraints: false)
    //set that in array such that I could activate and deactivate more easily later on
    var topConstraint1:[NSLayoutConstraint]!, topConstraint2:[NSLayoutConstraint]!
    var viewCommentButton = UIButton(titleColor: .systemGray2,backgroundColor:.systemBackground, font: UIFont(name:"Arial", size:14)!, translatesMaskInConstraints: false)
    var legendWidthAnchor:[NSLayoutConstraint]!
    var commentTopConstraint3:[NSLayoutConstraint]!
    var postLifeTimeLabel = UILabel(textColor: .systemGray2, font: UIFont(name:"HelveticaNeue-Medium", size:13)!, translatesMaskInConstraints: false)
    var postLifeTimeTopConstraint4:[NSLayoutConstraint]!
  
override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileContainerView)
        profileContainerView.backgroundColor = .systemBackground
        profileContainerView.addSubview(profileImage)
        profileContainerView.addSubview(username)
        profileContainerView.addSubview(optionButton)
        profileImage.frame = CGRect(x:13, y: (profileContainerView.height/2)-20, width: 40, height: 40)
        profileImage.layer.cornerRadius = 20
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleToFill
        username.centerYAnchor.constraint(equalTo:profileContainerView.centerYAnchor).isActive = true
        username.leftAnchor.constraint(equalTo:profileImage.rightAnchor, constant: 10).isActive = true
        username.widthAnchor.constraint(lessThanOrEqualToConstant:screenWidth).isActive = true
        optionButton.setImage(UIImage(named:"option"), for:.normal)
        optionButton.rightAnchor.constraint(equalTo:profileContainerView.rightAnchor, constant:-15).isActive = true
        optionButton.centerYAnchor.constraint(equalTo:profileContainerView.centerYAnchor).isActive = true
        optionButton.widthAnchor.constraint(equalToConstant:24).isActive = true
        optionButton.heightAnchor.constraint(equalToConstant:24).isActive = true
        //optionButton.backgroundColor = .red
        contentView.addSubview(postImage1)
        contentView.addSubview(reactionContainerView)

        reactionContainerView.backgroundColor = .systemBackground
        // add icons
        reactionContainerView.addSubview(likeButton)
        reactionContainerView.addSubview(commentButton)
        reactionContainerView.addSubview(shareButton)
        reactionContainerView.addSubview(savePostButton)
        reactionContainerView.addSubview(noLikesLabel)
        reactionContainerView.addSubview(legend)
        reactionContainerView.addSubview(moreButton)
        reactionContainerView.addSubview(viewCommentButton)
        reactionContainerView.addSubview(postLifeTimeLabel)
        // width and height of icons( like, comment,share, save)
        let buttonWidthHeight = screenWidth*(25/390)
        // set icons frame
        likeButton.frame = CGRect(x:13, y: 11, width: buttonWidthHeight, height:buttonWidthHeight)
        commentButton.frame = CGRect(x: likeButton.right+17, y: 11, width: buttonWidthHeight, height: buttonWidthHeight)
        shareButton.frame = CGRect(x:commentButton.right+17, y: 11, width:buttonWidthHeight, height: buttonWidthHeight)
        // save button must be 10 pixels before screen leftAnchor
        savePostButton.frame = CGRect(x:screenWidth-buttonWidthHeight-10, y: 11, width: buttonWidthHeight, height: buttonWidthHeight)
        // set icons image and target
        likeButton.setImage(UIImage(named:"heart"), for: .normal)
        //likeButton.addTarget(self, action: #selector(likeButtonTouched), for: .touchUpInside)
        commentButton.setImage(UIImage(named: "comment"), for: .normal)
        shareButton.setImage(UIImage(named:"share"), for: .normal)
        savePostButton.setImage(UIImage(named:"save"), for: .normal)
        savePostButton.addTarget(self, action:#selector(savePostButtonTouched), for: .touchUpInside)
        // set noLikesLabel constraint
        noLikesLabel.widthAnchor.constraint(lessThanOrEqualTo: reactionContainerView.widthAnchor).isActive = true
        noLikesLabel.leftAnchor.constraint(equalTo:reactionContainerView.leftAnchor, constant: 13).isActive = true
        noLikesLabel.topAnchor.constraint(equalTo:likeButton.bottomAnchor, constant:screenWidth*(14/390)).isActive = true
        // set legends constraint
     
        legend.leftAnchor.constraint(equalTo:reactionContainerView.leftAnchor, constant: 13).isActive = true
        // set moreButton constraints
        moreButton.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor).isActive = true
        moreButton.heightAnchor.constraint(equalToConstant:screenWidth*(20/390)).isActive = true
        moreButton.leftAnchor.constraint(equalTo:legend.rightAnchor, constant: 5).isActive = true
        moreButton.centerYAnchor.constraint(equalTo:legend.centerYAnchor).isActive = true
        // set viewCommentButton constraint
        viewCommentButton.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor).isActive = true
        viewCommentButton.heightAnchor.constraint(equalToConstant:screenWidth*(20/390)).isActive = true
        viewCommentButton.leftAnchor.constraint(equalTo:reactionContainerView.leftAnchor, constant: 13).isActive = true
        //
        postLifeTimeLabel.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor).isActive = true
        postLifeTimeLabel.leftAnchor.constraint(equalTo:reactionContainerView.leftAnchor,constant: 13).isActive = true
        
        // set legends 2 widthAnchor constraint
        // first case (legendWidthAnchor[0]) is normal case (when moreButton is not hidden), secondCase (legendWidthAnchor[0]) is when moreButton is Hidden
        legendWidthAnchor = [legend.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor, constant:-60),legend.widthAnchor.constraint(lessThanOrEqualTo:reactionContainerView.widthAnchor, constant:-20)]
        // set defaultCase to true
 
        // create 2 differents constraints for the top
        // case where post has more than 0 like
        topConstraint1 = [legend.topAnchor.constraint(equalTo: noLikesLabel.bottomAnchor, constant:screenWidth*(8/390))]
        // case where post has 0 like
        topConstraint2 = [legend.topAnchor.constraint(equalTo:likeButton.bottomAnchor, constant:screenWidth*(8/390))]
        // constraints of viewallcomments
        // we have several constraints. first one is normal one , second one is when no legend and third one is when there is no likes
        commentTopConstraint3 = [viewCommentButton.topAnchor.constraint(equalTo:legend.bottomAnchor, constant: screenHeight*(10/844)),viewCommentButton.topAnchor.constraint(equalTo: noLikesLabel.bottomAnchor, constant: screenHeight*(10/844)),viewCommentButton.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: screenHeight*(10/844))]
        // constraints of postLifeTime
        // we have several constraints. first one is normal one , second one is when no comment, third one is when there is no legend, and fourth one is when no likes
        postLifeTimeTopConstraint4 = [postLifeTimeLabel.topAnchor.constraint(equalTo:viewCommentButton.bottomAnchor, constant: screenWidth*(8/390)),postLifeTimeLabel.topAnchor.constraint(equalTo:legend.bottomAnchor, constant: screenWidth*(8/390)),postLifeTimeLabel.topAnchor.constraint(equalTo: noLikesLabel.bottomAnchor, constant: screenWidth*(8/390)), postLifeTimeLabel.topAnchor.constraint(equalTo: likeButton.bottomAnchor, constant: screenWidth*(8/390))]
    }
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
                return attributedText
            }
            return NSMutableAttributedString(string:"")
        }()
        return legendText
    }
    
    func updateNoLikes(post:InstagramPost){
        // set "like(s)" text
        let likeText = (post.numberOfLikes > 1) ? "likes":"like"
        // hide no_likes label if there is no likes
        noLikesLabel.isHidden = ( post.numberOfLikes == 0)
        // ok, it's not good because if we have 3054, it will display 3.1K. this is not good for a social media but eh
        noLikesLabel.text = post.numberOfLikes.roundedWithAbbreviations + " " + likeText
        // if numberOflikes == 0, deactivatetopConstraint1 and if numberOflikes > 0, deactivate normal top constraint
        noLikesLabel.isHidden ? NSLayoutConstraint.deactivate(topConstraint1): NSLayoutConstraint.deactivate(topConstraint2)
        // if numberOflikes == 0, activatetopConstraint2 and if numberOflikes > 0, activate normal top constraint
        noLikesLabel.isHidden ? NSLayoutConstraint.activate(topConstraint2): NSLayoutConstraint.activate(topConstraint1)
    }
    
    /// changes to set when more button is touched
    func moreButtonTouchedChanges(){
        legendWidthAnchor[0].isActive = false; legendWidthAnchor[1].isActive = true
        // 
        legend.numberOfLines = 0
        moreButton.isHidden = true
    }
 
    // function to configure cell
    // later on mettre ca en inout pour faire passer par reference et modifier le nomber de likes more easily
    func configure(post:InstagramPost){
        
        // use ratio of current post
        let (aRatio,bRatio) = post.mediaRatio
        // use ratio to find corresponding Height
        let imageHeight = ((screenWidth-10)*CGFloat(bRatio))/CGFloat(aRatio)
        
        // set constraint for when moreButton hasn't been touched
        legendWidthAnchor[1].isActive = false; legendWidthAnchor[0].isActive = true
        // you set 1 line to truncate the text; in case it's long
        legend.numberOfLines = 1
        
        // set frame of postImage1 with new found height
        postImage1.frame = CGRect(x: 0, y: profileContainerView.bottom, width:screenWidth, height:imageHeight)
        // set images of post and user
        postImage1.image = post.postImage; profileImage.image = post.author.profilePicture
        // set username
        username.text = post.author.username
       // reactionContainerView.frame = CGRect(x: 0, y: postImage1.bottom, width: screenWidth, height: screenHeight*(141/844))
        reactionContainerView.widthAnchor.constraint(equalToConstant:screenWidth).isActive = true
        reactionContainerView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor).isActive = true
        reactionContainerView.topAnchor.constraint(equalTo:postImage1.bottomAnchor).isActive = true
        reactionContainerView.leftAnchor.constraint(equalTo:contentView.leftAnchor).isActive = true
        // when likeButton hasn't been touched
        likeButton.setImage(UIImage(named:"heart"), for: .normal)
       
        updateNoLikes(post: post)
        // make attributed legend text
        let legendText = makeLegendText(post:post)
        
        // set legend attributedText
        legend.attributedText = legendText
        // get estimated size of legendAttributedSize and then compare it to our parameters
        // -60 is legend.widthAnchor.constraint(lessThanOrEqualTo: constant: ) and 13 is legend.leftAnchor.constraint(equalTo:constant:)

        // The size estimation is given on one line, so it's pretty convenient
        let legendIsTruncated = (legend.attributedText!.size().width > screenWidth-60-13) ? true:false
        legend.isHidden = post.legendPost.isEmpty
        // moreButton is hidden if legend is empty or legend isn't truncated
        moreButton.isHidden = post.legendPost.isEmpty || !legendIsTruncated
       
        // hide view comments if there is no comment
        viewCommentButton.isHidden = ( post.comments.count < 1)
        // set title for view comments button
        let viewCommentBttTitle = (post.comments.count == 1) ? "View 1 comment": "View all \(post.comments.count) comments"
        viewCommentButton.setTitle(viewCommentBttTitle, for: .normal)
              
        if (!legend.isHidden){
            // if legend isn't hidden, activate constraint for legend, first constraint
            for i in stride(from: 2, to: 0, by: -1) { commentTopConstraint3[i].isActive = false } //[2],[1]
            commentTopConstraint3[0].isActive = true
        } else if (!noLikesLabel.isHidden){
            // if number of likes isn't hidden, activate constraint for noLikes, second constraint
            for i in 0...2 where i != 1 { commentTopConstraint3[i].isActive = false } // [0],[2]
            commentTopConstraint3[1].isActive = true
        } else{
            // else if noLikes and legend are hidden, activate last constraint
            for i in 0...1 {commentTopConstraint3[i].isActive = false} // [0],[1]
            commentTopConstraint3[2].isActive = true
        }
       
        if (!viewCommentButton.isHidden){
            // if viewCommentButton isn't hidden, activate first Constraint
            for i in stride(from: 3, to: 0, by: -1) { postLifeTimeTopConstraint4[i].isActive = false } // [3],[2],[1]
            postLifeTimeTopConstraint4[0].isActive = true
        } else if (!legend.isHidden){
            // if legend isn't hidden, activate constraint for legend, second constraint
            for i in stride(from: 3, to: -1, by: -1) where i != 1 { postLifeTimeTopConstraint4[i].isActive = false }
            // postLifeTimeTopConstraint4[3],2,0 = false
            postLifeTimeTopConstraint4[1].isActive = true
        } else if (!noLikesLabel.isHidden){
            // if number of likes isn't hidden, activate constraint for noLikes, third constraint
            for i in stride(from: 3, to: -1, by: -1) where i != 2 { postLifeTimeTopConstraint4[i].isActive = false }
            // postLifeTimeTopConstraint4[3],1,0 = false
            postLifeTimeTopConstraint4[2].isActive = true
        } else{
            // else if noLikes and legend are hidden, activate last constraint
            for i in stride(from: 2, to: -1, by: -1) { postLifeTimeTopConstraint4[i].isActive = false } // [2],[1],[0]
            postLifeTimeTopConstraint4[3].isActive = true
        }
        postLifeTimeLabel.text = postTimeDifference(from:post.creationDate, to: Date(), post: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    @objc func savePostButtonTouched(sender: UIButton){
        // set button image; if current button image is save, set to save_filled and vice versa
        let buttonImage = (savePostButton.currentImage == UIImage(named: "save")) ? UIImage(named:"save_filled"):UIImage(named:"save")
        // set Image to button
        savePostButton.setImage(buttonImage, for: .normal)
        if (savePostButton.currentImage == UIImage(named:"save_filled")){
            // show animation only when user saves , not when he/she unsaves
            sender.showAnimation {}
        }
    }
    
}
