//
//  ViewController.swift
//  BeerBrewery
//
//  Created by Paulo Henrique Bendazzoli on 04/02/22.
//

import UIKit

class ViewController: UIViewController {
    
    private enum Constants {
        static let welcomeTitle = "viewController.welcome.title"
        static let searchTextFieldPlaceholder = "viewController.search.placeholder"
        static let localeButtonDescription = "viewController.localeButton.description"
    }

    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var localeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTextfield()
        setViewControllerStrings()
    }
    
    func imageTextfield() {
        let imageview = UIImageView(frame: CGRect(x: 16, y: 8, width: 23, height: 23))
        let image = UIImage(named: "iconSearch")
        imageview.image = image
        imageview.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageview)
        textFieldSearch?.leftViewMode = .always
        textFieldSearch?.leftView = view
    }
    
    func setViewControllerStrings() {
        textFieldSearch.placeholder = Constants.searchTextFieldPlaceholder.localized
        welcomeLabel.text = Constants.welcomeTitle.localized
    }
}

