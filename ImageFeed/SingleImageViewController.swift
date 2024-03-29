import UIKit
import Kingfisher
import ProgressHUD

final class SingleImageViewController: UIViewController {
    
    var image: UIImage! {
        didSet {
            guard isViewLoaded else { return }
            imageView.image = image
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    
    var imageUrl: URL?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet private var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSingleImage()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        view.layoutIfNeeded()
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, max(hScale, vScale)))
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        let newContentSize = scrollView.contentSize
        let x = (newContentSize.width - visibleRectSize.width) / 2
        let y = (newContentSize.height - visibleRectSize.height) / 2
        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: false)
    }
    
    private func fetchSingleImage() {
        ProgressHUD.animate()
        imageView.kf.setImage(with: imageUrl) { [weak self] result in
            ProgressHUD.dismiss()
            guard let self = self else { return }
            switch result {
            case .success(let image):
                self.image = image.image
                self.rescaleAndCenterImageInScrollView(image: self.image)
            case .failure(let error):
                print("[fetchSingleImage]: \(error.localizedDescription)")
                self.showError()
            }
        }
    }
    
    private func showError() {
        let alertController = UIAlertController(
            title: "Что-то пошло не так.",
            message: "Попробовать ещё раз?",
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(
            title: "Не надо",
            style: .default
        )
        let action = UIAlertAction(
            title: "Повторить",
            style: .default
        ) { [weak self] _ in
            self?.fetchSingleImage()
        }
        alertController.addAction(action)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShareButton(_ sender: Any) {
        let shareImage = UIActivityViewController(
            activityItems: [image as Any],
            applicationActivities: nil
        )
        present(shareImage, animated: true)
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
