import MusicKit

final class MusicKitService {
    /// 애플 뮤직 접근 권한 상태를 확인
    func checkAuthorizationStatus() -> Bool {
        switch MusicAuthorization.currentStatus {
        case .authorized:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            Task {
                await requestAuthorization()
            }
            return false
        @unknown default:
            return false
        }
    }
    
    /// ISRC 코드로 애플 뮤직 카탈로그 음악을 검색합니다.
    ///  - Parameters: 검색할 isrc 문자열
    ///  - Returns: 응답 Data
    func getMusic(with isrc: String) async -> Song? {
        let request = MusicCatalogResourceRequest<Song>(matching: \.isrc, equalTo: isrc)
        do {
            let response = try await request.response()
            let searchedMusic = response.items.first
            return searchedMusic
        } catch {
            return nil
        }
    }
    
    /// 애플 뮤직 접근 권한 요청
    private func requestAuthorization() async {
        _ = await MusicAuthorization.request()
    }
}
