import Foundation

/// Swipe 할 수 있는 화면에 표시되는 음악 정보에 대한 UI View Model입니다.
struct SwipeMusicTrackModel {
    /// 노래 제목
    let title: String
    
    /// 아티스트 이름
    let artistName: String
    
    /// 장르 목록
    let gerneNames: [String]
    
    /// 국제 표준 녹음 자료 코드
    let isrc: String
    
    /// 음악 미리듣기 URL
    let previewAsset: URL
    
    /// 앨범 아트워크 이미지
    let artworkImageData: Data?
    
    /// 앨범에 이미지에 따른 평균 배경색
    let artworkBackgroundColor: RGBAColor?
    
    /// 앨범에 이미지에 따른 primary 색상
    let primaryTextColor: RGBAColor?
    
    init(randomMusic: MolioMusic, imageData: Data?) {
        self.title = randomMusic.title
        self.artistName = randomMusic.artistName
        self.gerneNames = Array(randomMusic.gerneNames.prefix(3))
        self.isrc = randomMusic.isrc
        self.previewAsset = randomMusic.previewAsset
        self.artworkImageData = imageData
        self.artworkBackgroundColor = randomMusic.artworkBackgroundColor
        self.primaryTextColor = randomMusic.primaryTextColor
    }
}
