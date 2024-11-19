import MusicKit

struct SongMapper {
    static func toDomain(_ song: Song) -> MolioMusic? {
        guard let isrc = song.isrc,
              let previewAsset = song.previewAssets?.first?.url else {
            return nil
        }
        
        return MolioMusic(title: song.title,
                           artistName: song.artistName,
                           gerneNames: song.genreNames,
                           isrc: isrc,
                           previewAsset: previewAsset,
                           artworkImageURL: song.artwork?.url(width: 440, height: 440),
                           artworkBackgroundColor: song.artwork?.backgroundColor.flatMap { CGColorMapper.toDomain($0) },
                           primaryTextColor: song.artwork?.primaryTextColor.flatMap { CGColorMapper.toDomain($0) }
        )
    }
}
