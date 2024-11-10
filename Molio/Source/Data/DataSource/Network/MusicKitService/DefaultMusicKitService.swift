import MusicKit

final class DefaultMusicKitService: MusicKitService {
    /// 애플 뮤직 접근 권한 상태를 확인
    private func checkAuthorizationStatus() -> Bool {
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
    func getMusic(with isrc: String) async -> RandomMusic? {
        guard checkAuthorizationStatus() else { return nil }
        
        let request = MusicCatalogResourceRequest<Song>(matching: \.isrc, equalTo: isrc)
        do {
            let response = try await request.response()
            let searchedMusic = response.items.first
            return SongMapper.toDomain(searchedMusic)
        } catch {
            return nil
        }
    }
    
    /// 애플 뮤직 접근 권한 요청
    private func requestAuthorization() async {
        _ = await MusicAuthorization.request()
    }
}
