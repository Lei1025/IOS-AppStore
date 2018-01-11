//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by Lei Liu on 2018/1/10.
//  Copyright © 2018年 Lei Liu. All rights reserved.
//

import UIKit

class ScreenshotsCell : BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var app : App?{
        didSet{
            collectionView.reloadData()
        }
    }
    let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    private let cellId = "cellId"
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addSubview(collectionView)
        addSubview(dividerLineView)

        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "H:|-14-[v0]|", views: dividerLineView)
        addConstraintsWithFormat(format: "V:|[v0][v1(1)]|", views: collectionView, dividerLineView)
        
        collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = app?.Screenshots?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenshotImageCell
        if let imageName = app?.Screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named: imageName)
        }
        //cell.imageView.image = UIImage(named: "frozen_screenshot1")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: frame.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ScreenshotImageCell: BaseCell{
        
        let imageView : UIImageView = {
           let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = UIColor.green
            return iv
        }()
        
         override func setupViews() {
            super.setupViews()
            
            layer.masksToBounds = true
    
            addSubview(imageView)
            addConstraintsWithFormat(format: "H:|[v0]|", views: imageView)
            addConstraintsWithFormat(format: "V:|[v0]|", views: imageView)
           // backgroundColor = UIColor.yellow
        }
    }
}
