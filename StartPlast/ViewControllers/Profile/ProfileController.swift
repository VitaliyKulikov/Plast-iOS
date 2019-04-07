//
//  ProfileController.swift
//  StartPlast
//
//  Created by Kristina Del Rio Albrechet on 4/7/19.
//  Copyright © 2019 Plast. All rights reserved.
//

import UIKit
import Kingfisher
import MessageUI
import FirebaseAuth
import GoogleSignIn

class ProfileController: UITableViewController {

    private static var kStepCellId = "StepCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var coinscount: UILabel!
    @IBOutlet weak var usernmeLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var mountainsImageView: UIImageView!
    
    @IBOutlet weak var contactUsCell: UITableViewCell!
    @IBOutlet weak var crossButton: UIButton!
    @IBOutlet weak var logoutCell: UITableViewCell!
    
    var profile: ProfileModel!
    var countSteps: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stupDefault()
        ProfileDataService.shared.getCurrentProfile { (result) in
            if case let ProfileDataService.Result<ProfileModel>.success(model) = result {
                DispatchQueue.main.async { [weak self] in
                    self?.profile = model
                    self?.configureUI()
                }
            }
        }
    }
    
    @IBAction func onCloseAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func stupDefault() {
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        tableView.tableFooterView = UIView()
        avatarImageView.image = UIImage(named: "avatar-default")
        coinscount.text = "-- пластокоїнів"
        usernmeLabel.text = "--"
    }
    
    
    private func configureUI() {
        coinscount.text = "\(profile.coins) пластокоїнів"
        usernmeLabel.text = profile.username
        avatarImageView.kf.setImage(with: profile.avatarUrl)
        collectionView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            if !MFMailComposeViewController.canSendMail() {
                return
            }
            sendEmail()
        case 2:
            if let nav = presentingViewController as? UINavigationController {
                GIDSignIn.sharedInstance()?.signOut()
                do {
                    try Auth.auth().signOut()
                } catch {
                    print(error)
                }
                nav.popToRootViewController(animated: false)
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
}

extension ProfileController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return profile == nil ? 0 : countSteps
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            ProfileController.kStepCellId, for: indexPath) as? StepCell else {
                fatalError("Cannot create cell with identifier ProfileCell.")
        }
        cell.configure(step: indexPath.row + 1,
                       isDone: indexPath.row <= profile.currentStep)
        return cell
    }
}

extension ProfileController: MFMailComposeViewControllerDelegate {
    
    func sendEmail() {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients(["plast@gmail.com"])
        composeVC.setSubject("Повідомлення")
        composeVC.setMessageBody("Скоб!", isHTML: false)
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
