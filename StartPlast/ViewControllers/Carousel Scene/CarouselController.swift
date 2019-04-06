//
//  CarouselController.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class CarouselController: UIViewController {

    static private let kCarouselCellId = "CarouselCell"
    static fileprivate let kCellSpacing: CGFloat = 10
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var onDetails: ((CardModel) -> Void)?
    var cardModels = [CardModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent()
    }
    
    private func updateContent() {
        // FIXME: Delete hard-coded values with method from CardModelService.
        cardModels = [
            CardModel(id: 0, stateId: 3, iconId: 0, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(id: 1, stateId: 2, iconId: 1, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(id: 2, stateId: 1, iconId: 2, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse."),
            CardModel(id: 3, stateId: 1, iconId: 2, plastCoins: 10, title: "First card", description: "This invitation was intended for kalbrechet@gmail.com. If you were not expecting this invitation, you can ignore this email. If @VitaliyKulikov is sending you too many emails, you can block them or report abuse.")
        ]
        collectionView.reloadData()
    }
}

extension CarouselController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            CarouselController.kCarouselCellId, for: indexPath) as? CarouselCell else {
                fatalError("Cannot find cell with identifier.")
        }
        cell.configure(with: cardModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cardModels.count
    }
}

extension CarouselController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
    
        if cardModels[indexPath.row].state != .locked {
            onDetails?(cardModels[indexPath.row])
        }
    }
}

extension CarouselController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
