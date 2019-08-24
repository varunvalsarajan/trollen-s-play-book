//
//  ViewController.swift
//  Trollen's Play Book
//
//  Created by Varunraj on 8/19/19.
//  Copyright © 2019 Varunraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    //var memes  = [Meme]()
    let imagePickerController = UIImagePickerController()
    let defaults = UserDefaults.standard

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
        topTextfield.delegate = self
        bottomTextfield.delegate = self
      
        
        //MARK: when presses outside the textfield
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
      
        
        
        
    }
    
    //MARK: text field delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField.tag == 1){
            unsubscribeToKeyboardNotifications()
            view.frame.origin.y = 0
        }else{
            subscribeToKeyboardNotifications()
        }
    }
    
    
    func subscribeToKeyboardNotifications(){
     
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    func unsubscribeToKeyboardNotifications(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification){
        
      view.frame.origin.y = view.frame.origin.y - getKeyboardHeight(notification: notification)
        
    }
    
    func getKeyboardHeight(notification: Notification)-> CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as!NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    func keyboardWillHide(){
     view.frame.origin.y = 0
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
        topTextfield.isHidden = false
        bottomTextfield.isHidden = false
        actionButton.isEnabled = true
        
        
        self.dismiss(animated: true, completion: nil)
        
    
        
    }
    
    
    //MARK: tap objective c methods
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
        view.frame.origin.y = 0
    
    }
    
    func generateMemedImage() -> UIImage {
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    
    
    
    
    @IBAction func saveMeme(_ sender: UIBarButtonItem) {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        let ourMeme = Meme()
        ourMeme.topText = topTextfield.text!
        ourMeme.bottomText = bottomTextfield.text!
        ourMeme.originalImage = memeOriginalImage.image!
        ourMeme.memedImage = self.generateMemedImage()
        appDelegate.memes.append(ourMeme)
        let activityController = UIActivityViewController(activityItems: [ourMeme.memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems:[Any]?, error: Error?) in
            
            if(activityType == UIActivity.ActivityType.saveToCameraRoll){
              self.performSegue(withIdentifier: "wayToTab", sender: self)
            }
            //Do whatever you want
        }
            
        
     

        present(activityController, animated: true)
        
       
        
    }
    //textfield methods
  
    
  
}


