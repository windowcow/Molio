import UIKit

final class CircleMenuButton: UIButton {
    
    private let buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(type: MenuButtonType) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView(type: type)
        setupHierarchy()
        setupConstraint(type: type)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(type: MenuButtonType) {
        backgroundColor = .black.withAlphaComponent(0.3)
        layer.cornerRadius = type.buttonSize / 2
        clipsToBounds = true
        buttonImageView.image = type.buttonImage
    }
    
    private func setupHierarchy() {
        addSubview(buttonImageView)
    }
    
    private func setupConstraint(type: MenuButtonType) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: type.buttonSize),
            self.heightAnchor.constraint(equalToConstant: type.buttonSize)
        ])
        
        NSLayoutConstraint.activate([
            buttonImageView.widthAnchor.constraint(equalToConstant: type.buttonImageSize.width),
            buttonImageView.heightAnchor.constraint(equalToConstant: type.buttonImageSize.height),
            buttonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}

extension CircleMenuButton {
    
    enum MenuButtonType {
        case filter
        case dislike
        case like
        case myMolio
        
        var buttonSize: CGFloat {
            switch self {
            case .filter:
                return 58.0
            case .dislike:
                return 66.0
            case .like:
                return 66.0
            case .myMolio:
                return 58.0
            }
        }
        
        var buttonImage: UIImage {
            switch self {
            case .filter:
                return UIImage(resource: .personFill)
            case .dislike:
                return UIImage(resource: .xmark)
            case .like:
                return UIImage(resource: .heartFill)
            case .myMolio:
                return UIImage(resource: .musicNote)
            }
        }
        
        var buttonImageSize: (width: CGFloat, height: CGFloat) {
            switch self {
            case .filter:
                return (21.0, 19.0)
            case .dislike:
                return (25.0, 29.0)
            case .like:
                return (30.0, 29.0)
            case .myMolio:
                return (18.0, 24.0)
            }
        }
    }
}
