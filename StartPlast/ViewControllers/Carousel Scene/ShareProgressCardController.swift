//
//  ShareProgressCardController.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class ShareProgressCardController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cardIndex: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    func configure(cardModel: CardModel, numberOfCards: Int) {
        view.layoutIfNeeded()
        descriptionLabel.text = cardModel.description
        cardIndex.text = "\(cardModel.index + 1)/\(numberOfCards)"
    }
}
