//
//  StoryboardIdentification.swift
//  StoryboardIdentification
//
//  Created by Kostia Kolesnyk on 9/26/18.
//  Copyright © 2018 Kostia Kolesnyk. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerInstantiatable {
    var storyboardName: String { get }
    var rawValue: String { get }
    init?(rawValue: String)
}

extension ViewControllerInstantiatable {
    var storyboardID: String { return rawValue }
    
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

struct StoryboardIdentification {
    private let identifier: ViewControllerInstantiatable
}

extension StoryboardIdentification {
    public func instantiate<T: UIViewController>() -> T {
        
        guard let vc = identifier.instantiate() as? T else {
            fatalError("Instantiated view controller deesn't have expected type '\\(T.self)'")
        }
        
        return vc
    }
}
