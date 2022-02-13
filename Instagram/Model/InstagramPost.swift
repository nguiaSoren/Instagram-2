//
//  Instagram.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 06/01/2022.
//

import Foundation
import UIKit


public class InstagramPost {
    /* maintenant si le frangin touche le username, on push simplement un profileViewController
    avec les informations de l'author du post qu'on aura retrieved dans la database grace à authorSafeEmail*/
    var id:Int
    var author:InstagramUser
    var postMediaUrl:URL?
    // such that I could make custom cell  size later,
    // like cell.height = section_with_name.height+mediaSize.height+ custom_size_legends.height
    // voir dans quelle mesure je peux augmenter la taille de la celle pour afficher tout le texte quand le user
    // va toucher more
    // le custom_size_legend a une taille de base qu'on va expend quand c'est touché. on va juste ajouter la height du text
    // peut etre fouiller un truc pour bien modifier la size des images des gens
    // this is the media original size, when the user want to download the media of a post (if he find a way to do it ), we will either give him the original that we would have stored in the database or the one displayed on his screen but with the real size (media size)
    var mediaSize:CGSize?
    // we need a media ratio to know how to display the image according to the screen. For example if the image is 1080*1080 (1:1) and the screen is iphone 12 (390*844), we know that this iphone can't have 1080 in widht or(and) height, so we are gonna modify the image while keeping the aspect ratio; On iphone 12, it will be from 1080*1080(1:1) --> 390*390(1:1), we kept the image ratio and we modified it such that it could be displayed on our phone screen. Another example is from 500*750(2:3) --> 390*585(2:3), 3024*4032(3:4) --> 390*520 (3:4)
    // new_width = screenWidth and new_height = (screenWidth*bReduced)/aReduced (pour les posts)
    lazy var mediaRatio: (Int,Int) =  {
        // get width and height and wrap it into tuple
        let size = (width: Int(mediaSize!.width),height: Int(mediaSize!.height))
        // get ratio through reduceQuotient and return it
        return reduceQuotient(size.width,size.height)
    }()
    static var customMediaRatio = {(width: Int,height:Int) -> (Int,Int) in
        // get ratio through reduceQuotient and return it
        return reduceQuotient(width,height)
    }
    var postImage:UIImage
    var creationDate:Date
    var legendPost:String = ""
    var numberOfLikes:Int = 0
    var comments:[InstagramComment]
    var likedBy: [InstagramUser] = [InstagramUser]()
    init(id:Int, author:InstagramUser, postMediaUrl:URL?,
         creationDate:Date,legendPost:String,numberOfLikes:Int,
         comments:[InstagramComment],mediaSize:CGSize?,myImage:UIImage, likedBy:[InstagramUser]){
        // like <<this>> in java
        self.id = id
        self.author = author
        self.postMediaUrl = postMediaUrl
        self.creationDate = creationDate
        self.legendPost = legendPost
        self.numberOfLikes = numberOfLikes
        self.comments = comments
        self.mediaSize = mediaSize
        self.postImage = myImage
        self.likedBy = likedBy
    }
}
extension InstagramPost: Equatable{}

public func ==(firstPost: InstagramPost, secondPost: InstagramPost) -> Bool {
    return (firstPost.id == secondPost.id)
    
}

























/*
print("mann")


var queryUsers = [QueryUser]()


// fbUser = firebaseUser
for fbUser in fb.collection("users"){
    // c'est impossible que birthday soit nil mais c'est pour l'exemple
    // look for the shits and unwrap it
    if let id = fbUser["id"], let fullName = fbUser["fullName"] as! [String:String],let birthday = fbUser["birthday"] ?? nil, let safeEmail = fbUser["safeEmail"],
       let username = fbUser["username"], let profilePictureUrl = fbUser["profilePictureUrl"], let posts = fbUser["posts"], let followers = fbUser["followers"],
       let following = fbUser["following"] {
           // peut etre créer une classe pour query users , cette classe va inherit InstagramUser mais aura une autre property
           // called order qui fait allusion à l'odre d'affichage , PEUT ETRE
           let queryUser = QueryUser(id: id, fullName:fullName, birthday:birthday, safeEmail:safeEmail, password:password,
                                         username:username, profilePictureUrl:profilePictureUrl, posts:posts, followers:followers,
                                         following: following)
    }
    // comme tu knows, le & devant le parametre veut dire que c'est un parametre par reference, donc si on modifie dans la function,
    // ca va modifier le truc en reel. Mettre ca dans class QueryUser as static method
    QueryUser.lookForUser(with: queryUser.username, for: &queryUser) //  if userName is inside, modify the property foundInUsername to true
    QueryUser.lookForUser(with: queryUser.fullName ,for: &queryUser) // //  if name  is inside, modify the property foundInName to true
    if (queryUser.foundInUsername || queryUser.foundInName){
        queryUsers.append(queryUsers)
    }
    
}
QueryUser.filterQueryUsers(queryUsers: &queryUsers)
// then call a the default method to reload the tableView (bien sur, on aura initially bien set the tableView for row etc)
// tableView.isHidden = queryUsers.isEmpty and display a blank page, sauf la searchBar, peut etre qu'on a pas besoin du tableViewHidden thing
// j'ai l'impression que lorsque la tableView n'a pas de data à afficher par default ce sera blank comme je veux


*/


