import 'package:freezed_annotation/freezed_annotation.dart';

import 'spotify_result/spotify_result.dart';
import 'apple_music_result/apple_music_result.dart';

part 'recognition_result.freezed.dart';
part 'recognition_result.g.dart';

@freezed
class RegognitionResult with _$RegognitionResult {
  factory RegognitionResult({
    required String artist,
    required String title,
    String? album,
    @JsonKey(name: 'release_date') required String releaseDate,
    required String label,
    required String timecode,
    @JsonKey(name: 'song_link') required String songLink,
    @JsonKey(name: 'apple_music') AppleMusicResult? appleMusic,
    SpotifyResult? spotify,
  }) = _RegognitionResult;

  factory RegognitionResult.fromJson(Map<String, dynamic> json) =>
      _$RegognitionResultFromJson(json);
}
