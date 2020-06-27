//
//  CollectionView++.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    ///    Register a NIB-Based `UICollectionViewCell` subclass (conforming to `Reusable` & `NibLoadable`)
    ///    - parameter cellType: the `UICollectionViewCell` (`Reusable` & `NibLoadable`-conforming) subclass to register
    
    final func register<T: UICollectionViewCell>(cellType cell: T.Type) where T: Reusable & NibLoadable {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    /// Register a Class-Based `UICollectionViewCell` subclass (conforming to `Reusable`)
    /// - parameter cellType: the `UICollectionViewCell` (`Reusable`-conforming) subclass to register
    
    final func register<T: UICollectionViewCell>(cellType cell: T.Type) where T: Reusable {
        self.register(cell.self, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    ///    Returns a reusable `UICollectionViewCell` object for the class inferred by the return-type
    ///      - parameter indexPath: The index path specifying the location of the cell.
    ///      - parameter cellType: The cell class to dequeue
    ///      - returns: A `Reusable`, `UICollectionViewCell` instance
    ///      - note: The `cellType` parameter can generally be omitted and infered by the return type,
    ///      except when your type is in a variable and cannot be determined at compile time.
    
    final func dequeueReuseableCell<T: UICollectionViewCell>(for indexPath: IndexPath,
                                                             cellType cell: T.Type = T.self) -> T where T: Reusable {
        
        let queueCell = self.dequeueReusableCell(withReuseIdentifier: cell.reuseIdentifier, for: indexPath)
            
        guard let bareCell = queueCell as? T else {
            fatalError(
              "Failed to dequeue a cell with identifier \(cell.reuseIdentifier) matching type \(cell.self). "
                + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                + "and that you registered the cell beforehand"
            )
        }
        
        return bareCell
    }
}

