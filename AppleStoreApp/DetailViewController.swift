//
//  DetailViewController.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, StoryboardSceneBased {
    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var commonView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var commonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var commonHeightConstraint: NSLayoutConstraint!
    
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true 
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func transformAsCard(_ value: Bool) {
        self.maskView.layer.cornerRadius = (value) ? 10 : 0
    }
}

extension DetailViewController: APAnimatable {
    var containerView: UIView? {
        return self.view
    }
    
    var childView: UIView? {
        return self.commonView
    }
    
    func presentingView(sizeAnimator: UIViewPropertyAnimator, positionAnimator: UIViewPropertyAnimator,
                        fromFrame: CGRect, toFrame: CGRect) {
        
        self.commonHeightConstraint.constant = fromFrame.height
        self.closeButton.alpha = 1
        self.transformAsCard(true)
        self.view.layoutIfNeeded()
        
        // Push the content of the common view down to stay within the safe area insets
        let safeAreas = UIApplication.shared.keyWindow?.safeAreaInsets.top ?? .zero
        self.commonTopConstraint.constant = safeAreas + 16
        self.commonHeightConstraint.constant = 500
        
        sizeAnimator.addAnimations {
            self.view.layoutIfNeeded()
        }
        
        positionAnimator.addAnimations {
            self.transformAsCard(false)
        }
    }
    
    func dismissingView(sizeAnimator: UIViewPropertyAnimator, positionAnimator: UIViewPropertyAnimator, fromFrame: CGRect, toFrame: CGRect) {
        
        // If user scrolled through the content, force the common view to the top of the screen
        self.commonTopConstraint.isActive = true
        

        // If the top card is completely off screen, we move it to be JUST off screen.
        // This makes for a cleaner looking animation.
        if scrollView.contentOffset.y > commonView.frame.height {
            self.commonTopConstraint.constant = -commonView.frame.height
            self.view.layoutIfNeeded()
            
            // Still want to animate the common view getting pinned to the top of the view
            self.commonTopConstraint.constant = 0
        }
        
        self.commonTopConstraint.constant = 16
        
        // Animate the height of the common view to be the same size as the TO frame.
        // Also animate hiding the close button
        self.commonHeightConstraint.constant = toFrame.height
        
        sizeAnimator.addAnimations {
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        // Animate the view to look like a card
        positionAnimator.addAnimations {
            self.transformAsCard(true)
        }
    }
}

