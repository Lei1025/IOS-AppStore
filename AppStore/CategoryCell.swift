//
//  CategoryCell.swift
//  AppStore
//
//  Created by Lei Liu on 2018/1/5.
//  Copyright © 2018年 Lei Liu. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var featuredAppController : FeaturedAppsController?
    
    var appCategory: AppCategory? {
        didSet { //https://www.hackingwithswift.com/read/8/5/property-observers-didset
            if let name = appCategory?.name {
                nameLabel.text = name
            }
            appColletionView.reloadData()
        }
    }
    
    private let cellId = "appCellId"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let appColletionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor =  UIColor.clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text =  "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        backgroundColor = UIColor.clear
        addSubview(appColletionView)
        addSubview(dividerLineView)
        addSubview(nameLabel)

        appColletionView.dataSource = self
        appColletionView.delegate = self
        
        appColletionView.register(AppCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[v0]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appColletionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[namelabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : appColletionView, "v1": dividerLineView, "namelabel": nameLabel]))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = appCategory?.apps![indexPath.item] else { return }
        featuredAppController?.showAppDetailForApp(app: app)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = appCategory?.apps?.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class AppCell:UICollectionViewCell{
    
    var app : App?{
        didSet{
            if let name = app?.Name{
            nameLabel.text = name

                let rect = NSString(string: name).boundingRect(with: CGSize(width: frame.width,height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 14)], context: nil)
                
                if rect.height > 20 {
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
                }else{
                    categoryLabel.frame = CGRect(x: 0, y: frame.width + 20, width: frame.width, height: 20)
                    priceLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
                }
                nameLabel.frame = CGRect(x: 0, y: frame.width + 4, width: frame.width + 8, height: 40)
                nameLabel.sizeToFit()
                
            }
            categoryLabel.text = app?.Category
            if let price = app?.Price{
                let priceStr = String(format: "%.2f", price)
                priceLabel.text = "$\(priceStr)"
            }else{
                priceLabel.text = ""
            }
            if let imageName = app?.ImageName {
                imageView.image = UIImage(named: imageName)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        let iv = UIImageView()
       // iv.image = UIImage(named: "frozen")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds =  true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text =  "Disney Build It: Frozen"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel:UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let priceLabel:UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()
    func setupViews(){
        //backgroundColor = UIColor.black
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(categoryLabel)
        addSubview(priceLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        nameLabel.frame = CGRect(x: 0, y: frame.width, width: frame.width + 2 , height: 40)
        categoryLabel.frame = CGRect(x: 0, y: frame.width + 38, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 56, width: frame.width, height: 20)
    }
}
