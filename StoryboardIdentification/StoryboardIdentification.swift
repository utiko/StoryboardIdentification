//
//  StoryboardIdentification.swift
//  StoryboardIdentification
//
//  Created by Kostia Kolesnyk on 9/26/18.
//  Copyright © 2018 Kostia Kolesnyk. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewControllerInstantiatable {
    var storyboardName: String { get }
    var rawValue: String { get }
    init?(rawValue: String)
}

public extension ViewControllerInstantiatable {
    public var storyboardID: String { return rawValue }
    
    func instantiate() -> UIViewController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if storyboardID == "initial" {
            guard let vc = storyboard.instantiateInitialViewController() else {
                fatalError("Initial view controller not specified at \\(storyboardName) storyboard")
            }
            
            return vc
            
        } else {
            return storyboard.instantiateViewController(withIdentifier: storyboardID)
        }
    }
}


public struct StoryboardIdentification {
    let identifier: ViewControllerInstantiatable
    
    public init(identifier: ViewControllerInstantiatable) {
        self.identifier = identifier
    }
}

public extension StoryboardIdentification {
    public func instantiate<T: UIViewController>() -> T {
        
        guard let vc = identifier.instantiate() as? T else {
            fatalError("Instantiated view controller deesn't have expected type '\\(T.self)'")
        }
        
        return vc
    }
}
