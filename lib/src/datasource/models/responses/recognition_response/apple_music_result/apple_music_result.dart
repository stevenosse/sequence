import 'package:freezed_annotation/freezed_annotation.dart';

import 'artwork.dart';
import 'play_params.dart';
import 'preview.dart';

part 'apple_music_result.freezed.dart';
part 'apple_music_result.g.dart';

@freezed
class AppleMusicResult with _$AppleMusicResult {
  factory AppleMusicResult({
    @Default([]) List<Preview> previews,
    Artwork? artwork,
    required String artistName,
    required String url,
    int? discNumber,
    @Default([]) List<String> genreNames,
    int? durationInMillis,
    required String releaseDate,
    required String name,
    String? isrc,
    String? albumName,
    PlayParams? playParams,
    int? trackNumber,
    required String composerName,
  }) = _AppleMusicResult;

  factory AppleMusicResult.fromJson(Map<String, dynamic> json) => _$AppleMusicResultFromJson(json);
}
