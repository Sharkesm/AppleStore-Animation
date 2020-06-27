//
//  CellLoadable.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import Foundation

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

/// Make your `UITableViewCell` and `UICollectionViewCell` subclasses
/// conform to this typealias when they *are* NIB-based
/// to be able to dequeue them in a type-safe manner
public typealias NibReusable = Reusable & NibLoadable


public extension Reusable {
    /// By default, use the name of the class as String for its reuseIdentifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
