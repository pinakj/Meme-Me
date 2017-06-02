//
//  InitialSetupViewController.swift
//  PickingImages
//
//  Created by Pinak Jalan on 5/30/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

class InitialSetupViewController: UITabBarController {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isTrue:Bool = false

    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        memes = appDelegate.memes
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isTrue == false
        {
            initialiseMemes()
            isTrue = true
            
        }
    }
    
    func initialiseMemes()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BaseViewController") as! ViewController
        present(vc, animated: true, completion: nil)
    }

}
