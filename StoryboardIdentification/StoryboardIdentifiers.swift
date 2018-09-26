//
//  UpdateConstants.swift
//  FilmFest
//
//  Created by Kostia Kolesnyk on 9/24/18.
//

import Foundation

class StoryboardXMLParserHandler: NSObject, XMLParserDelegate {
    var identifiers = [String]()
    var containsInitialViewController = false
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
        case "viewController":
            if let identifier = attributeDict["storyboardIdentifier"] {
                identifiers.append(identifier)
            }
        case "document":
            if attributeDict["initialViewController"] != nil {
                containsInitialViewController = true
            }
            
        default:
            break
        }
    }
}

class StoryboardIdentifiers {
    
    public static func updateStoryboarIDs(srcRoot: String) {
        guard let extensionUrl = findSwiftExtension(path: srcRoot) else { return }
        
        var storyboardsExtension = ""
        var identificationExtension = ""
        
        let storyboards = findStoryboards(path: srcRoot)
        storyboards.forEach { (storyboardURL) in
            
            let realName = storyboardURL.deletingPathExtension().lastPathComponent
            let fullName = (realName.lowercased().hasSuffix("storyboard")
                ? realName
                : realName.appending("Storyboard"))
            
            let camelcasedName = self.calmelCased(str: fullName)
            
            guard let parser = XMLParser(contentsOf: storyboardURL) else { return }
            
            let parserHandler = StoryboardXMLParserHandler()
            parser.delegate = parserHandler
            parser.parse()
            
            if parserHandler.identifiers.count > 0 || parserHandler.containsInitialViewController {
                storyboardsExtension.append("\n    enum \(fullName): String, ViewControllerInstantiatable {")
                storyboardsExtension.append("\n        var storyboardName: String { return \"\(realName)\" }\n")
                
                
                identificationExtension.append("\n    static func \(camelcasedName)(_ identifier: UIStoryboard.\(fullName)) -> StoryboardIdentification { return StoryboardIdentification(identifier: identifier) }\n")
                
                if parserHandler.containsInitialViewController {
                    storyboardsExtension.append("\n        case initial")
                }
                
                parserHandler.identifiers.forEach({ (identifier) in
                    let camelcased = self.calmelCased(str: identifier)
                    storyboardsExtension.append("\n        case \(camelcased) = \"\(identifier)\"")
                })
                
                
                storyboardsExtension.append("\n    }\n")
                
            }
            
        }
        
        let swiftCode = self.generateSwiftCode(storyboardExtension: storyboardsExtension,
                                               storyboardIdentificationExtension: identificationExtension)
        
        try? swiftCode.write(to: extensionUrl, atomically: true, encoding: .utf8)
    }
    
    private static func findStoryboards(path: String) -> [URL] {
        var result = [URL]()
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: path)
        while let element = enumerator?.nextObject() as? String {
            if element.hasSuffix("storyboard") {
                let url = URL(fileURLWithPath: element)
                result.append(url)
            }
        }
        return result
    }
    
    private static func findSwiftExtension(path: String) -> URL? {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: path)
        while let element = enumerator?.nextObject() as? String {
            if element.contains("StoryboardIdentifiersUtils.swift") {
                let url = URL(fileURLWithPath: element)
                return url
            }
        }
        return nil
    }
    
    private static func calmelCased(str: String) -> String {
        return str.prefix(1).lowercased() + str.suffix(str.count - 1)
    }
    
    private static func generateSwiftCode(storyboardExtension: String,
                                   storyboardIdentificationExtension: String) -> String {
        let swiftCode = """
//
//  UIStoryboard+Identifiers.swift
//  Generated by script
//

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

extension UIViewController {
    static func instantiate(from identification: StoryboardIdentification) -> Self {
        return identification.instantiate()
    }
}

extension UIStoryboard {
    \(storyboardExtension)
}

extension StoryboardIdentification {
    \(storyboardIdentificationExtension)
}
        
"""
        return swiftCode
    }
}
