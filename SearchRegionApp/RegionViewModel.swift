//
//  RegionViewModel.swift
//  SearchRegionApp
//
//  Created by Peter Chen on 24/1/2023.
//

import Foundation
struct RegionViewModel {
    private var regions: [String] = []
    var currentRegions: [String] = []
    var selectedRegion: String?
    init(_ regions: [String]? = nil) {
        if regions == nil {
            self.regions = ["Afghanistan", "Albania",
                            "Algeria","Andorra","Angola","Argentina","Armenia","Aruba","Australia","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bhutan","Bolivia","Botswana","Brazil","Bulgaria","Burundi","Cambodia","Cameroon","Canada","Chad","Chile","China","Colombia","Comoros","Congo","Croatia","Cuba","Cyprus","Denmark","Djibouti","Dominica"].sorted()
            self.currentRegions = self.regions
        }
        
    }
    
    mutating func resetRegion(_ completion: @escaping () -> ()) {
        currentRegions = regions
        completion()
    }
    
    // Change region to search regions
    mutating func searchRegion(_ keyword: String, _ completion: @escaping () -> ()) {
        let newRegions = regions.filter {
            guard $0.count > keyword.count else { return false }
            let region = String($0[..<keyword.endIndex])
            return region.lowercased() == keyword.lowercased()
        }
        
        self.currentRegions = newRegions
        completion()
    }
    
    mutating func setSelectedRegion(_ region: String?) {
        if let region = region {
            selectedRegion = region
        }
    }
}
