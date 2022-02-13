//
//  InstagramUser.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 10/01/2022.
//

import Foundation
import UIKit

public class InstagramUser {
    var fullName:[String:String]? // fullName = ["firstName": "soren", "lastName": "Obounou nguia"], by default, one of them can be empty
    var birthday:Date?
    var safeEmail:String?
    var password:String?
    var username: String?
    var profilePictureUrl:URL?
    var posts:[InstagramPost]
    var followers: [InstagramUser]
    var following: [InstagramUser]
    var no_followers:Int {
        followers.count
    }
    var bio:String?
    var profilePicture:UIImage
    // constructor
    init(fullName:[String:String]?, birthday:Date?, safeEmail:String?, password:String?,username: String?, profilePictureUrl:URL?,profilePicture:UIImage, posts:[InstagramPost],followers: [InstagramUser] ,following: [InstagramUser], bio: String?){
        self.fullName = fullName
        self.birthday = birthday
        self.safeEmail = safeEmail
        self.password = password
        self.username = username
        self.profilePictureUrl =  profilePictureUrl
        self.posts = posts
        self.followers = followers
        self.following = following
        self.bio = bio
        self.profilePicture = profilePicture
             
        }
}

extension InstagramUser: Equatable{}

public func ==(firstUser: InstagramUser, secondUser: InstagramUser) -> Bool {
    return (firstUser.safeEmail == secondUser.safeEmail)
    
}


