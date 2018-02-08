//
//  ViewController.swift
//  fbMessanger
//
//  Created by Pavel Burdukovskii on 07/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class FriendController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
   private let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        //register cell in collectionView
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(FriendCell.self, forCellWithReuseIdentifier: cellId)
     }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
}

class FriendCell : BaseCell {
    //create profile icon ImageView
    let profileImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let deviderLineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .gray
        return lineView
        }()
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Friends Name"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    let messageLabel : UILabel = {
        let label = UILabel()
        label.text = "Your friend's message and somethink yet"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15)

        return label
    }()
    let timeLabel :UILabel = {
        let label = UILabel()
        let dateTime = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat  = "HH:mm:ss"
        label.text = dateFormater.string(from: dateTime)
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .right
        return label
    }()
    let hasReadedImgView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

   override func setupView(){
    //add to cell View our profileImageView
    addSubview(profileImgView)
    addSubview(deviderLineView)
    setupContainerView()

    profileImgView.image = UIImage(named: "Ba_Dum_Tss_Cat")
    hasReadedImgView.image = UIImage(named: "Ba_Dum_Tss_Cat")

    //addConstrate to imageView H-horizontal and V-Vertical
    addConstraitWithFormat("H:|-12-[v0(70)]", views: profileImgView)
    addConstraitWithFormat("V:|-12-[v0(70)]", views: profileImgView)
    
    //centered view
    addConstraint(NSLayoutConstraint(item: profileImgView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    
    //addConstrate to line H-horizontal and V-Vertical
    addConstraitWithFormat("H:|-85-[v0]|", views: deviderLineView)
    addConstraitWithFormat("V:[v0(1)]|", views: deviderLineView)
    
    }
    //setupContainerView to messages
    private func setupContainerView (){
        let containerView = UIView()
        addSubview(containerView)
        addConstraitWithFormat("H:|-90-[v0]|", views: containerView)
        addConstraitWithFormat("V:[v0(50)]", views: containerView)
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        containerView.addSubview(nameLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadedImgView)
        containerView.addConstraitWithFormat("H:|[v0][v1(100)]-14-|", views: nameLabel,timeLabel)
        containerView.addConstraitWithFormat("V:|[v0][v1(24)]|", views: nameLabel, messageLabel)
        containerView.addConstraitWithFormat("H:|[v0]-8-[v1(20)]-12-|", views: messageLabel,hasReadedImgView)
        containerView.addConstraitWithFormat("V:|[v0(20)]|", views: timeLabel)
        containerView.addConstraitWithFormat("V:[v0(20)]|", views: hasReadedImgView)

    }
}
extension UIView {
    func addConstraitWithFormat(_ format: String, views: UIView...){
        var dictView : [String : UIView] = Dictionary()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            dictView[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
         addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictView))
    }
}
class BaseCell : UICollectionViewCell  {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupView(){
        backgroundColor = .red
    }
}
