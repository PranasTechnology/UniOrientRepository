//
//  ArrayExtension.swift
//  TripArcher
//
//  Created by APPLE on 15/02/19.
//  Copyright © 2019 APPLE. All rights reserved.
//

import UIKit

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
