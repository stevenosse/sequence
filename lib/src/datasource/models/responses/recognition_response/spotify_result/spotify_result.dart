import 'package:freezed_annotation/freezed_annotation.dart';

import 'album.dart';
import 'artist.dart';
import 'external_ids.dart';
import 'external_urls.dart';

part 'spotify_result.freezed.dart';
part 'spotify_result.g.dart';

@freezed
class SpotifyResult with _$SpotifyResult {
  factory SpotifyResult({
    Album? album,
    @JsonKey(name: 'external_ids') ExternalIds? externalIds,
    @Default(0) int popularity,
    @JsonKey(name: 'is_playable') bool? isPlayable,
    @JsonKey(name: 'linked_from') String? linkedFrom,
    @Default([]) List<Artist> artists,
    @JsonKey(name: 'available_markets')
    @Default([])
        List<String> availableMarkets,
    @JsonKey(name: 'disc_number') int? discNumber,
    @JsonKey(name: 'duration_ms') int? durationMs,
    bool? explicit,
    @JsonKey(name: 'external_urls') ExternalUrls? externalUrls,
    required String href,
    required String id,
    required String name,
    @JsonKey(name: 'preview_url') required String previewUrl,
    @JsonKey(name: 'track_number') int? trackNumber,
    required String uri,
  }) = _SpotifyResult;

  factory SpotifyResult.fromJson(Map<String, dynamic> json) =>
      _$SpotifyResultFromJson(json);
}
