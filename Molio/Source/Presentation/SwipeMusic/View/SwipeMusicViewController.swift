import UIKit
import Combine

final class SwipeMusicViewController: UIViewController {
    private let viewModel: SwipeMusicViewModel
    private var input: SwipeMusicViewModel.Input
    private var output: SwipeMusicViewModel.Output
    private let viewDidLoadPublisher = PassthroughSubject<Void, Never>()
    private let musicCardDidChangeSwipePublisher = PassthroughSubject<CGFloat, Never>()
    private let musicCardDidFinishSwipePublisher = PassthroughSubject<CGFloat, Never>()
    private let likeButtonDidTapPublisher = PassthroughSubject<Void, Never>()
    private let dislikeButtonDidTapPublisher = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    private let basicBackgroundColor = UIColor(resource: .background)
    private var impactFeedBack = UIImpactFeedbackGenerator(style: .medium)
    private var hasProvidedImpactFeedback: Bool = false
    
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
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "chevron.down")
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
    
    private let musicCardView = MusicCardView()
    
    private let filterButton = CircleMenuButton(backgroundColor: .black.withAlphaComponent(0.51),
                                                highlightColor: .white.withAlphaComponent(0.51),
                                                buttonSize: 58.0,
                                                tintColor: .white,
                                                buttonImage: UIImage(systemName: "slider.horizontal.3"),
                                                buttonImageSize: CGSize(width: 21.0, height: 19.0))
    
    private let dislikeButton = CircleMenuButton(backgroundColor: .black.withAlphaComponent(0.51),
                                                 highlightColor: .white.withAlphaComponent(0.51),
                                                 buttonSize: 66.0,
                                                 tintColor: UIColor(hex: "#FF3D3D"),
                                                 buttonImage: UIImage(systemName: "xmark"),
                                                 buttonImageSize: CGSize(width: 25.0, height: 29.0))
    
    private let likeButton = CircleMenuButton(backgroundColor: .black.withAlphaComponent(0.51),
                                              highlightColor: .white.withAlphaComponent(0.51),
                                              buttonSize: 66.0,
                                              tintColor: UIColor(resource: .main),
                                              buttonImage: UIImage(systemName: "heart.fill"),
                                              buttonImageSize: CGSize(width: 30.0, height: 29.0))
    
    private let myMolioButton = CircleMenuButton(backgroundColor: .black.withAlphaComponent(0.51),
                                                 highlightColor: .white.withAlphaComponent(0.51),
                                                 buttonSize: 58.0,
                                                 tintColor: UIColor(hex: "#FFFAFA"),
                                                 buttonImage: UIImage(systemName: "music.note"),
                                                 buttonImageSize: CGSize(width: 18.0, height: 24.0))
    
    init(viewModel: SwipeMusicViewModel) {
        self.viewModel = viewModel
        self.input = SwipeMusicViewModel.Input(
            viewDidLoad: viewDidLoadPublisher.eraseToAnyPublisher(),
            musicCardDidChangeSwipe: musicCardDidChangeSwipePublisher.eraseToAnyPublisher(),
            musicCardDidFinishSwipe: musicCardDidFinishSwipePublisher.eraseToAnyPublisher(),
            likeButtonDidTap: likeButtonDidTapPublisher.eraseToAnyPublisher(),
            dislikeButtonDidTap: dislikeButtonDidTapPublisher.eraseToAnyPublisher()
        )
        self.output = viewModel.transform(from: input)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let defaultNetworkProvider = DefaultNetworkProvider()
        let defaultSpotifyTokenProvider = DefaultSpotifyTokenProvider(networkProvider: defaultNetworkProvider)
        let defaultSpotifyAPIService = DefaultSpotifyAPIService(networkProvider: defaultNetworkProvider,
                                                                tokenProvider: defaultSpotifyTokenProvider
        )
        let defaultMusicKitService = DefaultMusicKitService()
        let defaultMusicRepository = DefaultMusicRepository(
            spotifyAPIService: defaultSpotifyAPIService,
            musicKitService: defaultMusicKitService
        )
        let defaultFetchMusicsUseCase = DefaultFetchMusicsUseCase(repository: defaultMusicRepository)
        let defaultImageProvider = DefaultImageFetchService()
        let defaultImageRepository = DefaultImageRepository(imageFetchService: defaultImageProvider)
        let defaultFetchImageUseCase = DefaultFetchImageUseCase(repository: defaultImageRepository)
        let swipeMusicViewModel = SwipeMusicViewModel(fetchMusicsUseCase: defaultFetchMusicsUseCase,
                                                      fetchImageUseCase: defaultFetchImageUseCase
        )
        self.viewModel = swipeMusicViewModel
        self.input = SwipeMusicViewModel.Input(
            viewDidLoad: viewDidLoadPublisher.eraseToAnyPublisher(),
            musicCardDidChangeSwipe: musicCardDidChangeSwipePublisher.eraseToAnyPublisher(),
            musicCardDidFinishSwipe: musicCardDidFinishSwipePublisher.eraseToAnyPublisher(),
            likeButtonDidTap: likeButtonDidTapPublisher.eraseToAnyPublisher(),
            dislikeButtonDidTap: dislikeButtonDidTapPublisher.eraseToAnyPublisher()
        )
        self.output = viewModel.transform(from: input)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = basicBackgroundColor
        setupSelectPlaylistView()
        setupMusicTrackView()
        setupMenuButtonView()
        
        setupBindings()
        setupButtonTarget()
        addPanGestureToMusicTrack()
        
        viewDidLoadPublisher.send()
    }
    
    private func setupBindings() {
        output.currentMusicTrack
            .receive(on: RunLoop.main)
            .sink { [weak self] music in
                guard let self else { return }
                let artworkBackgroundColor = music.artworkBackgroundColor
                    .flatMap { UIColor(rgbaColor: $0) } ?? self.basicBackgroundColor
                view.backgroundColor = artworkBackgroundColor
                musicCardView.configure(music: music)
            }.store(in: &cancellables)
        
        output.buttonHighlight
            .receive(on: RunLoop.main)
            .sink { [weak self] buttonHighlight in
                guard let self else { return }
                self.likeButton.isHighlighted = buttonHighlight.isLikeHighlighted
                self.dislikeButton.isHighlighted = buttonHighlight.isDislikeHighlighted
            }
            .store(in: &cancellables)
        
        output.musicCardSwipeAnimation
            .receive(on: RunLoop.main)
            .sink { [weak self] swipeDirection in
                guard let self else { return }
                self.animateMusicCard(direction: swipeDirection)
            }
            .store(in: &cancellables)
    }
    
    /// Swipe 동작이 끝나고 MusicCard가 animation되는 메서드
    private func animateMusicCard(direction: SwipeMusicViewModel.SwipeDirection) {
        let currentCenter = musicCardView.center
        let viewCenter = view.center
        let frameWidth = view.frame.width
        
        switch direction {
        case .left, .right:
            let movedCenterX = currentCenter.x + direction.rawValue * frameWidth
            UIView.animate(
                withDuration: 0.3,
                animations: { [weak self] in
                    self?.musicCardView.center = CGPoint(x: movedCenterX, y: currentCenter.y)
                },
                completion: { [weak self] _ in
                self?.refreshMusicCardView()
            })
        case .none:
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.musicCardView.center = viewCenter
            }
        }
    }
    
    /// Music Card가 다시 refresh되는 메서드
    private func refreshMusicCardView() {
        self.musicCardView.removeFromSuperview()
        self.setupMusicTrackView()
    }
    
    private func addPanGestureToMusicTrack() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        musicCardView.addGestureRecognizer(panGesture)
    }
    
    private func setupButtonTarget() {
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        dislikeButton.addTarget(self, action: #selector(didTapDislikeButton), for: .touchUpInside)
    }
    
    /// 사용자에게 진동 feedback을 주는 메서드
    private func providedImpactFeedback(translationX: CGFloat) {
        if abs(translationX) > viewModel.swipeThreshold && !hasProvidedImpactFeedback {
            impactFeedBack.impactOccurred()
            hasProvidedImpactFeedback = true
        } else if abs(translationX) <= viewModel.swipeThreshold {
            hasProvidedImpactFeedback = false
        }
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let card = gesture.view else { return }
        
        let translation = gesture.translation(in: view)
        card.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        
        if gesture.state == .changed {
            musicCardDidChangeSwipePublisher.send(translation.x)
            providedImpactFeedback(translationX: translation.x)
        } else if gesture.state == .ended {
            musicCardDidFinishSwipePublisher.send(translation.x)
        }
    }
    
    @objc private func didTapLikeButton() {
        likeButtonDidTapPublisher.send()
    }
    
    @objc private func didTapDislikeButton() {
        dislikeButtonDidTapPublisher.send()
    }
    
    private func setupSelectPlaylistView() {
        view.addSubview(playlistSelectButton)
        view.addSubview(selectedPlaylistTitleLabel)
        view.addSubview(playlistSelectArrowImageView)
        
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
    }
    
    private func setupMusicTrackView() {
        view.addSubview(musicCardView)
        
        NSLayoutConstraint.activate([
            musicCardView.topAnchor.constraint(equalTo: playlistSelectButton.bottomAnchor, constant: 12),
            musicCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            musicCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
            musicCardView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -107)
        ])
    }
    
    private func setupMenuButtonView() {
        view.addSubview(menuStackView)
        menuStackView.addArrangedSubview(filterButton)
        menuStackView.addArrangedSubview(dislikeButton)
        menuStackView.addArrangedSubview(likeButton)
        menuStackView.addArrangedSubview(myMolioButton)
        
        NSLayoutConstraint.activate([
            menuStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22)
        ])
    }
}

