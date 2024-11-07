import UIKit

final class SwipeMusicViewController: UIViewController {
    
    private let musicTrackView = MusicTrackView()
    private let filterButton = CircleMenuButton(type: .filter)
    private let dislikeButton = CircleMenuButton(type: .dislike)
    private let likeButton = CircleMenuButton(type: .like)
    private let myMolioButton = CircleMenuButton(type: .myMolio)
    
    private let playlistSelectButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = .black.withAlphaComponent(0.3)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let selectedPlaylistTitleLabel: UILabel = {
        let label = UILabel()
        label.molioMedium(text: "🎧카공할 때 듣는 플리", size: 16) // TODO: 서버 연결시 text 제거
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playlistSelectArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .chevronDown)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white // TODO: 앨범의 배경색으로 지정된 이후 삭제
        setupHierarchy()
        setupConstraint()
    }
    
    private func setupHierarchy() {
        view.addSubview(playlistSelectButton)
        view.addSubview(selectedPlaylistTitleLabel)
        view.addSubview(playlistSelectArrowImageView)
        view.addSubview(musicTrackView)
        view.addSubview(menuStackView)
        
        menuStackView.addArrangedSubview(filterButton)
        menuStackView.addArrangedSubview(dislikeButton)
        menuStackView.addArrangedSubview(likeButton)
        menuStackView.addArrangedSubview(myMolioButton)
    }
    
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            playlistSelectButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            playlistSelectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playlistSelectButton.widthAnchor.constraint(equalToConstant: 192),
            playlistSelectButton.heightAnchor.constraint(equalToConstant: 39)
        ])
        
        NSLayoutConstraint.activate([
            selectedPlaylistTitleLabel.leadingAnchor.constraint(
                equalTo: playlistSelectButton.leadingAnchor, constant: 15),
            selectedPlaylistTitleLabel.centerYAnchor.constraint(equalTo: playlistSelectButton.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            playlistSelectArrowImageView.leadingAnchor.constraint(
                equalTo: selectedPlaylistTitleLabel.trailingAnchor, constant: 10),
            playlistSelectArrowImageView.trailingAnchor.constraint(
                equalTo: playlistSelectButton.trailingAnchor, constant: -15),
            playlistSelectArrowImageView.centerYAnchor.constraint(equalTo: playlistSelectButton.centerYAnchor),
            playlistSelectArrowImageView.widthAnchor.constraint(equalToConstant: 18),
            playlistSelectArrowImageView.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        NSLayoutConstraint.activate([
            musicTrackView.topAnchor.constraint(equalTo: playlistSelectButton.bottomAnchor, constant: 12),
            musicTrackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            musicTrackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            musicTrackView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -107)
        ])
        
        NSLayoutConstraint.activate([
            menuStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22)
        ])
    }
}
