//
//  AddProfilePhotoViewController.swift
//  Instagram
//
//  Created by OBOUNOU LEKOGO NGUIA Benaja Soren on 10/01/2022.
//

import UIKit

class AddProfilePhotoViewController: UIViewController {
    let addProfilePictureLabel = UILabel(textColor:.black, font: UIFont(name:"HelveticaNeue", size: screenWidth*(25/390))!, text: "Add Profile Photo", translatesMaskInConstraints: false)
    let infoAddProfilePicture = UILabel(textColor:.lightGray, font: UIFont(name: "HelveticaNeue", size: screenWidth*(14/390))!,text:"Add a profile photo so your friends know it's you", textAlignment: .center, translatesMaskInConstraints: false)
    let profilePicturePlaceholder:UIImageView = UIImageView(image: UIImage(named: "addPhoto"))
    var profilePicture:UIImageView = UIImageView(image: UIImage(named:"user"))
    let addPhotoButton = NextButton()
    let skipButton:UIButton = {
        let the_button = UIButton(title: "Skip", titleColor: .FacebookBlue, translatesMaskInConstraints: false)
        the_button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)!
        return the_button
    }()
    
    var separatorView = UIView(backgroundColor: .lightGray)
    var placeholderHasChanged = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(addProfilePictureLabel)
        view.addSubview(infoAddProfilePicture)
        view.addSubview(profilePicturePlaceholder)
        view.addSubview(skipButton)
        view.addSubview(addPhotoButton)
        view.addSubview(separatorView)
        addPhotoButton.setTitle("Add a photo", for: .normal)
        buttonSwitches(button: addPhotoButton, on: true)
        skipButton.addTarget(self, action: #selector(skipNextButtonTouched), for: .touchUpInside)
        profilePicturePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        addPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        profilePicturePlaceholder.isUserInteractionEnabled = true
        addPhotoButton.addTarget(self, action: #selector(addPhotoButtonTouched), for: .touchUpInside)
        profilePicturePlaceholder.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profilePictureTouched)))
        profilePicturePlaceholder.contentMode = .scaleAspectFill
        separatorView.alpha = 0.3
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // center label
        addProfilePictureLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        // dynamic width
        addProfilePictureLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor).isActive = true
        // y coordinate
        addProfilePictureLabel.topAnchor.constraint(equalTo:view.topAnchor, constant: screenHeight*(70/844)).isActive = true
        
        // center label
        infoAddProfilePicture.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // dynamic width
        infoAddProfilePicture.widthAnchor.constraint(equalTo:view.widthAnchor).isActive = true
        // y coordinate
        infoAddProfilePicture.topAnchor.constraint(equalTo: addProfilePictureLabel.bottomAnchor, constant: 15).isActive = true
        
        profilePicturePlaceholder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profilePicturePlaceholder.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profilePicturePlaceholder.widthAnchor.constraint(equalToConstant: view.height/3.5).isActive = true
        profilePicturePlaceholder.heightAnchor.constraint(equalToConstant: view.height/3.5).isActive = true
        
        profilePicturePlaceholder.clipsToBounds = true
        
        // build frame from bottom
        skipButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // 20 units of space between bottom and skip button
        skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -screenWidth*(40/390)).isActive = true
        skipButton.widthAnchor.constraint(lessThanOrEqualTo:view.widthAnchor).isActive = true
        
        addPhotoButton.frame = CGRect(x: 20, y: skipButton.top-50, width: screenWidth*(350/390), height: 45)
        
        // 25 units of space between sign in and separatorView
        separatorView.frame = CGRect(x:0, y: addPhotoButton.top-16, width: screenWidth, height: 1)
    }
    
    @objc func profilePictureTouched(_ sender:UITapGestureRecognizer){
        presentAlert()
    }
    
    @objc func addPhotoButtonTouched(){
        presentAlert()
    }
    @objc func skipNextButtonTouched(_ sender: UIButton){
        profilePicture.image = profilePicturePlaceholder.image
        // use custom transition we made
        customInstagramTransition(isDismiss: false)
        // go to nextView while transfering that image to it
        // animated is false, if not we will have 2 animations
        customPresentVC(UsernameViewController(), animated: false)
    }
    
    func presentAlert(){
        // make alert controller
        let alert = UIAlertController(title: "Add Profile Photo", message: nil, preferredStyle: .actionSheet)
        // make alert Controller action to take picture
        let takePhotoAction = UIAlertAction(title: "Take Picture", style: .default) { [weak self] (action) in
            guard let strongSelf = self else {return}
            // take photo from camera
            strongSelf.photo(sourceType: .camera)
        }
        // make alert Controller action to choose photo from Library
        let choosePhotoAction = UIAlertAction(title: "Choose From Library", style: .default) { [weak self](action) in
            guard let strongSelf = self else {return}
            // choose photo from Library
            strongSelf.photo(sourceType:.photoLibrary)
        }
        // add cancel action
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        // add different UIAlertAction we made
        alert.addAction(takePhotoAction)
        alert.addAction(choosePhotoAction)
        alert.addAction(cancelAction)
        // present alert
        present(alert, animated: true, completion: nil)
    }
        
    func photo(sourceType:UIImagePickerController.SourceType){
        // create picker object
        let picker = UIImagePickerController()
        // choose (set) datatype
        picker.sourceType = sourceType
        // set delegate and allo editing
        picker.delegate  = self; picker.allowsEditing = true
        // present picker Controller
        present(picker, animated: true, completion: nil)
    }

}

extension AddProfilePhotoViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Tells the delegate that the user picked a still image or movie.
        // get image from user
        guard let image = info[.editedImage] as? UIImage else {return}
        // update  placeHolderImage
        DispatchQueue.main.async {
            self.profilePicturePlaceholder.image = image
        }
        // check if placeholder has changed
        if (!placeholderHasChanged){
            // if placeholder didn't change, set it to true
            placeholderHasChanged = true
            // set image corner Radius
            profilePicturePlaceholder.layer.cornerRadius = profilePicturePlaceholder.width/2
            // change Button Title to "Next"
            skipButton.setTitle("Next", for: .normal)
        }
        // dismiss pickerController
        picker.dismiss(animated: true, completion: nil)
    }
}
