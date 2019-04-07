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
    
    var onDetails: ((CardModel, Int) -> Void)?
    var cardModels = [CardModel]()
    var onShare: ((CardModel, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateContent()
    }
    
    private func updateContent() {
        CardsDataService.shared.get() { [weak self] models in
            DispatchQueue.main.async {
                self?.cardModels = models
                self?.collectionView.reloadData()
                if models.count > 0 {
                    self?.collectionView.scrollToItem(
                        at: IndexPath(item: self?.cardModels.firstIndex(where: {
                        $0.state == .current
                        }) ?? 0, section: 0), at: .left, animated: true)
                }
            }
        }
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
        cell.onShare = { [weak self] in
            guard let this = self  else { return }
            this.onShare?(this.cardModels[indexPath.row], this.cardModels.count)
        }
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
            onDetails?(cardModels[indexPath.row], cardModels.count)
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
