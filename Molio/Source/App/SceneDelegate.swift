import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let defaultNetworkProvider = DefaultNetworkProvider()
        let mockSpotifyTokenProvider = MockSpotifyTokenProvider() //TODO: 이후 Mock -> Default 수정
        let defaultSpotifyAPIService = DefaultSpotifyAPIService(networkProvider: defaultNetworkProvider,
                                                                tokenProvider: mockSpotifyTokenProvider
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
        let swipeMusicViewController = SwipeMusicViewController(viewModel: swipeMusicViewModel)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: swipeMusicViewController)
        window?.makeKeyAndVisible()
    }
}
