//
//  ShadowView.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit() 
    }
    
    func commonInit() {
        self.layer.shadowRadius = 8
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset =  CGSize(width: 0, height: 8)
    }
    
}
