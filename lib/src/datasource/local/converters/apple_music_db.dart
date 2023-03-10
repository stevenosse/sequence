import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/apple_music_result/artwork.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/apple_music_result/play_params.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/apple_music_result/preview.dart';
import 'package:json_annotation/json_annotation.dart' as j;

part 'apple_music_db.g.dart';

@j.JsonSerializable()
class AppleMusicEntity extends Equatable {
  final List<Preview> previews;
  final Artwork? artwork;
  final String artistName;
  final String url;
  final int? discNumber;
  final List<String> genreNames;
  final int? durationInMillis;
  final String releaseDate;
  final String name;
  final String? isrc;
  final String? albumName;
  final PlayParams? playParams;
  final int? trackNumber;
  final String composerName;

  const AppleMusicEntity({
    required this.artistName,
    required this.url,
    this.discNumber,
    required this.genreNames,
    this.durationInMillis,
    required this.releaseDate,
    required this.name,
    this.isrc,
    this.albumName,
    this.playParams,
    this.trackNumber,
    required this.composerName,
    required this.previews,
    required this.artwork,
  });

  @override
  List<Object?> get props => [
        artistName,
        url,
        discNumber,
        genreNames,
        durationInMillis,
        releaseDate,
        name,
        isrc,
        albumName,
        playParams,
        trackNumber,
        composerName,
        previews,
        artwork,
      ];

  factory AppleMusicEntity.fromJson(Map<String, dynamic> json) =>
      _$AppleMusicEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AppleMusicEntityToJson(this);
}

class AppleMusicConverter extends TypeConverter<AppleMusicEntity, String> {
  @override
  AppleMusicEntity fromSql(String fromDb) {
    return AppleMusicEntity.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(AppleMusicEntity value) {
    return jsonEncode(value.toJson());
  }
}
