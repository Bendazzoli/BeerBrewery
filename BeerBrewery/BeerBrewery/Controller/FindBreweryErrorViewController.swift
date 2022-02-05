//
//  FindBreweryErrorViewController.swift
//  BeerBrewery
//
//  Created by Paulo Henrique Bendazzoli on 04/02/22.
//

import UIKit

class FindBreweryErrorViewController: UIViewController {
    
    private enum Constants {
        static let titleNoBreweryTyped = "findBreweryError.title.noBreweryTyped"
        static let titleNotFoundBrewery = "findBreweryError.title.notFoundBrewery"
        static let descriptionBreweryError = "findBreweryError.description"
    }
    
    @IBOutlet weak var titleErrorBrewery: UILabel!
    @IBOutlet weak var descriptionErrorBrewery: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func notBreweryTyped() {
        titleErrorBrewery.text = Constants.titleNoBreweryTyped.localized
        descriptionErrorBrewery.text = Constants.descriptionBreweryError.localized
    }

    func notBreweryFound() {
        titleErrorBrewery.text = Constants.titleNotFoundBrewery.localized
        descriptionErrorBrewery.text = Constants.descriptionBreweryError.localized
    }
    
    func breweryError(title: String, description: String) {
        titleErrorBrewery.text = title
        descriptionErrorBrewery.text = description
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
