//
//  ItemCell.swift
//  SampleImageApp
//
//  Created by Neha Pandey on 22/06/19.
//  Copyright © 2019 Neha Pandey. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    //MARK: - Item ImageView Configuration
    let itemImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        return imgView
    }()
    
    //MARK: - Item Name Configuration
    let itemNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        return lbl
    }()
    
    //MARK: - Item Description Configuration
    let itemDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "Avenir-Book", size: 16)
        lbl.textColor = UIColor.darkGray
        return lbl
    }()
    
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let marginGuide = contentView.layoutMarginsGuide
        
        //MARK: - configure Item ImageView Constraints
        contentView.addSubview(itemImageView)
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        itemImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        
        itemImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //MARK: - configure Item Name Constraints
        contentView.addSubview(itemNameLabel)
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        itemNameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 15).isActive = true
        itemNameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 40).isActive = true
        itemNameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        //MARK: - configure Item Description Constraints
        contentView.addSubview(itemDescriptionLabel)
        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        itemDescriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        itemDescriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        itemDescriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        itemDescriptionLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
