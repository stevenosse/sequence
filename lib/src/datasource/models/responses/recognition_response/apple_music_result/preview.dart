import 'package:freezed_annotation/freezed_annotation.dart';

part 'preview.freezed.dart';
part 'preview.g.dart';

@freezed
class Preview with _$Preview {
  factory Preview({
    required String url,
  }) = _Preview;

  factory Preview.fromJson(Map<String, dynamic> json) =>
      _$PreviewFromJson(json);
}
