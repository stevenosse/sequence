import 'package:freezed_annotation/freezed_annotation.dart';

import 'artist.dart';
import 'external_urls.dart';
import 'image.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
class Album with _$Album {
  factory Album({
    required String name,
    @Default([]) List<Artist> artists,
    @JsonKey(name: 'album_group') required String albumGroup,
    @JsonKey(name: 'album_type') required String albumType,
    required String id,
    required String uri,
    @JsonKey(name: 'available_markets')
    @Default([])
        List<String> availableMarkets,
    String? href,
    @Default([]) List<Image> images,
    @JsonKey(name: 'external_urls') ExternalUrls? externalUrls,
    @JsonKey(name: 'release_date') required String releaseDate,
    @JsonKey(name: 'release_date_precision')
        required String releaseDatePrecision,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
