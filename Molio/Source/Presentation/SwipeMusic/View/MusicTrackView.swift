import UIKit

final class MusicTrackView: UIView {
    
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemPink
        return imageView
    }()
    
    private let songTitleLabel: UILabel = {
        let label = UILabel()
        label.molioExtraBold(text: "APT.", size: 48) // TODO: 서버 연결시 text 제거
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.molioMedium(text: "로제 & Bruno Mars", size: 20) // TODO: 서버 연결시 text 제거
        label.textColor = .white.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupShadow()
        setupHierarchy()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
        setupHierarchy()
        setupConstraint()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 26
        layer.shadowOpacity = 0.36
    }
    
    private func setupGenre(_ genres: [String]) {
        genreStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        genres.forEach { genre in
            let genreTagView = MusicTagView(tagTitle: genre, backgroundColor: .black.withAlphaComponent(0.3))
            genreStackView.addArrangedSubview(genreTagView)
        }
    }
    
    private func setupHierarchy() {
        addSubview(albumImageView)
        addSubview(songTitleLabel)
        addSubview(artistNameLabel)
        addSubview(genreStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            albumImageView.topAnchor.constraint(equalTo: self.topAnchor),
            albumImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            albumImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            songTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -121),
            songTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            artistNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -92),
            artistNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28)
        ])
        
        NSLayoutConstraint.activate([
            genreStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -34),
            genreStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28)
        ])
    }
}
