//
//  CardCell.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet fileprivate weak var commonView: UIView!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var topSubtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bottomSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonView.layer.cornerRadius = 10
        self.commonView.layer.masksToBounds = true 
    }
    
    
}
