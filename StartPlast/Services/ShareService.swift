//
//  ShareService.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class ShareService {
    
    weak var delegate: UIViewController?
    static let size = CGSize(width: 375, height: 375)
    
    func share(cardModel: CardModel, numberOfCards: Int) {
        let storyboard = UIStoryboard(name: "CarouselStoryboard", bundle: nil)
        if let shareController = storyboard.instantiateViewController(
            withIdentifier: "ShareProgressCard") as? ShareProgressCardController {
            shareController.configure(cardModel: cardModel, numberOfCards: numberOfCards)
            shareController.view.frame = CGRect(origin: .zero, size: ShareService.size)
            shareController.view.layoutIfNeeded()
            let image = shareController.view.asImage
            
            share(image: image, text:  "Мій наступний крок на шляху пластуна.")
        }
    }
    
    private func share(image: UIImage, text: String) {
        let activityViewController = UIActivityViewController(activityItems: [image, text],
                                                              applicationActivities: nil)
        
        delegate?.present(activityViewController, animated: true, completion: nil)
    }
}
