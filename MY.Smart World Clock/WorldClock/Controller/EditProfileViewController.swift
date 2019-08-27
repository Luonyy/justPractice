//
//  EditProfileViewController.swift
//  WorldClock
//
//  Created by arturs.zeipe on 28/06/2019.
//  Copyright © 2019 arturs.zeipe. All rights reserved.
//

import UIKit

protocol SaveUserDataProtocol {
    func saveUserData(name: String?)
}

class EditProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var delegate: SaveUserDataProtocol?
    
    var name: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        imageView.image = getImage()
    }
    
    //MARK: - Choose image from photo library
    @IBAction func chooseImage(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Save button
    @IBAction func saveProfileData(_ sender: Any) {
        let name: String = nameTextField.text!
        if name != ""{
            delegate?.saveUserData(name: name)
        }
        
        let image = imageView.image
        if image != nil{
            if let data = image!.jpegData(compressionQuality: 0.8) {
                let filename = getDocumentsDirectory().appendingPathComponent("userImage.jpg")
                try? data.write(to: filename)
            }
        }
        
        let alertController = UIAlertController(title: "Saved", message:
            "User data saved!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getImage()-> UIImage{
        let fileManager = FileManager.default
        let imageURL = getDocumentsDirectory().appendingPathComponent("userImage.jpg")
        let imageString = imageURL.path
        if fileManager.fileExists(atPath: imageString){
            return UIImage(contentsOfFile: imageString)!
        }else{
            return UIImage.init(named: "defaultUser")!
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
