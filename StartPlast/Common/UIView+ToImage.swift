//
//  UIView+ToImage.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

extension UIView {

    var asImage: UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
