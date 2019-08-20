//
//  ViewController.swift
//  Trollen's Play Book
//
//  Created by Varunraj on 8/19/19.
//  Copyright © 2019 Varunraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    let imagePickerController = UIImagePickerController()

    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var memeOriginalImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        
        topTextfield.isHidden = true
        bottomTextfield.isHidden = true
 
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func photoLibraryClicked(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        memeOriginalImage.image = image
        dismiss(animated: true, completion: nil)
        
        topTextfield.isHidden = false
        bottomTextfield.isHidden = false
        
    }
    
    

}

