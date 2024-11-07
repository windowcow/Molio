// 노래 필터에 대한 엔티티다.
// "pop", "k-pop"같은 것들은 사용자가 [플레이리스트 설정]의 필터에서 설정한다.
// 설정된 필터들을 통해서 이 엔티티를 생성하고, 이 엔티티는 스포티파이 API의 노래 추천 요청에 사용된다.
struct MusicFilterEntity {
    var genres: [String]
    
    //  ex) ["pop", "k-pop"]
    init(genres: [String]) {
        self.genres = genres
    }
}
