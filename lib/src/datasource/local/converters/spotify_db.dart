import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart' as j;
import 'package:sequence/src/datasource/models/responses/recognition_response/spotify_result/album.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/spotify_result/artist.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/spotify_result/external_ids.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/spotify_result/external_urls.dart';

part 'spotify_db.g.dart';

@j.JsonSerializable()
class SpotifyDb extends Equatable {
  final Album? album;
  final ExternalIds? externalIds;
  final int popularity;
  final bool? isPlayable;
  final String? linkedFrom;
  final List<Artist> artists;
  final List<String> availableMarkets;
  final int? discNumber;
  final int? durationMs;
  final bool? explicit;
  final ExternalUrls? externalUrls;
  final String href;
  final String id;
  final String name;
  final String previewUrl;
  final int? trackNumber;
  final String uri;

  const SpotifyDb({
    this.album,
    this.externalIds,
    required this.popularity,
    this.isPlayable,
    this.linkedFrom,
    required this.artists,
    required this.availableMarkets,
    this.discNumber,
    this.durationMs,
    this.explicit,
    this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.previewUrl,
    this.trackNumber,
    required this.uri,
  });

  @override
  List<Object?> get props => [
        album,
        externalIds,
        popularity,
        isPlayable,
        linkedFrom,
        artists,
        availableMarkets,
        discNumber,
        durationMs,
        explicit,
        externalUrls,
        href,
        id,
        name,
        previewUrl,
        trackNumber,
        uri,
      ];

  factory SpotifyDb.fromJson(Map<String, dynamic> json) =>
      _$SpotifyDbFromJson(json);

  Map<String, dynamic> toJson() => _$SpotifyDbToJson(this);
}

class SpotifyConverter extends TypeConverter<SpotifyDb, String> {
  @override
  SpotifyDb fromSql(String fromDb) {
    return SpotifyDb.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(SpotifyDb value) {
    return jsonEncode(value.toJson());
  }
}