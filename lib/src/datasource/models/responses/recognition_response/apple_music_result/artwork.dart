import 'package:freezed_annotation/freezed_annotation.dart';

part 'artwork.freezed.dart';
part 'artwork.g.dart';

@freezed
class Artwork with _$Artwork {
  factory Artwork({
    int? width,
    int? height,
    String? url,
    String? bgColor,
    String? textColor1,
    String? textColor2,
    String? textColor3,
    String? textColor4,
  }) = _Artwork;

  factory Artwork.fromJson(Map<String, dynamic> json) => _$ArtworkFromJson(json);
}
