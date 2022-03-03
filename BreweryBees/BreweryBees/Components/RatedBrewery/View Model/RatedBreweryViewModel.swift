//
//  RatedBreweryViewModel.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 25/02/22.
//

import Foundation

class RatedBreweryViewModel {
    
    private enum Constants {
        static let orderByName = "rated.brewery.orderBy.name"
        static let orderByRate = "rated.brewery.orderBy.rate"
    }
   
    public let breweryRepositoryProtocol: BreweryRepositoryProtocol
    public var ratedBreweries: [BreweryDefaultModel] = []
    var onShowResults: ((Bool) -> ()) = { hasData in }
    var onOrderBreweriesList: ((String) -> ()) = { orderBy in }
    public var isOrderingByName = true
    
    init(breweryRepositoryProtocol: BreweryRepositoryProtocol) {
        self.breweryRepositoryProtocol = breweryRepositoryProtocol
    }
    
    func searchRatedBreweries(email: String) {
        breweryRepositoryProtocol.ratedBrewery(email: email) { results in
            if results.count > 0 {
                self.ratedBreweries = results.sorted(by: { return $0.name! < $1.name! })
                self.onShowResults(true)
            }else{
                self.onShowResults(false)
            }
        }
    }
    
    func orderBreweries(byName: Bool = true) {
        var orderByString = ""
        isOrderingByName = byName
        ratedBreweries = ratedBreweries.sorted(by: {
            if byName {
                orderByString = Constants.orderByName.localized
                return $0.name! < $1.name!
            } else {
                orderByString = Constants.orderByRate.localized
                return $0.average! > $1.average!
            }
        })
        self.onOrderBreweriesList(orderByString)
    }
}
