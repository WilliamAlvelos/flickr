//
//  String+Localized.swift
//  Flickr
//
//  Created by William de Alvelos on 14/01/2024.
//

import Foundation

extension String {
    var local: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func local(with elements: [CVarArg]) -> String {
        return String(format: NSLocalizedString(self, comment: ""), arguments: elements)
    }
}
