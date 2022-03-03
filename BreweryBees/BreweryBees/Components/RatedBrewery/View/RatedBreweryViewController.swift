//
//  RatedBreweryViewController.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 28/02/22.
//

import UIKit
import Lottie

class RatedBreweryViewController: ViewController, UITableViewDelegate {
    
    private enum Constants {
        static let noResultTitle = "rated.brewery.no.result.title"
        static let noResultDescription = "rated.brewery.no.result.description"
        static let title = "rated.brewery.title"
        static let result = "rated.brewery.result"
        static let results = "rated.brewery.results"
        static let orderByDescription = "rated.brewery.orderBy.description"
        static let orderByName = "rated.brewery.orderBy.name"
        static let orderByRate = "rated.brewery.orderBy.rate"
    }
    
    public var email: String = ""
    let ratedBreweryViewModel: RatedBreweryViewModel = BreweryContainer.shared.resolve(RatedBreweryViewModel.self)!
    
    override func viewDidLoad() {
        ratedBackgroundComponent()
        view.backgroundColor = UIColor(red: 0.949, green: 0.949, blue: 0.969, alpha: 1)
        
        ratedBreweryViewModel.searchRatedBreweries(email: email)
        ratedBreweryViewModel.onShowResults = { [weak self] hasData in
            DispatchQueue.main.async {
                self?.view.addSubview(self!.noRatedBreweryTitleLabel)
                self?.view.addSubview(self!.noRatedBreweryDescriptionLabel)
                self?.view.addSubview(self!.titleLabel)
                self?.view.addSubview(self!.resultLabel)
                self?.view.addSubview(self!.orderByLabel)
                self?.view.addSubview(self!.filterButton)
                self?.view.addSubview(self!.tableView)
                
                if self!.ratedBreweryViewModel.ratedBreweries.count > 0 {
                    self?.showRatedBreweries()
                }else{
                    self?.showNoRatedBreweriesFound()
                }
            }
        }
        
        ratedBreweryViewModel.onOrderBreweriesList = { [weak self] orderBy in
            self?.orderByLabel.text = "\(Constants.orderByDescription.localized) \(orderBy)"
            self?.tableView.reloadData()
        }
    }
    
    func showRatedBreweries() {
        resultLabel.text = (self.ratedBreweryViewModel.ratedBreweries.count == 1 ?
                            "\(self.ratedBreweryViewModel.ratedBreweries.count) \(Constants.result.localized)" :
                                "\(self.ratedBreweryViewModel.ratedBreweries.count) \(Constants.results.localized)")
        
        noRatedBreweryTitleLabel.isHidden = true
        noRatedBreweryDescriptionLabel.isHidden = true
        titleLabel.isHidden = false
        resultLabel.isHidden = false
        orderByLabel.isHidden = false
        filterButton.isHidden = false
        tableView.isHidden = false
        
        for view in self.view.subviews {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: RatedBreweryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RatedBreweryTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            //MARK: constraints for rated brewery found
            titleLabel.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -16),
            
            resultLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            resultLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            filterButton.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 16),
            filterButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            orderByLabel.topAnchor.constraint(equalTo: filterButton.topAnchor),
            orderByLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            orderByLabel.trailingAnchor.constraint(lessThanOrEqualTo: filterButton.leadingAnchor, constant: 8),
            
