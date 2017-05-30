//
//  ViewController.swift
//  PickingImages
//
//  userInfo in notifications has values or objexts related to a particular notification
//  Created by Pinak Jalan on 5/24/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet var picture:UIImageView!
    @IBOutlet var cameraButton:UIBarButtonItem!
    @IBOutlet var topText: UITextField!
    @IBOutlet var bottomText:UITextField!
    @IBOutlet var shareButton:UIBarButtonItem!
    @IBOutlet var topToolbar:UIToolbar!
    @IBOutlet var bottomToolbar:UIToolbar!
    @IBOutlet var cancelButton:UIBarButtonItem!
    
    var meme:Meme!
    var imageView:UIImageView!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2.0]
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        checkView()
    }

    func checkView()
    {
        picture.autoresizingMask = [.flexibleTopMargin, .flexibleHeight, .flexibleRightMargin, .flexibleLeftMargin, .flexibleWidth]

        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft {
            picture.contentMode = UIViewContentMode.scaleAspectFit
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight {
            picture.contentMode = UIViewContentMode.scaleAspectFit
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portrait {
            picture.contentMode = UIViewContentMode.scaleAspectFill
            
            
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.portraitUpsideDown {
            picture.contentMode = UIViewContentMode.scaleAspectFill
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.topText.delegate = self
        self.bottomText.delegate = self
        
        configure(textField: topText, withText: "TOP")
        configure(textField: bottomText, withText: "BOTTOM")
        checkView()
        if !(meme == nil)
        {
            //print("User wants to edit. Pls dont be a dick")
            editsavedMeme(savedMeme: meme)
        }
        
    }
    
    func editsavedMeme(savedMeme:Meme)
    {
       
        topText.text = savedMeme.topText
        bottomText.text = savedMeme.bottomText
        let image = savedMeme.ogPicture
        picture.image = image

    }
    
    func configure (textField: UITextField, withText: String)
    {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        
        if(withText == "TOP")
        {
            textField.text = "TOP"
        }
            
        else
        {
            textField.text = "BOTTOM"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        if picture.image == nil
        {
            shareButton.isEnabled = false
        }
        else
        {
            shareButton.isEnabled = true

        }
        checkView()
        self.navigationController?.navigationBar.isHidden = true
        topText.autocorrectionType = .no
        bottomText.autocorrectionType = .no
        self.showkeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.unshowkeyboardNotifications()
    }
    
    
    @IBAction func pickImage()
    {
        configuresourceType(sourceType: .photoLibrary)

    }
    
    @IBAction func pickImagefromCamera()
    {
        configuresourceType(sourceType: .camera)
    }
    
    func configuresourceType(sourceType:UIImagePickerControllerSourceType)
    {
        let vc = UIImagePickerController()
        vc.sourceType = sourceType
        vc.delegate = self
        present(vc, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            picture.image = image
            print("Image was picked")
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("Image was not picked")
        dismiss(animated: true, completion: nil)


    }
    
     func textFieldDidBeginEditing(_ textField: UITextField)
    {
        textField.text = ""
    }
    
    //Dont make it private, Swift is fooling you ;)
    func textFieldShouldReturn(_ textField: UITextField)
    {
        //You can also use identifiers to identify a particular textfield
        if textField.text == "" && textField.tag == 1
        {
            textField.text = "TOP"
        }
        else if textField.text == "" && textField.tag == 2
        {
            textField.text = "BOTTOM"
        }
        textField.resignFirstResponder()

    }
    
    func keyboardWillShow(_ notification:Notification)
    {
        if bottomText.isFirstResponder
        {
            view.frame.origin.y  -= getkeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification:Notification)
    {
        if bottomText.isFirstResponder
        {
            view.frame.origin.y  += getkeyboardHeight(notification)
        }
    }
    
    func getkeyboardHeight(_ notification:Notification) -> CGFloat
    {
        let userInfo = notification.userInfo!
        let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardHeight.cgRectValue.height
    }
    
    func showkeyboardNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    
    }

    func unshowkeyboardNotifications()
    {
        
        NotificationCenter.default.removeObserver(self,name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)

    }
    
    func save()
    {
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, ogPicture: picture.image!, memedPicture: generateMemedImage())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    func generateMemedImage() -> UIImage {
        
        //Hide tool and nav bar
        toggleBar(toolBar: bottomToolbar,bool: true)
        toggleBar(toolBar: topToolbar,bool: true)
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        
        //Show nav and tool bar again
        toggleBar(toolBar: bottomToolbar,bool: false)
        toggleBar(toolBar: topToolbar,bool: false)
        
        return memedImage
         }
    
    func toggleBar(toolBar: UIToolbar,bool: Bool)
    {
        toolBar.isHidden = bool
    }
    @IBAction func showactivityView()
    {
        let image:UIImage
        image = generateMemedImage()
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        
        vc.completionWithItemsHandler =
            {
                activity, completed,items,error in
                
                if completed
                {
                    self.save()
                   // self.navigationController?.popToRootViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)

                }
        }
        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func cancelPressed()
    {
        picture.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        shareButton.isEnabled = false
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

