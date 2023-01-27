//
//  Extension.swift
//  SearchRegionApp
//
//  Created by Peter Chen on 27/1/2023.
//

import Foundation
extension String {
    func containsIngoreingCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
