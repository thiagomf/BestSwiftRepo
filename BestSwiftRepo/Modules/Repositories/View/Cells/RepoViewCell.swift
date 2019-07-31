//
//  RepoViewCell.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit
import Kingfisher

class RepoElement: CustomRepoElementModel {
    
    var type: CustomRepoType { return .dataCell }
    var item: Item?
    
    init(item: Item) {
        self.item = item
    }
    
}


class RepoViewCell: UITableViewCell, CustomRepoElementCell {

    var model: RepoElement!
    
    public let repoName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        return lbl
    }()
    
    public let authorName: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    public let authorImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"nophoto"))
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 45.0
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    public let starImage: UIImageView = {
        let imgView = UIImageView(image: UIImage(named:"staricon"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    public let countStars: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(authorImage)
        addSubview(repoName)
        addSubview(authorName)
        addSubview(starImage)
        addSubview(countStars)
        
        authorImage.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: nil,
                           paddingTop: 25,
                           paddingLeft: 15,
                           paddingBottom: 25,
                           paddingRight: 0,
                           width: 90,
                           height: 90,
                           enableInsets: false)
        
        repoName.anchor(top: topAnchor,
                        left: authorImage.rightAnchor,
                        bottom: nil,
                        right: rightAnchor,
                        paddingTop: 20,
                        paddingLeft: 10,
                        paddingBottom: 0,
                        paddingRight: 0,
                        width: 0,
                        height: 0,
                        enableInsets: false)
        
        authorName.anchor(top: repoName.bottomAnchor,
                          left: authorImage.rightAnchor,
                          bottom: nil,
                          right: rightAnchor,
                          paddingTop: 0,
                          paddingLeft: 10,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: 0,
                          height: 0,
                          enableInsets: false)
        
        let stackView = UIStackView(arrangedSubviews: [starImage,countStars])
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        stackView.spacing = 5
        addSubview(stackView)
        stackView.anchor(top: authorName.bottomAnchor,
                         left: authorImage.rightAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 10,
                         paddingBottom: 0,
                         paddingRight: 50,
                         width: 0,
                         height: 30,
                         enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(withModel elementModel: CustomRepoElementModel) {
        
        guard let model = elementModel as? RepoElement else {
            print("Unable to cast model as RepoElement: \(elementModel)")
            return
        }
        
        self.model = model
        
        if let avatarUrl = self.model.item?.owner.avatarURL {
            let url = URL.init(string: avatarUrl)
            self.authorImage.kf.setImage(with: url)
        }
        
        self.repoName.text = self.model.item?.name
        self.authorName.text = self.model.item?.owner.login
        
        if let count = self.model.item?.stargazersCount {
            self.countStars.text = "\(count)"
        }
        
        setupAcessibility(self.model)
    }
    
    func setupAcessibility(_ model: RepoElement) {
        
        self.repoName.isAccessibilityElement = true
        self.repoName.accessibilityValue = model.item?.name
        self.repoName.accessibilityLabel = "Repositório"
        self.repoName.accessibilityTraits = .staticText
        
        self.authorName.isAccessibilityElement = true
        self.authorName.accessibilityValue = self.model.item?.owner.login
        self.authorName.accessibilityLabel = "Autor"
        self.authorName.accessibilityTraits = .staticText
        
        self.countStars.isAccessibilityElement = true
        self.countStars.accessibilityValue = "\(String(describing: self.model.item?.stargazersCount ?? 0))"
        self.countStars.accessibilityLabel = "Classificação"
        self.countStars.accessibilityTraits = .staticText
        
        self.accessibilityElements = [self.repoName, self.authorName, self.countStars]
    }
    
}
