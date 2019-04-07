//
//  MainProgramController.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/6/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit
import Kingfisher

class MainProgramController: UIViewController {
    
    private static let kDetailsId = "DetailsIdentifier"
    private static let kCarousel = "CarouselIdentifier"
    private static let kProfileId = "ProfileIdentifier"
    
    @IBOutlet weak var carouselContainerView: UIView!
    @IBOutlet weak var topPanelView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileModel: ProfileModel!
    var shareService: ShareService!
    private var stepsCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        shareService = ShareService()
        shareService.delegate = self
        
        topPanelView.addGestureRecognizer(UITapGestureRecognizer(
            target: self, action: #selector(onProfileAction)))
    }
    
    @objc func onProfileAction() {
        performSegue(withIdentifier: MainProgramController.kProfileId, sender: nil)
    }
    
    private func configureUI() {
        profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
        profileImageView.image = UIImage(named: "avatar-default")
        profileImageView.kf.setImage(with: profileModel.avatarUrl)
        usernameLabel.text = profileModel.username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MainProgramController.kDetailsId,
            let controller = segue.destination as? DetailsController,
            let model = sender as? CardModel {
            controller.cardModel = model
            
        } else if segue.identifier == MainProgramController.kCarousel,
            let controller = segue.destination as? CarouselController {
            controller.onDetails = { [weak self] model, count in
                self?.performSegue(withIdentifier: MainProgramController.kDetailsId, sender: model)
            }
            controller.onShare = { [weak self] cardModel, count in
                self?.shareService.share(cardModel: cardModel, numberOfCards: count)
            }
        } else if segue.identifier == MainProgramController.kProfileId,
            let controller = segue.destination as? ProfileController {
            controller.countSteps = 12
        }
    }
}

