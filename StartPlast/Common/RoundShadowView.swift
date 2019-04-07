//
//  RoundShadowView.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class RoundShadowView: UIView {
    
    private var shadowLayer: CAShapeLayer!
    internal var cornerRadius: CGFloat = 14
    private var fillColor: UIColor = .white
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.fillColor = fillColor.cgColor
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 12)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 8
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
}
