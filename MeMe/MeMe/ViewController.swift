//
//  ViewController.swift
//  MeMe
//
//  Created by محمد عايض العتيبي on ٢٦ جما٢، ١٤٣٨ هـ.
//  Copyright © ١٤٣٨ code schoole. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate, UITextFieldDelegate{
    @IBOutlet weak var abovetoolbar: UIToolbar!
    @IBOutlet weak var Sharebutton: UIBarButtonItem!
    @IBOutlet weak var Cancel: UIBarButtonItem!

    @IBOutlet weak var camerabutton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var picker: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    
    let MemeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3
        
        
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        toptextfield.delegate = self
        buttomtextfield.delegate = self
        
        styleTextfield(_textfield: toptextfield)
        styleTextfield(_textfield: buttomtextfield)
        toptextfield.textAlignment = .center
        buttomtextfield.textAlignment = .center
    //    imagePickerView.contentMode = UIViewContentMode.scaleAspectFit
       
        
       
    }
    func styleTextfield(_textfield: UITextField){
      toptextfield.text = "Top"
      buttomtextfield.text = "Bottom"
      toptextfield.textAlignment = NSTextAlignment.center
    buttomtextfield.textAlignment = .center
        toptextfield.defaultTextAttributes = MemeTextAttributes
        buttomtextfield.defaultTextAttributes = MemeTextAttributes
        
        
        
    
    }

    @IBOutlet weak var toptextfield: UITextField!
    @IBOutlet weak var buttomtextfield: UITextField!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        toptextfield.resignFirstResponder()
        buttomtextfield.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Top" || textField.text == "Bottom"{
          textField.text = ""
        }
    }
    
    func presentimagePickerwith (sourcetype: UIImagePickerControllerSourceType){
    let ImagePicker = UIImagePickerController()
        ImagePicker.sourceType = sourcetype
        ImagePicker.delegate = self
        self.present(ImagePicker, animated: true, completion: nil)
    
    }
    
    @IBAction func pickAnImage(_ sender: Any) {
    
        presentimagePickerwith(sourcetype: .photoLibrary)
        
            }
    @IBAction func pickanimageFromcamera(_ sender: Any) {
        
        presentimagePickerwith(sourcetype: .camera)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let Image =  info[UIImagePickerControllerOriginalImage] as? UIImage{
        imagePickerView.image = Image
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
       Sharebutton?.isEnabled = (imagePickerView.image != nil)
   
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        camerabutton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification:Notification) {
        
        if buttomtextfield.isFirstResponder{
        
        view.frame.origin.y =    -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        
        //Reset keyboard value
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func save(){
        
     let meme = Meme(topText: toptextfield.text!, bottomText: buttomtextfield.text!, originalImage: imagePickerView.image!, memedImage:generateMemedImage())
        let object = UIApplication.shared.delegate
        let appdelgeate = object as! AppDelegate
        appdelgeate.memes.append(meme)
    
    }
    func generateMemedImage() -> UIImage {
        
        toolbar.isHidden = true
        abovetoolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbar.isHidden = false
        abovetoolbar.isHidden = false
        return memedImage
    }
    @IBAction func sharedbutton(_ sender: Any) {
        
        let meme = generateMemedImage()
        let ActivatyVC = UIActivityViewController(activityItems: [meme], applicationActivities: nil)
        
        ActivatyVC.completionWithItemsHandler = {activity, completed, items, error in
            
            if (completed){
                
                self.save()
                self.dismiss(animated: true, completion: nil)
                
            }
        }
        
        self.present(ActivatyVC, animated: true, completion: nil)
        
    }
    
    @IBAction func cancel(_ sender: Any) {
    
        self.imagePickerView.image = nil
        self.toptextfield.text = "Top"
        self.buttomtextfield.text = "Bottom"
        Sharebutton.isEnabled = false
        

        
    }
}

