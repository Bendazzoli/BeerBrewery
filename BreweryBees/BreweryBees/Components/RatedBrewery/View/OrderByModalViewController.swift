//
//  OrderByModalViewController.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 03/03/22.
//

import UIKit

class OrderByModalViewController: UIViewController {
    
    private enum Constants {
        static let title = "rated.brewery.orderBy.title"
        static let byName = "rated.brewery.orderBy.byName"
        static let byRate = "rated.brewery.orderBy.byRate"
    }
    
    var onUpdateBreweries: ((Bool) -> ()) = { orderByName in }
    public var isOrderingByName = true
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(separetorLine)
        view.addSubview(byNameRadioButton)
        view.addSubview(byNameLabel)
        view.addSubview(byRateRadioButton)
        view.addSubview(byRateLabel)
        
        setRadioButtonImage(isOrderingByName)
        generateConstraints()
    }
    
    let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.title.localized
        titleLabel.font = UIFont(name: "Quicksand-Regular", size: 16)
        
        return titleLabel
    }()
    
    let separetorLine: UIView = {
        let separetorLine = UIView()
        separetorLine.backgroundColor = UIColor(red: 0.8471, green: 0.8471, blue: 0.8471, alpha: 1.0)
        separetorLine.translatesAutoresizingMaskIntoConstraints = false
        return separetorLine
    }()
    
    let byNameRadioButton: UIButton = {
        let byNameRadioButton = UIButton()
        byNameRadioButton.translatesAutoresizingMaskIntoConstraints = false
        byNameRadioButton.setImage(UIImage.init(systemName: "circle.inset.filled"), for: .normal)
        byNameRadioButton.tintColor = .black
        byNameRadioButton.addTarget(self, action: #selector(orderBreweriesByName), for: .touchUpInside)
        
        return byNameRadioButton
    }()
    
    let byNameLabel: UILabel = {
       let byNameLabel = UILabel()
        byNameLabel.translatesAutoresizingMaskIntoConstraints = false
        byNameLabel.text = Constants.byName.localized
        byNameLabel.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return byNameLabel
    }()
    
    let byRateRadioButton: UIButton = {
        let byRateRadioButton = UIButton()
        byRateRadioButton.translatesAutoresizingMaskIntoConstraints = false
        byRateRadioButton.setImage(UIImage.init(systemName: "circle"), for: .normal)
        byRateRadioButton.tintColor = .black
        byRateRadioButton.addTarget(self, action: #selector(orderBreweriesByRate), for: .touchUpInside)
        
        return byRateRadioButton
    }()
    
    let byRateLabel: UILabel = {
       let byRateLabel = UILabel()
        byRateLabel.translatesAutoresizingMaskIntoConstraints = false
        byRateLabel.text = Constants.byRate.localized
        byRateLabel.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return byRateLabel
    }()
    
    @objc func orderBreweriesByName() {
        onUpdateBreweries(true)
        setRadioButtonImage(true)
    }
    
    @objc func orderBreweriesByRate() {
        onUpdateBreweries(false)
        setRadioButtonImage(false)
    }
    
    func setRadioButtonImage(_ isOrderingByName : Bool) {
        if isOrderingByName {
            byRateRadioButton.setImage(UIImage.init(systemName: "circle"), for: .normal)
            byNameRadioButton.setImage(UIImage.init(systemName: "circle.inset.filled"), for: .normal)
        } else {
            byRateRadioButton.setImage(UIImage.init(systemName: "circle.inset.filled"), for: .normal)
            byNameRadioButton.setImage(UIImage.init(systemName: "circle"), for: .normal)
        }
    }
    
    func generateConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            
            separetorLine.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            separetorLine.leadingAnchor.constraint(equalTo: super.view.leadingAnchor),
            separetorLine.trailingAnchor.constraint(equalTo: super.view.trailingAnchor),
            separetorLine.heightAnchor.constraint(equalToConstant: 1),
            
            byNameRadioButton.topAnchor.constraint(equalTo: separetorLine.bottomAnchor, constant: 20),
            byNameRadioButton.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -12),
            
            byNameLabel.topAnchor.constraint(equalTo: separetorLine.bottomAnchor, constant: 20),
            byNameLabel.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 12),
            byNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: byNameRadioButton.leadingAnchor, constant: 8),
            
            byRateRadioButton.topAnchor.constraint(equalTo: byNameLabel.bottomAnchor, constant: 20),
            byRateRadioButton.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -12),
            
            byRateLabel.topAnchor.constraint(equalTo: byNameLabel.bottomAnchor, constant: 20),
            byRateLabel.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 12),
            byRateLabel.trailingAnchor.constraint(lessThanOrEqualTo: byRateRadioButton.leadingAnchor, constant: 8),
        ])
    }
}
