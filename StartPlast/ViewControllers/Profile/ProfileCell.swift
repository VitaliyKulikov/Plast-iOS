//
//  StepCell.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class StepCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        button.layer.cornerRadius = button.bounds.width / 2
        button.isUserInteractionEnabled = false
    }
    
    func configure(step: Int, isDone: Bool) {
        button.setTitle("\(step)", for: .normal)
        button.backgroundColor = isDone ? #colorLiteral(red: 0.3411764706, green: 0.7215686275, blue: 0.5803921569, alpha: 1) : #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setTitle("", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
    }
}
