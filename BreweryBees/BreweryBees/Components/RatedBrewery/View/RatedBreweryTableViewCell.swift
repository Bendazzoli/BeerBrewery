//
//  RatedBreweryTableViewCell.swift
//  BreweryBees
//
//  Created by Paulo Henrique Bendazzoli on 02/03/22.
//

import UIKit
import Cosmos

class RatedBreweryTableViewCell: UITableViewCell {

    @IBOutlet weak var breweryImage: UIImageView!
    @IBOutlet weak var breweryLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var backgroundViewCell: UIView!
    
    static let identifier = "RatedBreweryTableViewCell"
    public var breweries = BreweryDefaultModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        breweryImage.layer.cornerRadius = breweryImage.frame.height / 2
        
        backgroundViewCell.layer.cornerRadius = 8
        backgroundColor = UIColor.clear
        
        addSubview(cosmosView)
        NSLayoutConstraint.activate([
            cosmosView.topAnchor.constraint(equalTo: breweryLabel.bottomAnchor, constant: 5),
            cosmosView.leadingAnchor.constraint(equalTo: rateLabel.trailingAnchor, constant: 5)
        ])
    }
    
    lazy var cosmosView: CosmosView = {
        var cosmos = CosmosView()
        cosmos.settings.starSize = 16
        cosmos.isUserInteractionEnabled = false
        cosmos.translatesAutoresizingMaskIntoConstraints = false
        cosmos.settings.filledImage?.value(forKey: "5")
        return cosmos
    }()
    
    func configureCell(with breweryDefaultModel: BreweryDefaultModel) {//model of data
        self.breweries = breweryDefaultModel
        
        breweryLabel.text = breweries.name
        guard let rating = breweries.average else { return }
        rateLabel.text = "\(String(describing: rating))"
        cosmosView.rating = rating
        
        let givenString = breweries.name ?? ""
        if var firstChar = givenString.first{
            firstChar = Character(firstChar.lowercased())
            if breweries.photos?[0] != nil {
                breweryImage.sd_setImage(with: URL(string: breweries.photos?[0] ?? ""))
            } else {
                breweryImage.image = UIImage(systemName: "\(firstChar).circle")
            }
        }
    }
}
