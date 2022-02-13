//
//  CommentsTableViewCell.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 26/01/2022.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    static let identifier = "CommentsTableViewCell"
    var profilePictureView:UIImageView = UIImageView(frame: CGRect(x: CommentsViewController().profilePictureLeftConstant, y: 14, width: 40, height: 40), backgroundColor:.red)
    var commentLabel:UILabel = UILabel(textColor: .black, font: UIFont(name:"HelveticaNeue-Light", size: 12)!, textAlignment:.left , no_lines: 0, translatesMaskInConstraints: false)
    var postLifeTimeLabel = UILabel(textColor: .systemGray2, font: UIFont(name:"HelveticaNeue-Medium", size:13)!, translatesMaskInConstraints: false)
    let replyButton:UIButton = UIButton(title:"Reply", titleColor: .systemGray, font: UIFont(name:"HelveticaNeue-Medium", size: 12)!, translatesMaskInConstraints: false)
    var likeButton = UIButton(translatesMaskInConstraints: false)
    var noLikesLabel:UILabel = UILabel( textColor: .systemGray, font: UIFont(name:"HelveticaNeue-Medium", size:12 )!, textAlignment:.left,translatesMaskInConstraints: false)
    var topConstraint1:[NSLayoutConstraint]!, topConstraint2:[NSLayoutConstraint]!

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
        
        contentView.addSubview(profilePictureView)
        contentView.addSubview(commentLabel)
        contentView.addSubview(noLikesLabel)
        contentView.addSubview(postLifeTimeLabel)
        contentView.addSubview(replyButton)
        contentView.addSubview(likeButton)
        noLikesLabel.text = ""
        replyButton.backgroundColor = contentView.backgroundColor
        likeButton.backgroundColor = contentView.backgroundColor
        
        
        // round profilePicture
        profilePictureView.layer.cornerRadius = 20
        profilePictureView.layer.masksToBounds = false
        profilePictureView.clipsToBounds = true
        profilePictureView.contentMode = .scaleToFill
        
        // set legend constraint
        commentLabel.topAnchor.constraint(equalTo:contentView.topAnchor, constant: CommentsViewController().legendLeftTopConstant).isActive = true
        commentLabel.leftAnchor.constraint(equalTo:profilePictureView.rightAnchor, constant: CommentsViewController().legendLeftTopConstant).isActive = true
        // 10 (profilePicture.x) + 40(profilePicture.width) + 14 (legendleftAnchor) +25(10 of button + 15 width) +20(rightAnchor)(ecart de 20 with likeButton)
        // 109
        commentLabel.widthAnchor.constraint(lessThanOrEqualTo:contentView.widthAnchor,constant: -110).isActive = true
       // legend.attributedText = makeLegendText(post: post
        
        //likeButton.centerYAnchor.constraint(equalTo:comment.centerYAnchor, constant:-5).isActive = true
        likeButton.topAnchor.constraint(equalTo:commentLabel.topAnchor,constant: 10).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant:15).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant:15).isActive = true
        likeButton.rightAnchor.constraint(equalTo:contentView.rightAnchor, constant: -10).isActive = true
   //     likeButton.backgroundColor = .green
        
        // set postLifeTimeLabel constraint
        postLifeTimeLabel.topAnchor.constraint(equalTo:commentLabel.bottomAnchor, constant: 10).isActive = true
        postLifeTimeLabel.leftAnchor.constraint(equalTo:commentLabel.leftAnchor).isActive = true
        postLifeTimeLabel.widthAnchor.constraint(lessThanOrEqualTo:contentView.widthAnchor).isActive = true
      //  postLifeTimeLabel.backgroundColor = .red
        // set text
      //  postLifeTimeLabel.text = postTimeDifference(from:post.creationDate, to: Date(), post: false)
        // set noLikesLabel constraint
        // this 10 is irrelevant
        noLikesLabel.widthAnchor.constraint(lessThanOrEqualTo:contentView.widthAnchor,constant: 10).isActive = true
        noLikesLabel.leftAnchor.constraint(equalTo: postLifeTimeLabel.rightAnchor, constant: 14).isActive = true
        noLikesLabel.centerYAnchor.constraint(equalTo: postLifeTimeLabel.centerYAnchor).isActive = true
        //noLikesLabel.backgroundColor = .blue
        
        replyButton.widthAnchor.constraint(lessThanOrEqualTo:contentView.widthAnchor).isActive = true
        replyButton.heightAnchor.constraint(lessThanOrEqualToConstant: 15).isActive = true
       //replyButton.backgroundColor = .orange
        
        //replyButton.backgroundColor = .red
        // case where post has more than 0 like
        topConstraint1 = [replyButton.leftAnchor.constraint(equalTo: noLikesLabel.rightAnchor,constant: 14),replyButton.centerYAnchor.constraint(equalTo:noLikesLabel.centerYAnchor)]
        // case where post has 0 like
        topConstraint2 = [replyButton.leftAnchor.constraint(equalTo: postLifeTimeLabel.rightAnchor,constant: 14),replyButton.centerYAnchor.constraint(equalTo:postLifeTimeLabel.centerYAnchor)]

    }
    
    func updateNoLikes(comment:InstagramComment){
        // set "like(s)" text
        let likeText = (comment.no_likes > 1) ? "likes":"like"
        // hide no_likes label if there is no likes
        noLikesLabel.isHidden = ( comment.no_likes == 0)
        // ok, it's not good because if we have 3054, it will display 3.1K. this is not good for a social media but eh
        noLikesLabel.text = comment.no_likes.roundedWithAbbreviations + " " + likeText
        let replaced = (!noLikesLabel.text!.isEmpty) ? noLikesLabel.text!.replacingOccurrences(of:"K", with:"k"):nil
        let replaced2 = (!noLikesLabel.text!.isEmpty) ? replaced!.replacingOccurrences(of:"M", with:"m"):nil
        noLikesLabel.text = replaced2
       
        // if numberOflikes == 0, deactivatetopConstraint1 and if numberOflikes > 0, deactivate normal top constraint
        noLikesLabel.isHidden ? NSLayoutConstraint.deactivate(topConstraint1): NSLayoutConstraint.deactivate(topConstraint2)
        // if numberOflikes == 0, activatetopConstraint2 and if numberOflikes > 0, activate normal top constraint
        noLikesLabel.isHidden ? NSLayoutConstraint.activate(topConstraint2): NSLayoutConstraint.activate(topConstraint1)
    }
    
    func makeLegendText(post:InstagramPost, comment:InstagramComment) -> NSMutableAttributedString{
       let legendText:NSMutableAttributedString = {
       let string = post.author.username! + " " + comment.comment
       // find index of space (" ") such that we could set username font to bold (username is separated from legend by the first space).
       let spaceIndex = string.index(of:" ")
       let attributedText = NSMutableAttributedString(string: string)
       // change username part color to black
       attributedText.addAttribute(.foregroundColor, value:UIColor.black, range: NSRange(location:0, length: spaceIndex!))
       // change "Username" to bold part font to bold
       attributedText.addAttribute(.font, value: UIFont(name: "HelveticaNeue-Medium", size: 14)!, range: NSRange(location: 0, length:spaceIndex!))
       // change rest to normal font, we need to do that (again) to be able to get a good estimation of the size later on
       attributedText.addAttribute(.font, value: UIFont(name:"HelveticaNeue-Light", size:12)!, range: NSRange(location:spaceIndex!+1, length:attributedText.length-(spaceIndex!+1)))
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

       //  *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2.5 // Whatever line spacing you want in points
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        // *** Apply attribute to string ***
        attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedText.length))
           return attributedText
           }()
           return legendText
   }
    
    func configure(comment:InstagramComment,post:InstagramPost){
        commentLabel.attributedText = makeLegendText(post: post, comment:comment)
        postLifeTimeLabel.text = postTimeDifference(from:comment.date, to: Date(), post: false)
        likeButton.setImage(UIImage(named:"heart_gray"), for: .normal)
        profilePictureView.image = comment.profilePicture
        

        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
