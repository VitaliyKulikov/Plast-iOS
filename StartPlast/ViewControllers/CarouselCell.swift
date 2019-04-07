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
    @IBOutlet weak var inactiveView: UIView!
    
    private static let kCardCornerRadius: CGFloat = 14
    var  onShare: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardIdButton.layer.cornerRadius = cardIdButton.bounds.width / 2
        cardView.cornerRadius = CarouselCell.kCardCornerRadius
        inactiveView.layer.cornerRadius = CarouselCell.kCardCornerRadius
        detailsButton.layer.cornerRadius = detailsButton.bounds.height / 2
    }
    
    func configure(with model: CardModel) {
        coinsLabel.text = "+ \(model.plastCoins) пласткоїнів"
        taskIdentifierLabel.text = "Завдання \(model.index + 1)"
        generalImageView.image = UIImage(named: "card-\(model.index)")
        cardTitleLabel.text = model.title
        cardDescriptionLabel.text = model.description
        dashLeadingConstraint.constant = model.index == 0 ? 10 : 0
        cardIdButton.backgroundColor = model.state == .locked ? #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1) : #colorLiteral(red: 0.3411764706, green: 0.7215686275, blue: 0.5803921569, alpha: 1)
        cardIdButton.setTitle(model.state == .done ? "✔︎" : "\(model.index + 1)", for: .normal)
        inactiveView.alpha = model.state == .locked ? 1 : 0
        detailsButton.setTitle(model.state == .done ? "Поширити" : "Розпочати", for: .normal)
        detailsButton.isUserInteractionEnabled = model.state == .done
        
        switch model.state {
        case .locked: lockImageView.image = UIImage(named: "locked")
        case .current: lockImageView.image = UIImage(named: "unlocked")
        default: lockImageView.image = UIImage(named: "medal")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coinsLabel.text = "-/-"
        generalImageView.image = nil
        cardTitleLabel.text = "-/-"
        cardDescriptionLabel.text = "-/-"
        dashLeadingConstraint.constant = 0
        cardIdButton.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
        cardIdButton.setTitle("", for: .normal)
        inactiveView.alpha = 1
        detailsButton.setTitle("Розпочати", for: .normal)
        lockImageView.image = UIImage(named: "locked")
    }
    
    @IBAction func onDetailsButton(_ sender: UIButton) {
        onShare?()
    }
}
