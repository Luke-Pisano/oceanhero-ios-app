//
//  JSONReader.swift
//  UnitTests
//
//  Created by Cezary Bielecki on 31/08/2020.
//  Copyright © 2020 DuckDuckGo. All rights reserved.
//

import Foundation
import XCTest

internal class JSONReader {
    static func readJSON(fileName: String) -> [String: Any]? {
        let data = readJSONData(fileName: fileName)
        return createJSON(from: data)
    }
    
    static func createJSON(from data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                return object
            } else {
                print("JSON is invalid")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    static func readJSONData(fileName: String) -> Data {
        let bundle = Bundle(for: JSONReader.self)
        
        guard let file = bundle.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: file) else {
                fatalError("Could not read filename: \(fileName)")
        }
        
        return data
    }
}
