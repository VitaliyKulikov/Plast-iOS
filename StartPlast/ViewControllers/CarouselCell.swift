//
//  CarouselCell.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class CarouselCell: UICollectionViewCell {

    @IBOutlet weak var dashLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var dashLineLabel: UILabel!
    @IBOutlet weak var cardIdButton: UIButton!
    @IBOutlet weak var cardView: RoundShadowView!
    
    @IBOutlet weak var taskIdentifierLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var generalImageView: UIImageView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var cardDescriptionLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardIdButton.layer.cornerRadius = cardIdButton.bounds.width / 2
    }
    
    func configure(with model: CardModel) {
        cardIdButton.setTitle("\(model.id + 1)", for: .normal)
        coinsLabel.text = "+ \(model.plastCoins) пласткоїнів"
        generalImageView.image = UIImage(named: "card-\(model.iconId)")
        cardTitleLabel.text = model.title
        cardDescriptionLabel.text = model.description
        dashLeadingConstraint.constant = model.id == 0 ? 10 : 0
        detailsButton.layer.cornerRadius = detailsButton.bounds.height / 2
        
        switch model.state {
        case .locked: lockImageView.image = UIImage(named: "locked")
        case .unlocked: lockImageView.image = UIImage(named: "unlocked")
        default: lockImageView.image = UIImage(named: "medal")
        }
    }
}
