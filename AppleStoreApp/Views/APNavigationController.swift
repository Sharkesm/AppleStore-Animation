//
//  APNavigationController.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 28/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

class APNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
}

extension APNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return APTransitionAnimation(operation: operation, positioningDuration: 1, resizingDuration: 0.5)
    }
    
}