            tableView.topAnchor.constraint(equalTo: orderByLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: orderByLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func showNoRatedBreweriesFound() {
        noRatedBreweryTitleLabel.isHidden = false
        noRatedBreweryDescriptionLabel.isHidden = false
        titleLabel.isHidden = true
        resultLabel.isHidden = true
        orderByLabel.isHidden = true
        filterButton.isHidden = true
        tableView.isHidden = true
        
        NSLayoutConstraint.activate([
            //MARK: constraints for no rated brewery found
            noRatedBreweryTitleLabel.topAnchor.constraint(equalTo: super.view.topAnchor, constant: 28),
            noRatedBreweryTitleLabel.leadingAnchor.constraint(equalTo: super.view.leadingAnchor, constant: 16),
            noRatedBreweryTitleLabel.trailingAnchor.constraint(equalTo: super.view.trailingAnchor, constant: -16),
            
            noRatedBreweryDescriptionLabel.topAnchor.constraint(equalTo: noRatedBreweryTitleLabel.bottomAnchor, constant: 12),
            noRatedBreweryDescriptionLabel.leadingAnchor.constraint(equalTo: noRatedBreweryTitleLabel.leadingAnchor),
            noRatedBreweryDescriptionLabel.trailingAnchor.constraint(equalTo: noRatedBreweryTitleLabel.trailingAnchor)
        ])
    }
    
    let noRatedBreweryTitleLabel: UILabel = {
       let noRatedBreweryTitleLabel = UILabel()
        noRatedBreweryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        noRatedBreweryTitleLabel.text = Constants.noResultTitle.localized
        noRatedBreweryTitleLabel.textAlignment = .center
        noRatedBreweryTitleLabel.font = UIFont(name: "Quicksand-Bold", size: 20)
        
        return noRatedBreweryTitleLabel
    }()
    
    let noRatedBreweryDescriptionLabel: UILabel = {
       let noRatedBreweryDescriptionLabel = UILabel()
        
        noRatedBreweryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        noRatedBreweryDescriptionLabel.text = Constants.noResultDescription.localized
        noRatedBreweryDescriptionLabel.textAlignment = .center
        noRatedBreweryDescriptionLabel.font = UIFont(name: "Quicksand-Regular", size: 16)
        noRatedBreweryDescriptionLabel.numberOfLines = 5
        
        return noRatedBreweryDescriptionLabel
    }()
    
    let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Constants.title.localized
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name: "Quicksand-Bold", size: 18)
        
        return titleLabel
    }()
    
    let resultLabel: UILabel = {
       let resultLabel = UILabel()
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        resultLabel.textAlignment = .left
        resultLabel.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return resultLabel
    }()
    
    let orderByLabel: UILabel = {
       let orderByLabel = UILabel()
        orderByLabel.translatesAutoresizingMaskIntoConstraints = false
        orderByLabel.textAlignment = .left
        orderByLabel.text = "\(Constants.orderByDescription.localized) \(Constants.orderByName.localized)"
        orderByLabel.font = UIFont(name: "Quicksand-Regular", size: 14)
        
        return orderByLabel
    }()
    
    let filterButton: UIButton = {
        let filterButton = UIButton()
        filterButton.translatesAutoresizingMaskIntoConstraints = false
        filterButton.setImage(UIImage.init(systemName: "text.append"), for: .normal)
        filterButton.tintColor = .black
        filterButton.addTarget(self, action: #selector(filterButtonClick), for: .touchUpInside)
        
        return filterButton
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    @objc func filterButtonClick() {
        let orderByModalViewController = OrderByModalViewController()
        let navigationViewController = UINavigationController(rootViewController: orderByModalViewController)
                
        navigationViewController.modalPresentationStyle = .pageSheet
        
        if let sheet = navigationViewController.sheetPresentationController {
            sheet.preferredCornerRadius = 16
            sheet.detents = [.medium()]
            orderByModalViewController.isOrderingByName = self.ratedBreweryViewModel.isOrderingByName
        }
        
        let exitButton = UIBarButtonItem(title: nil, image: UIImage(named: "closeButton-black")?.withTintColor(.black, renderingMode: .alwaysOriginal), primaryAction: .init(handler: { _ in
            
            navigationViewController.dismiss(animated: true, completion: nil)
        }))
        
        orderByModalViewController.navigationItem.rightBarButtonItem = exitButton
        
        orderByModalViewController.onUpdateBreweries = { [weak self] orderByName in
            self?.ratedBreweryViewModel.orderBreweries(byName: orderByName)
            navigationViewController.dismiss(animated: true, completion: nil)
        }
        
        present(navigationViewController, animated: true, completion: nil)
    }
}

extension RatedBreweryViewController {
    func ratedBackgroundComponent() {
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension RatedBreweryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RatedBreweryTableViewCell.identifier, for: indexPath) as! RatedBreweryTableViewCell
        cell.configureCell(with: self.ratedBreweryViewModel.ratedBreweries[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.ratedBreweryViewModel.ratedBreweries.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
