//
//  RandomViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 20/01/2022.
//

import UIKit

class RandomViewController: UIViewController {
    let theImage = UIImageView(translatesMaskInConstraints: false)
    let (aRatio,bRatio) = InstagramPost.customMediaRatio(1080,720)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        theImage.image = UIImage(named: "12")
        theImage.contentMode = .scaleToFill
        view.addSubview(theImage)
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        theImage.center.x = view.center.x
        theImage.center.y = view.center.y
        // calculate height en fonction du ratio et de la default width
        let height = ((screenWidth-10)*CGFloat(bRatio))/CGFloat(aRatio)
        theImage.widthAnchor.constraint(equalToConstant:screenWidth).isActive = true
        theImage.heightAnchor.constraint(equalToConstant:height).isActive = true
        print(theImage.height)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
