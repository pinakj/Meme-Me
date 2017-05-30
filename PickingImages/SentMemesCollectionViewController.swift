//
//  SentMemesCollectionViewController.swift
//  PickingImages
//
//  Created by Pinak Jalan on 5/29/17.
//  Copyright © 2017 Pinak Jalan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "collectionView"

class SentMemesCollectionViewController: UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var flowLayout : UICollectionViewFlowLayout!

    var memes = [Meme]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let space:CGFloat = 1.0
        var dimension:CGFloat = 0.0
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft || UIDevice.current.orientation == UIDeviceOrientation.landscapeRight
        {
             dimension = (view.frame.size.height - (2 * space))/3.0
            print("Here")
        }
        else
        {
             dimension = (view.frame.size.width - (2 * space))/3.0

        }
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        print(memes.count)
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SentMemesCollectionViewCell
        
        cell.imageView?.image = memes[indexPath.row].memedPicture
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        vc.curMeme = memes[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

}
