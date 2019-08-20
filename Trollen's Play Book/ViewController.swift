//
//  ViewController.swift
//  Trollen's Play Book
//
//  Created by Varunraj on 8/19/19.
//  Copyright © 2019 Varunraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    let imagePickerController = UIImagePickerController()

    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var memeOriginalImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        imagePickerController.delegate = self
        topTextfield.backgroundColor = .clear
        topTextfield.borderStyle = .none
        bottomTextfield.backgroundColor = .clear
        bottomTextfield.borderStyle = .none
        actionButton.isEnabled = false
        cancelButton.isEnabled = false
        // Do any additional setup after loading the view.
        //MARK: when presses outside the textfield
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
      
        //MARK: adding observer to find the events
        
        
        
    }

    
    //MARK: when presses camera button
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
        
        present(imagePickerController, animated: true, completion: nil)
        }
    
    
    
    
    
    //MARK: when presses album buttons
    @IBAction func photoLibraryClicked(_ sender: Any) {
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
        
        
        
    }
    
    //MARK: image picker delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        memeOriginalImage.image = image
        dismiss(animated: true, completion: nil)
        
        topTextfield.isHidden = false
        bottomTextfield.isHidden = false
        
    }
    
    
    //MARK: tap objective c methods
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    
    }
    
    
    
    //textfield methods
  
    
  


}