// SwiftUI에서 SwipeViewController 미리보기
import SwiftUI
struct SwipeViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SwipeMusicViewController {
        let defaultNetworkProvider = DefaultNetworkProvider()
        let defaultSpotifyTokenProvider = DefaultSpotifyTokenProvider(networkProvider: defaultNetworkProvider)
        let defaultSpotifyAPIService = DefaultSpotifyAPIService(networkProvider: defaultNetworkProvider,
                                                                tokenProvider: defaultSpotifyTokenProvider
        )
        let defaultMusicKitService = DefaultMusicKitService()
        let defaultMusicRepository = DefaultMusicRepository(
            spotifyAPIService: defaultSpotifyAPIService,
            musicKitService: defaultMusicKitService
        )
        let defaultFetchMusicsUseCase = DefaultFetchMusicsUseCase(repository: defaultMusicRepository)
        let defaultImageProvider = DefaultImageFetchService()
        let defaultImageRepository = DefaultImageRepository(imageFetchService: defaultImageProvider)
        let defaultFetchImageUseCase = DefaultFetchImageUseCase(repository: defaultImageRepository)
        let swipeMusicViewModel = SwipeMusicViewModel(fetchMusicsUseCase: defaultFetchMusicsUseCase,
                                                      fetchImageUseCase: defaultFetchImageUseCase
        )
        
        return SwipeMusicViewController(viewModel: swipeMusicViewModel)
    }
    
    func updateUIViewController(_ uiViewController: SwipeMusicViewController, context: Context) {
        
    }
}

struct SwipeViewController_Previews: PreviewProvider {
    static var previews: some View {
        SwipeViewControllerPreview()
            .edgesIgnoringSafeArea(.all)
    }
}
