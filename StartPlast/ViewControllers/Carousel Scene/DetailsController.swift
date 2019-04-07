//
//  DetailsController.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var cardModel: CardModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @IBAction func onCloseAction(_ sender: UIButton) {
        dismiss()
    }
    
    @IBAction func onDoneAction(_ sender: UIButton) {
        // TODO: Add hud
        ProfileDataService.shared.incrementCurrentCardIndex() { [weak self] result in
            switch result {
            case .success: self?.dismiss()
            case .failure(let err): self?.showAlert(with: err)
            }
        }
    }
    
    private func configureUI() {
        imageView.image = UIImage(named: "card-\(cardModel.index)")
        titleLabel.text = cardModel.title
        descriptionLabel.text = cardModel.description
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
        doneButton.isHidden = cardModel.state == .done
    }
    
    private func showAlert(with err: Error) {
        let controller = UIAlertController(
            title: "Помилка",
            message: "\(err.localizedDescription).",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.dismiss()
        }))
    }
    
    private func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
