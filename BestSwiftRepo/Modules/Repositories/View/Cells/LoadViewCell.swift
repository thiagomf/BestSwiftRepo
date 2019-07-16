//
//  LoadViewCell.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 16/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit

class LoadElement: CustomRepoElementModel {
    
    var type: CustomRepoType { return .loadCell }
    
    init() {
    }
    
}

class LoadViewCell: UITableViewCell, CustomRepoElementCell {

    var model: LoadElement!
    
    private let loadProgress: UIActivityIndicatorView = {
        let loadP = UIActivityIndicatorView(style: .gray)
        return loadP
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(loadProgress)
        
        loadProgress.anchor(top: topAnchor,
                           left: leftAnchor,
                           bottom: bottomAnchor,
                           right: rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 15,
                           paddingBottom: 15,
                           paddingRight: 15,
                           width: 90,
                           height: 90,
                           enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withModel elementModel: CustomRepoElementModel) {
        
        guard let model = elementModel as? LoadElement else {
            print("Unable to cast model as LoadElement: \(elementModel)")
            return
        }
        
        self.model = model
        loadProgress.startAnimating()
    }

}
