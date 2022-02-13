//
//  InstagramComment.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 10/01/2022.
//

import Foundation
import UIKit


class InstagramComment {
    var comment: String
    var authorUsername: String
    var no_likes:Int = 0
    var date:Date
    var profilePicture:UIImage
    
    init(profilePicture:UIImage, comment: String, authorUsername: String, no_likes:Int,date:Date){
        self.profilePicture = profilePicture
        self.comment = comment
        self.authorUsername = authorUsername
        self.no_likes = no_likes
        self.date = date
    }
}
