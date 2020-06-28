//
//  APTransitionAnimation.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 28/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import Foundation
import UIKit

class APTransitionAnimation: NSObject {
    fileprivate let operationType: UINavigationController.Operation
    fileprivate let positioningDuration: TimeInterval
    fileprivate let resizingDuration: TimeInterval
    
    init(
        operation: UINavigationController.Operation,
        positioningDuration: TimeInterval,
        resizingDuration: TimeInterval) {
        self.operationType = operation
        self.positioningDuration = positioningDuration
        self.resizingDuration = resizingDuration
    }
}

extension APTransitionAnimation: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return max(positioningDuration, resizingDuration)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.operationType == .push {
        self.presentTransition(transitionContext)
        } else if self.operationType == .pop {
        self.dismissTransition(transitionContext)
        }
    }
}

extension APTransitionAnimation {
    
     // Custom push animations
    internal func presentTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        // Views we are animating FROM
        guard let fromVC = transitionContext.viewController(forKey: .from) as? APAnimatable,
            let fromContainer = fromVC.containerView,
            let fromChild = fromVC.childView else {
                return
        }
        
        // Views we are animating TO
        guard let toVC = transitionContext.viewController(forKey: .to) as? APAnimatable,
            let toView = transitionContext.view(forKey: .to) else {
                return
        }
        
        // Preserve original frames
        let originalFrame = toView.frame
        
        container.addSubview(toView)
        
        // Determine start and end points for animation
        // Get the coordinates of the view inside the container
        let originFrame = CGRect(origin: fromContainer.convert(fromChild.frame.origin, to: container),
                                   size: fromChild.frame.size)
        let destinationFrame = toView.frame
        toView.frame = originFrame
        toView.layoutIfNeeded()
        
        fromChild.isHidden = true
        
        // Perform the animation
        // Calculate the change in coordinate positions
        let yDiffs = destinationFrame.origin.y - originFrame.origin.y
        let xDiffs = destinationFrame.origin.x - originFrame.origin.x
        
        // For the duration of the animation, we are moving the frame. Therefore we have a separate animator
        // to just control the Y positioning of the views. We will also use this animator to determine when
        // all of our animations are done.
        let positionAnimator = UIViewPropertyAnimator(duration: positioningDuration, dampingRatio: 0.7)
        positionAnimator.addAnimations {
            toView.transform = CGAffineTransform(translationX: 0, y: yDiffs)
        }
        
        let sizeAnimator = UIViewPropertyAnimator(duration: resizingDuration, curve: .easeInOut)
        sizeAnimator.addAnimations {
            toView.frame.size = destinationFrame.size
            toView.layoutIfNeeded()
            
            toView.transform = toView.transform.concatenating(CGAffineTransform(translationX: xDiffs, y: 0))
        }
        
        toVC.presentingView(sizeAnimator: sizeAnimator, positionAnimator: positionAnimator, fromFrame: originFrame, toFrame: destinationFrame)
        
        let completionHandler: (UIViewAnimatingPosition) -> Void = { _ in
            toView.transform = .identity
            toView.frame = originalFrame
            toView.layoutIfNeeded()
            
            fromChild.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        if (self.positioningDuration > self.resizingDuration) {
            positionAnimator.addCompletion(completionHandler)
        } else {
            sizeAnimator.addCompletion(completionHandler)
        }
        
        positionAnimator.startAnimation()
        sizeAnimator.startAnimation()
    }
    
    // Custom pop animations
    internal func dismissTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView
        
        // Get the views we are animating FROM
        guard let fromVC = transitionContext.viewController(forKey: .from) as? APAnimatable,
            let fromView = transitionContext.view(forKey: .from) else {
                return
        }
        
        // Views we are animating TO
        guard let toVC = transitionContext.viewController(forKey: .to) as? APAnimatable,
            let toView = transitionContext.view(forKey: .to),
            let toContainer = toVC.containerView,
            let toChild = toVC.childView else {
                return
        }
    
        container.addSubview(toView)
        container.addSubview(fromView)
        
        // Determine start and end points for animation
        // Get the coordinates of the view inside the container
        let originFrame = fromView.frame
        let destinationFrame = CGRect(origin: toContainer.convert(toChild.frame.origin, to: container),
                                      size: toChild.frame.size)
        
        toChild.isHidden = true
        
        // Perform the animation
        let yDiff = destinationFrame.origin.y - originFrame.origin.y
        let xDiff = destinationFrame.origin.x - originFrame.origin.x
        
        // For the duration of the animation, we are moving the frame. Therefore we have a separate animator
        // to just control the Y positioning of the views. We will also use this animator to determine when
        // all of our animations are done.
        let positionAnimator = UIViewPropertyAnimator(duration: positioningDuration, dampingRatio: 0.7)
        positionAnimator.addAnimations {
            // Move the view in the Y direction
            fromView.transform = CGAffineTransform(translationX: 0, y: yDiff)
        }
        
        let sizeAnimator = UIViewPropertyAnimator(duration: resizingDuration, curve: .easeInOut)
        sizeAnimator.addAnimations {
            fromView.frame.size = destinationFrame.size
            fromView.layoutIfNeeded()
            
            // Move the view in the X direction. We concatinate here because we do not want to overwrite our
            // previous transformation
            fromView.transform = fromView.transform.concatenating(CGAffineTransform(translationX: xDiff, y: 0))
        }
        
         // Call the animation delegate
        fromVC.dismissingView(sizeAnimator: sizeAnimator, positionAnimator: positionAnimator, fromFrame: originFrame, toFrame: destinationFrame)
        
         // Animation completion.
        let completionHandler: (UIViewAnimatingPosition) -> Void = { _ in
            fromView.removeFromSuperview()
            toChild.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        // Put the completion handler on the longest lasting animator
        if (positioningDuration > resizingDuration) {
            positionAnimator.addCompletion(completionHandler)
        } else {
            sizeAnimator.addCompletion(completionHandler)
        }
        
        positionAnimator.startAnimation()
        sizeAnimator.startAnimation()

    }
}
