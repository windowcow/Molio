import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mockSpotifyAPIService = MockSpotifyAPIService()
        let defaultMusicKitService = DefaultMusicKitService()
        let defaultMusicRepository = DefaultMusicRepository(
            spotifyAPIService: mockSpotifyAPIService,
            musicKitService: defaultMusicKitService
        )
        let defaultFetchMusicsUseCase = DefaultFetchMusicsUseCase(repository: defaultMusicRepository)
        let swipeMusicViewModel = SwipeMusicViewModel(fetchMusicsUseCase: defaultFetchMusicsUseCase)
        let swipeMusicViewController = SwipeMusicViewController(viewModel: swipeMusicViewModel)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: swipeMusicViewController)
        window?.makeKeyAndVisible()
    }
}
