import UIKit
import Kingfisher
import WebKit

final class ProfileViewController: UIViewController {
    
    private let profilePhotoImageView = UIImageView()
    private let nameLabel = UILabel()
    private let nickNameLabel = UILabel()
    private let statusLabel = UILabel()
    private let logoutButton = UIButton.systemButton(with: UIImage(imageLiteralResourceName: "logoutButton"), target: nil, action: nil)
    private let profileService = ProfileService.shared
    private var profileImageServiceObserver: NSObjectProtocol?
    private var storage = OAuth2TokenStorage()
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        addObserver()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addObserver()
    }
    
    deinit {
        removeObserver()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        addProfilePhotoImageView()
        addNameLabel()
        addNickName()
        addStatus()
        addLogoutButton()
        
        guard let profile = profileService.profile else { return }
        updateProfileDetails(profile: profile)
        
        if let avatarURL = ProfileImageService.shared.avatarURL,
           let url = URL(string: avatarURL) {
            updateAvatar(url: url)
        }
        
        profileImageServiceObserver = NotificationCenter.default.addObserver(
            forName: ProfileImageService.didChangeNotification,
            object: nil,
            queue: .main) { [weak self] notification in
                self?.updateAvatar(notification: notification)
            }
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateAvatar(notification:)),
            name: ProfileImageService.didChangeNotification,
            object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(
        self,
        name: ProfileImageService.didChangeNotification,
        object: nil)
    }
    
    @objc
    private func updateAvatar(notification: Notification) {
        guard
            isViewLoaded,
            let userInfo = notification.userInfo,
            let profileImageURL = userInfo["URL"] as? String,
            let url = URL(string: profileImageURL)
        else { return }
        let processor = RoundCornerImageProcessor(cornerRadius: 35, backgroundColor: .clear)
        profilePhotoImageView.kf.indicatorType = .activity
        profilePhotoImageView.kf.setImage(with: url,
                                          placeholder: UIImage(systemName: "person.crop.circle.fill"),
                                          options: [.processor(processor),
                                                    .cacheSerializer(FormatIndicatedCacheSerializer.png)]) {result in
                                                        switch result {
                                                        case.success(let value):
                                                            print(value.image)
                                                            print(value.cacheType)
                                                            print(value.source)
                                                        case .failure(let error):
                                                            print(error)
                                                        }
                                                    }
    }
    
    private func updateAvatar(url: URL) {
        profilePhotoImageView.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 35)
        profilePhotoImageView.kf.setImage(with: url, options: [.processor(processor)])
    }
    
    private func addProfilePhotoImageView() {
        profilePhotoImageView.image = UIImage(named: "avatar")
        profilePhotoImageView.layer.cornerRadius = 35
        profilePhotoImageView.clipsToBounds = true
        
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
        logoutButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        logoutButton.tintColor = UIColor(named: "YP Red")
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoutButton)
        
        logoutButton.widthAnchor.constraint(equalToConstant: 48).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 48).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor).isActive = true
    }
    
    private func updateProfileDetails(profile: Profile) {
        self.nameLabel.text = profile.name
        self.nickNameLabel.text = profile.userName
        self.statusLabel.text = profile.bio
        
    }
    
    @objc
    private func didTapButton() {
        self.exitAlert()
    }
    
    private func exitAlert() {
        let alertController = UIAlertController(title: "Пока, пока!",
                                                message: "Уверены, что хотите выйти?",
                                                preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Нет",
                                   style: .cancel)
        let action = UIAlertAction(title: "Да",
                                   style: .default) { _ in
            self.cleanToken()
            self.cleanCookies()
            self.cleanUserData()
            self.goToSplashViewController()
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
}

extension ProfileViewController {
    private func cleanToken() {
        storage.removeToken()
    }
    
    private func cleanCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) {
            records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }
    
    private func cleanUserData() {
        self.nameLabel.text = "Name"
        self.nickNameLabel.text = "@name"
        self.statusLabel.text = "bio"
        self.profilePhotoImageView.image = UIImage(named: "Avatar")
        ImagesListService.shared.deletePhotos()
    }
    
    private func goToSplashViewController() {
        guard let window = UIApplication.shared.windows.first else { preconditionFailure("Invalid Configuration") }
        window.rootViewController = SplashViewController()
    }
}
