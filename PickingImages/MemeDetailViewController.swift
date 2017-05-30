//
//  MemeDetailViewController.swift
//  PickingImages
//
//  Created by Pinak Jalan on 5/28/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController,UINavigationControllerDelegate {
    
    
    
    var curMeme:Meme!
    @IBOutlet var picture: UIImageView!
    @IBOutlet var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.title = "Meme Viewer"
        checkView()
        //self.navigationController?.navigationItem.title = "Meme Viewer"
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        picture.image = curMeme.memedPicture
        checkView()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        checkView()
    }
    
    @IBAction func iseditbuttonPressed()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! ViewController
        vc.meme = curMeme
        present(vc, animated: true, completion: nil)
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


}
