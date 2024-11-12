import Foundation
@testable import Molio

extension RecommendationsResponseDTO {
    static let dummyData: Data =
    #"""
    {
        "tracks": [
            {
                "album": {
                    "album_type": "ALBUM",
                    "artists": [
                        {
                            "external_urls": {
                                "spotify": "https://open.spotify.com/artist/1R52cwGf75yTf7I3Q0Irf8"
                            },
                            "href": "https://api.spotify.com/v1/artists/1R52cwGf75yTf7I3Q0Irf8",
                            "id": "1R52cwGf75yTf7I3Q0Irf8",
                            "name": "T-ARA",
                            "type": "artist",
                            "uri": "spotify:artist:1R52cwGf75yTf7I3Q0Irf8"
                        }
                    ],
                    "external_urls": {
                        "spotify": "https://open.spotify.com/album/3phQgRvQwZ0OPzmzoNKaYq"
                    },
                    "href": "https://api.spotify.com/v1/albums/3phQgRvQwZ0OPzmzoNKaYq",
                    "id": "3phQgRvQwZ0OPzmzoNKaYq",
                    "images": [
                        {
                            "height": 640,
                            "url": "https://i.scdn.co/image/ab67616d0000b273a789c8272fd5af66a1a64d0c",
                            "width": 640
                        },
                        {
                            "height": 300,
                            "url": "https://i.scdn.co/image/ab67616d00001e02a789c8272fd5af66a1a64d0c",
                            "width": 300
                        },
                        {
                            "height": 64,
                            "url": "https://i.scdn.co/image/ab67616d00004851a789c8272fd5af66a1a64d0c",
                            "width": 64
                        }
                    ],
                    "is_playable": true,
                    "name": "John Travolta Wanna Be",
                    "release_date": "2011-06-29",
                    "release_date_precision": "day",
                    "total_tracks": 7,
                    "type": "album",
                    "uri": "spotify:album:3phQgRvQwZ0OPzmzoNKaYq"
                },
                "artists": [
                    {
                        "external_urls": {
                            "spotify": "https://open.spotify.com/artist/1R52cwGf75yTf7I3Q0Irf8"
                        },
                        "href": "https://api.spotify.com/v1/artists/1R52cwGf75yTf7I3Q0Irf8",
                        "id": "1R52cwGf75yTf7I3Q0Irf8",
                        "name": "T-ARA",
                        "type": "artist",
                        "uri": "spotify:artist:1R52cwGf75yTf7I3Q0Irf8"
                    }
                ],
                "disc_number": 1,
                "duration_ms": 214427,
                "explicit": false,
                "external_ids": {
                    "isrc": "KRA341561064"
                },
                "external_urls": {
                    "spotify": "https://open.spotify.com/track/1p9damTV6h7u7THZKZB2tW"
                },
                "href": "https://api.spotify.com/v1/tracks/1p9damTV6h7u7THZKZB2tW",
                "id": "1p9damTV6h7u7THZKZB2tW",
                "is_local": false,
                "is_playable": true,
                "name": "Roly-Poly",
                "popularity": 54,
                "preview_url": "https://p.scdn.co/mp3-preview/e0eea97e064a92eab3774951a0cda1a8ccb6accd?cid=8de97cbb9ccb49c881d215df4e3a4b42",
                "track_number": 1,
                "type": "track",
                "uri": "spotify:track:1p9damTV6h7u7THZKZB2tW"
            },
            {
                "album": {
                    "album_type": "ALBUM",
                    "artists": [
                        {
                            "external_urls": {
                                "spotify": "https://open.spotify.com/artist/2ZvrvbQNrHKwjT7qfGFFUW"
                            },
                            "href": "https://api.spotify.com/v1/artists/2ZvrvbQNrHKwjT7qfGFFUW",
                            "id": "2ZvrvbQNrHKwjT7qfGFFUW",
                            "name": "Herbie Hancock",
                            "type": "artist",
                            "uri": "spotify:artist:2ZvrvbQNrHKwjT7qfGFFUW"
                        }
                    ],
                    "external_urls": {
                        "spotify": "https://open.spotify.com/album/7huPJTTsWVt854oZkr88mf"
                    },
                    "href": "https://api.spotify.com/v1/albums/7huPJTTsWVt854oZkr88mf",
                    "id": "7huPJTTsWVt854oZkr88mf",
                    "images": [
                        {
                            "height": 640,
                            "url": "https://i.scdn.co/image/ab67616d0000b27344e77f19a8f35955870d4907",
                            "width": 640
                        },
                        {
                            "height": 300,
                            "url": "https://i.scdn.co/image/ab67616d00001e0244e77f19a8f35955870d4907",
                            "width": 300
                        },
                        {
                            "height": 64,
                            "url": "https://i.scdn.co/image/ab67616d0000485144e77f19a8f35955870d4907",
                            "width": 64
                        }
                    ],
                    "is_playable": true,
                    "name": "Maiden Voyage",
                    "release_date": "1965-05-17",
                    "release_date_precision": "day",
                    "total_tracks": 5,
                    "type": "album",
                    "uri": "spotify:album:7huPJTTsWVt854oZkr88mf"
                },
                "artists": [
                    {
                        "external_urls": {
                            "spotify": "https://open.spotify.com/artist/2ZvrvbQNrHKwjT7qfGFFUW"
                        },
                        "href": "https://api.spotify.com/v1/artists/2ZvrvbQNrHKwjT7qfGFFUW",
                        "id": "2ZvrvbQNrHKwjT7qfGFFUW",
                        "name": "Herbie Hancock",
                        "type": "artist",
                        "uri": "spotify:artist:2ZvrvbQNrHKwjT7qfGFFUW"
                    }
                ],
                "disc_number": 1,
                "duration_ms": 477093,
                "explicit": false,
                "external_ids": {
                    "isrc": "USBN29801061"
                },
                "external_urls": {
                    "spotify": "https://open.spotify.com/track/0T1EaGm6b9eM7xBf4F1hlc"
                },
                "href": "https://api.spotify.com/v1/tracks/0T1EaGm6b9eM7xBf4F1hlc",
                "id": "0T1EaGm6b9eM7xBf4F1hlc",
                "is_local": false,
                "is_playable": true,
                "name": "Maiden Voyage",
                "popularity": 46,
                "preview_url": null,
                "track_number": 1,
                "type": "track",
                "uri": "spotify:track:0T1EaGm6b9eM7xBf4F1hlc"
            },
            {
                "album": {
                    "album_type": "ALBUM",
                    "artists": [
                        {
                            "external_urls": {
                                "spotify": "https://open.spotify.com/artist/3of4z5k152Et4C0IQ7HUAg"
                            },
                            "href": "https://api.spotify.com/v1/artists/3of4z5k152Et4C0IQ7HUAg",
                            "id": "3of4z5k152Et4C0IQ7HUAg",
                            "name": "Zitten",
                            "type": "artist",
                            "uri": "spotify:artist:3of4z5k152Et4C0IQ7HUAg"
                        }
                    ],
                    "external_urls": {
                        "spotify": "https://open.spotify.com/album/0aX3Rtn9MoMt04cA55lsFx"
                    },
                    "href": "https://api.spotify.com/v1/albums/0aX3Rtn9MoMt04cA55lsFx",
                    "id": "0aX3Rtn9MoMt04cA55lsFx",
                    "images": [
                        {
                            "height": 640,
                            "url": "https://i.scdn.co/image/ab67616d0000b27344638258e6026c02458f437a",
                            "width": 640
                        },
                        {
                            "height": 300,
                            "url": "https://i.scdn.co/image/ab67616d00001e0244638258e6026c02458f437a",
                            "width": 300
                        },
                        {
                            "height": 64,
                            "url": "https://i.scdn.co/image/ab67616d0000485144638258e6026c02458f437a",
                            "width": 64
                        }
                    ],
                    "is_playable": true,
                    "name": "Wonderland",
                    "release_date": "2010-06-15",
                    "release_date_precision": "day",
                    "total_tracks": 8,
                    "type": "album",
                    "uri": "spotify:album:0aX3Rtn9MoMt04cA55lsFx"
                },
                "artists": [
                    {
                        "external_urls": {
                            "spotify": "https://open.spotify.com/artist/3of4z5k152Et4C0IQ7HUAg"
                        },
                        "href": "https://api.spotify.com/v1/artists/3of4z5k152Et4C0IQ7HUAg",
                        "id": "3of4z5k152Et4C0IQ7HUAg",
                        "name": "Zitten",
                        "type": "artist",
                        "uri": "spotify:artist:3of4z5k152Et4C0IQ7HUAg"
                    }
                ],
                "disc_number": 1,
                "duration_ms": 242640,
                "explicit": false,
                "external_ids": {
                    "isrc": "KRA340926528"
                },
                "external_urls": {
                    "spotify": "https://open.spotify.com/track/7mtZPoHw5kB1C7U22yjGyy"
                },
                "href": "https://api.spotify.com/v1/tracks/7mtZPoHw5kB1C7U22yjGyy",
                "id": "7mtZPoHw5kB1C7U22yjGyy",
                "is_local": false,
                "is_playable": true,
                "name": "December",
                "popularity": 20,
                "preview_url": "https://p.scdn.co/mp3-preview/881f3b78f48ef4dec91daa5008fdc1968cdf0d5e?cid=8de97cbb9ccb49c881d215df4e3a4b42",
                "track_number": 3,
                "type": "track",
                "uri": "spotify:track:7mtZPoHw5kB1C7U22yjGyy"
            },
            {
                "album": {
                    "album_type": "ALBUM",
                    "artists": [
                        {
                            "external_urls": {
                                "spotify": "https://open.spotify.com/artist/2kxVxKOgoefmgkwoHipHsn"
                            },
                            "href": "https://api.spotify.com/v1/artists/2kxVxKOgoefmgkwoHipHsn",
                            "id": "2kxVxKOgoefmgkwoHipHsn",
                            "name": "Silica Gel",
                            "type": "artist",
                            "uri": "spotify:artist:2kxVxKOgoefmgkwoHipHsn"
                        }
                    ],
                    "external_urls": {
                        "spotify": "https://open.spotify.com/album/6Knnr9SwfB0kyFoMa4rNQ1"
                    },
                    "href": "https://api.spotify.com/v1/albums/6Knnr9SwfB0kyFoMa4rNQ1",
                    "id": "6Knnr9SwfB0kyFoMa4rNQ1",
                    "images": [
                        {
                            "height": 640,
                            "url": "https://i.scdn.co/image/ab67616d0000b273f89ac0b7f3127d5c9ce3c013",
                            "width": 640
                        },
                        {
                            "height": 300,
                            "url": "https://i.scdn.co/image/ab67616d00001e02f89ac0b7f3127d5c9ce3c013",
                            "width": 300
                        },
                        {
                            "height": 64,
                            "url": "https://i.scdn.co/image/ab67616d00004851f89ac0b7f3127d5c9ce3c013",
                            "width": 64
                        }
                    ],
                    "is_playable": false,
                    "name": "POWER ANDRE 99",
                    "release_date": "2023-12-20",
                    "release_date_precision": "day",
                    "restrictions": {
                        "reason": "PRODUCT"
                    },
                    "total_tracks": 18,
                    "type": "album",
                    "uri": "spotify:album:6Knnr9SwfB0kyFoMa4rNQ1"
                },
                "artists": [
                    {
                        "external_urls": {
                            "spotify": "https://open.spotify.com/artist/2kxVxKOgoefmgkwoHipHsn"
                        },
                        "href": "https://api.spotify.com/v1/artists/2kxVxKOgoefmgkwoHipHsn",
                        "id": "2kxVxKOgoefmgkwoHipHsn",
                        "name": "Silica Gel",
                        "type": "artist",
                        "uri": "spotify:artist:2kxVxKOgoefmgkwoHipHsn"
                    }
                ],
                "disc_number": 1,
                "duration_ms": 219414,
                "explicit": false,
                "external_ids": {
                    "isrc": "KRF252200272"
                },
                "external_urls": {
                    "spotify": "https://open.spotify.com/track/4N5PLI3puPr62sGcJbkiFL"
                },
                "href": "https://api.spotify.com/v1/tracks/4N5PLI3puPr62sGcJbkiFL",
                "id": "4N5PLI3puPr62sGcJbkiFL",
                "is_local": false,
                "is_playable": true,
                "linked_from": {
                    "external_urls": {
                        "spotify": "https://open.spotify.com/track/4Tz8G2vbDj5GF3FDBC2Pnd"
                    },
                    "href": "https://api.spotify.com/v1/tracks/4Tz8G2vbDj5GF3FDBC2Pnd",
                    "id": "4Tz8G2vbDj5GF3FDBC2Pnd",
                    "type": "track",
                    "uri": "spotify:track:4Tz8G2vbDj5GF3FDBC2Pnd"
                },
                "name": "NO PAIN",
                "popularity": 28,
                "preview_url": "https://p.scdn.co/mp3-preview/ff51428dbfd426faed3967526f91cbaaec1cc121?cid=8de97cbb9ccb49c881d215df4e3a4b42",
                "track_number": 1,
                "type": "track",
                "uri": "spotify:track:4N5PLI3puPr62sGcJbkiFL"
            },
            {
                "album": {
                    "album_type": "ALBUM",
                    "artists": [
                        {
                            "external_urls": {
                                "spotify": "https://open.spotify.com/artist/4Kxlr1PRlDKEB0ekOCyHgX"
                            },
                            "href": "https://api.spotify.com/v1/artists/4Kxlr1PRlDKEB0ekOCyHgX",
                            "id": "4Kxlr1PRlDKEB0ekOCyHgX",
                            "name": "BIGBANG",
                            "type": "artist",
                            "uri": "spotify:artist:4Kxlr1PRlDKEB0ekOCyHgX"
                        }
                    ],
                    "external_urls": {
                        "spotify": "https://open.spotify.com/album/3iTETURuyuUJByvQOLoydV"
                    },
                    "href": "https://api.spotify.com/v1/albums/3iTETURuyuUJByvQOLoydV",
                    "id": "3iTETURuyuUJByvQOLoydV",
                    "images": [
                        {
                            "height": 640,
                            "url": "https://i.scdn.co/image/ab67616d0000b273e03d007376ec65656c348205",
                            "width": 640
                        },
                        {
                            "height": 300,
                            "url": "https://i.scdn.co/image/ab67616d00001e02e03d007376ec65656c348205",
                            "width": 300
                        },
                        {
                            "height": 64,
                            "url": "https://i.scdn.co/image/ab67616d00004851e03d007376ec65656c348205",
                            "width": 64
                        }
                    ],
                    "is_playable": true,
                    "name": "BIGBANG Vol.1",
                    "release_date": "2006-12-22",
                    "release_date_precision": "day",
                    "total_tracks": 11,
                    "type": "album",
                    "uri": "spotify:album:3iTETURuyuUJByvQOLoydV"
                },
                "artists": [
                    {
                        "external_urls": {
                            "spotify": "https://open.spotify.com/artist/4Kxlr1PRlDKEB0ekOCyHgX"
                        },
                        "href": "https://api.spotify.com/v1/artists/4Kxlr1PRlDKEB0ekOCyHgX",
                        "id": "4Kxlr1PRlDKEB0ekOCyHgX",
                        "name": "BIGBANG",
                        "type": "artist",
                        "uri": "spotify:artist:4Kxlr1PRlDKEB0ekOCyHgX"
                    }
                ],
                "disc_number": 1,
                "duration_ms": 179586,
                "explicit": false,
                "external_ids": {
                    "isrc": "KRA341104496"
                },
                "external_urls": {
                    "spotify": "https://open.spotify.com/track/62laTbC1RWyE3IhsNEbvE9"
                },
                "href": "https://api.spotify.com/v1/tracks/62laTbC1RWyE3IhsNEbvE9",
                "id": "62laTbC1RWyE3IhsNEbvE9",
                "is_local": false,
                "is_playable": true,
                "name": "La La La",
                "popularity": 39,
                "preview_url": "https://p.scdn.co/mp3-preview/a7fd672e1b239ad13bb61e1a082da7eb02b3645a?cid=8de97cbb9ccb49c881d215df4e3a4b42",
                "track_number": 9,
                "type": "track",
                "uri": "spotify:track:62laTbC1RWyE3IhsNEbvE9"
            }
        ],
        "seeds": [
            {
                "initialPoolSize": 504,
                "afterFilteringSize": 504,
                "afterRelinkingSize": 504,
                "id": "4Kxlr1PRlDKEB0ekOCyHgX",
                "type": "ARTIST",
                "href": "https://api.spotify.com/v1/artists/4Kxlr1PRlDKEB0ekOCyHgX"
            },
            {
                "initialPoolSize": 424,
                "afterFilteringSize": 424,
                "afterRelinkingSize": 424,
                "id": "6WeDO4GynFmK4OxwkBzMW8",
                "type": "ARTIST",
                "href": "https://api.spotify.com/v1/artists/6WeDO4GynFmK4OxwkBzMW8"
            },
            {
                "initialPoolSize": 567,
                "afterFilteringSize": 567,
                "afterRelinkingSize": 567,
                "id": "jazz",
                "type": "GENRE",
                "href": null
            }
        ]
    }
    """#.data(using: .utf8)!
}
