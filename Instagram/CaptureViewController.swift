//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Huang Edison on 3/7/17.
//  Copyright © 2017 Edison. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var defaultPhotoLabel: UILabel!
    @IBOutlet weak var captionTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let postImage = resize(image: self.photoImageView.image!, newSize: CGSize(width: 600, height: 600))
        let caption = self.captionTextField.text
        Post.postUserImage(image: postImage, withCaption: caption) { (success: Bool, error: Error?) in
            if success {
                self.tabBarController?.selectedIndex = 0
                //print("I posted to Parse")
            }
            else{
                print(error?.localizedDescription ?? "")
            }
        }
        
        photoImageView.image = nil
        defaultPhotoLabel.isHidden = false
        self.captionTextField.text = "Add a caption..."
        self.captionTextField.textColor = .gray
        
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        //imagePickerController.allowsEditing = true
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Error when picking photo")
        }
        photoImageView.image = image
        
        defaultPhotoLabel.isHidden = true
        self.captionTextField.text = ""
        self.captionTextField.textColor = .black
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        defaultPhotoLabel.isHidden = false
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
