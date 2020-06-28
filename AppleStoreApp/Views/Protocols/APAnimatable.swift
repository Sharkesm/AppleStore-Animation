//
//  APAnimatable.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 28/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

protocol APAnimatable {
    var containerView: UIView? { get }
    var childView: UIView? { get }
    
    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect)
    
    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect)
}

extension APAnimatable {
    
    func presentingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect) {}
    
    func dismissingView(
        sizeAnimator: UIViewPropertyAnimator,
        positionAnimator: UIViewPropertyAnimator,
        fromFrame: CGRect,
        toFrame: CGRect) {} 
}
