import UIKit

final class ProfileViewController: UIViewController {
    
    private let profilePhotoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let statusLabel = UILabel()
    private let logoutButton = UIButton.systemButton(
        with: UIImage(imageLiteralResourceName: "logoutButton"),
        target: ProfileViewController.self,
        action: #selector(Self.didTapButton)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        addProfilePhotoImageView()
        addNameLabel()
        addNickName()
        addStatus()
        addLogoutButton()
    }
    
    private func addProfilePhotoImageView() {
        profilePhotoImageView.image = UIImage(named: "avatar")
        
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePhotoImageView)
        
        profilePhotoImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profilePhotoImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profilePhotoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        profilePhotoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
    }
    
    private func addNameLabel() {
        nameLabel.text = "Екатерина Новикова"
        nameLabel.textColor = UIColor(named: "YP White")
        nameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.bottomAnchor, constant: 8).isActive = true
    }
    
    private func addNickName() {
        nickNameLabel.text = "@ekaterina_nov"
        nickNameLabel.textColor = UIColor(named: "YP Gray")
        nickNameLabel.font = nickNameLabel.font.withSize(13)
        
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nickNameLabel)
        
        nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        nickNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func addStatus() {
        statusLabel.text = "Hello, world!"
        statusLabel.textColor = UIColor(named: "YP White")
        statusLabel.font = statusLabel.font.withSize(13)
        
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        statusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        statusLabel.topAnchor.constraint(equalTo: nickNameLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    private func addLogoutButton() {
        logoutButton.tintColor = UIColor(named: "YP Red")
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor).isActive = true
    }
    
    @objc
    private func didTapButton() {
//        TODO
    }
}
