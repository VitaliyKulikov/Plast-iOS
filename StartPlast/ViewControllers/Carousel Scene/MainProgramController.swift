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
    
    @IBOutlet weak var carouselContainerView: UIView!
    @IBOutlet weak var topPanelView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    var profileModel: ProfileModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
            controller.onDetails = { [weak self] model in
                self?.performSegue(withIdentifier: MainProgramController.kDetailsId, sender: model)
            }
        }
    }
}

