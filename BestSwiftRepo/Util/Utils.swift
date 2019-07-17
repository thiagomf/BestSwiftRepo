//
//  Utils.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 17/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import UIKit
import Foundation

class Utils: NSObject {

    class func loadJson(filename fileName: String) -> Repositories? {

        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Repositories.self, from: data)
                return jsonData
            } catch {
                print("error:\(error)")
            }
        }

        return nil
    }
}
