import MusicKit

struct SongMapper {
    static func toDomain(_ song: Song?) -> RandomMusic? {
        guard let song,
              let isrc = song.isrc,
              let previewAsset = song.previewAssets?.first?.url,
              let artworkImageURL = song.artwork?.url(width: 440, height: 440),
              let artworkBackgroundColor = CGColorMapper.toDomain(song.artwork?.backgroundColor),
              let primaryTextColor = CGColorMapper.toDomain(song.artwork?.primaryTextColor) else {
            return nil
        }
        
        return RandomMusic(title: song.title,
                     artistName: song.artistName,
                     gerneNames: song.genreNames,
                     isrc: isrc,
                     previewAsset: previewAsset,
                     artworkImageURL: artworkImageURL,
                     artworkBackgroundColor: artworkBackgroundColor,
                     primaryTextColor: primaryTextColor
        )
    }
}
