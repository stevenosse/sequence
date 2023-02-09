import 'package:freezed_annotation/freezed_annotation.dart';

import 'external_urls.dart';

part 'artist.freezed.dart';
part 'artist.g.dart';

@freezed
class Artist with _$Artist {
  factory Artist({
    required String name,
    required String id,
    required String uri,
    required String href,
    @JsonKey(name: 'external_urls') ExternalUrls? externalUrls,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
