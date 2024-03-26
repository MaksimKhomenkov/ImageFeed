import UIKit
import Kingfisher

protocol ImagesListCellDelegate: AnyObject {
    func imagesListCellDidTapLike(_ cell: ImagesListCell)
}

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    weak var delegate: ImagesListCellDelegate?
    @IBOutlet private var cellImage: UIImageView!
    @IBOutlet private var likeButton: UIButton!
    @IBOutlet private var dateLabel: UILabel!
   
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    func setImage(url: String) {
        guard let url = URL(string: url) else { return }
        cellImage.kf.indicatorType = .activity
        self.cellImage.kf.setImage(with: url, placeholder: UIImage(named: "Stub"))
    }
    
    func setIsLiked(_ curentLike: Bool) {
        likeButton.setImage(UIImage(named: curentLike ? "LikeButtonActive" : "LikeButtonNoActive"), for: .normal)
    }
    
    func configure(dateText: String, isLiked: Bool) {
        self.dateLabel.text = dateText
        let likeImage = isLiked ? UIImage(named: "LikeButtonActive") : UIImage(named: "LikeButtonNoActive")
        self.likeButton.setImage(likeImage, for: .normal)
    }
    
    @IBAction private func likeButtonTap(_ sender: Any) {
        delegate?.imagesListCellDidTapLike(self)
    }
}
