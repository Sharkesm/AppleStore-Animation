//
//  NibLoader.swift
//  AppleStoreApp
//
//  Created by Sharkes Monken on 27/06/2020.
//  Copyright © 2020 Sharkes Monken. All rights reserved.
//

import UIKit

public protocol NibLoadable: class {
    /// The nib file to use to load a new instance of the View designed in a XIB
    static var nib: UINib { get }
}

public extension NibLoadable {
    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
}

public extension NibLoadable where Self: UIView {
    ///    Returns a `UIView` object instantiated from nib
    ///    - returns: A `NibLoadable`, `UIView` instance
    static func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
          fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}
