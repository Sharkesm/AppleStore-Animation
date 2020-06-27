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
        dismiss(animated: true, completion: nil)
    }
    
    func transformAsCard(_ value: Bool) {
        self.maskView.layer.cornerRadius = (value) ? 10 : 0
    }
}
