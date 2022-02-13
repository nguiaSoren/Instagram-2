//
//  ConstraintsConstant.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 29/01/2022.
//

import Foundation
import UIKit

// really good struct to keep track of our constraintConstants, instead of manually modifying them everywhere
class ConstraintsConstant{
    var topAnchorConstant:CGFloat = 0
    var rightAnchorConstant:CGFloat = 0
    var leftAnchorConstant:CGFloat = 0
    var bottomAnchorConstant:CGFloat = 0
    var widthAnchorConstant:CGFloat = 0
    var heightAnchorConstant:CGFloat = 0
    init(topAnchorConstant:CGFloat,rightAnchorConstant:CGFloat, leftAnchorConstant:CGFloat,bottomAnchorConstant:CGFloat,
         widthAnchorConstant:CGFloat,heightAnchorConstant:CGFloat) {
        self.topAnchorConstant = topAnchorConstant
        self.rightAnchorConstant = rightAnchorConstant
        self.leftAnchorConstant = leftAnchorConstant
        self.bottomAnchorConstant = bottomAnchorConstant
        self.widthAnchorConstant = widthAnchorConstant
        self.heightAnchorConstant = heightAnchorConstant
        
    }
}
