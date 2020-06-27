//
//  ViewController.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 26/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self

        // Set the cells sizes and layout direction
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 400, height: 500)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        self.collectionView.collectionViewLayout = layout
        
        self.collectionView.register(cellType: CardCell.self)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath)
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.isHidden = true
        present(navigationController, animated: true, completion: nil)
    }
}

