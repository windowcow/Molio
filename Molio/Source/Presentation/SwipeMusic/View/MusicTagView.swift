import UIKit

final class MusicTagView: UIView {
    
    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(tagTitle: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayer()
        setupHierarchy()
        setupConstraint()
        tagTitleLabel.molioMedium(text: tagTitle, size: 14)
        self.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayer()
        setupHierarchy()
        setupConstraint()
    }
    
    private func setupLayer() {
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    private func setupHierarchy() {
        addSubview(tagTitleLabel)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            tagTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            tagTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            tagTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 18),
            tagTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18)
        ])
    }
}
