//
//  CollectionViewController.swift
//  CircleLayout
//
//  Created by 王振 on 2018/8/28.
//  Copyright © 2018年 wz. All rights reserved.
//

import UIKit

let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    let images: [String] = Bundle.main.paths(forResourcesOfType: "png", inDirectory: "Images")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UINib(nibName: "CircularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        let imageView = UIImageView(image: UIImage(named: "bg-dark.jpg"))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        collectionView!.backgroundView = imageView
    }


}

extension CollectionViewController  {
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CircularCollectionViewCell;
        cell.imageName = images[indexPath.row];
        return cell;
        
    }

    
}
