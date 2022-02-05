//
//  String.swift
//  BeerBrewery
//
//  Created by Paulo Henrique Bendazzoli on 04/02/22.
//

import Foundation

extension String {
  var localized: String {
        NSLocalizedString(self, comment: "MISSING KEY")
    }
}
