import 'package:sequence/src/datasource/local/converters/apple_music_db.dart';
import 'package:sequence/src/datasource/local/converters/spotify_db.dart';
import 'package:sequence/src/datasource/local/database.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_result.dart';
import 'package:sequence/src/datasource/models/responses/recognition_response/spotify_result/album.dart';

class LocalRecognitionRepository {
  final db = AppDatabase();

  Future<String> saveRecognitions(RecognitionResult response) async {
    try {
      await db.into(db.recognitionResultEntityy).insert(
            RecognitionResultEntityyCompanion.insert(
              artist: response.artist,
              title: response.title,
              releaseDate: response.releaseDate,
              label: response.label,
              timeCode: response.timecode,
              songLink: response.songLink,
              album: response.album ?? '',
              appleMusic: AppleMusicEntity(
                artistName: response.appleMusic!.artistName,
                url: response.appleMusic!.url,
                discNumber: response.appleMusic!.discNumber,
                durationInMillis: response.appleMusic!.durationInMillis,
                isrc: response.appleMusic!.isrc,
                albumName: response.appleMusic!.albumName,
                playParams: response.appleMusic!.playParams,
                trackNumber: response.appleMusic!.trackNumber,
                genreNames: response.appleMusic!.genreNames,
                releaseDate: response.appleMusic!.releaseDate,
                name: response.appleMusic!.name,
                composerName: response.appleMusic!.composerName,
                previews: response.appleMusic!.previews,
                artwork: response.appleMusic!.artwork,
              ),
              spotify: SpotifyEntity(
                popularity: response.spotify!.popularity,
                artists: response.spotify!.artists,
                availableMarkets: response.spotify!.availableMarkets,
                href: response.spotify!.href,
                id: response.spotify!.id,
                name: response.spotify!.name,
                previewUrl: response.spotify!.previewUrl,
                uri: response.spotify!.uri,
                album: Album(
                  name: response.spotify!.album!.name,
                  albumGroup: response.spotify!.album!.albumGroup,
                  albumType: response.spotify!.album!.albumType,
                  id: response.spotify!.album!.id,
                  uri: response.spotify!.album!.id,
                  releaseDate: response.spotify!.album!.releaseDate,
                  releaseDatePrecision:
                      response.spotify!.album!.releaseDatePrecision,
                ),
                isPlayable: response.spotify!.isPlayable,
                linkedFrom: response.spotify!.linkedFrom,
                discNumber: response.spotify!.discNumber,
                durationMs: response.spotify!.durationMs,
                explicit: response.spotify!.explicit,
                externalUrls: response.spotify!.externalUrls,
                trackNumber: response.spotify!.trackNumber,
                externalIds: response.spotify!.externalIds,
              ),
            ),
          );
      return 'Successful';
    } catch (e) {
      throw e.toString();
    }
  }

  // Future<RecognitionResult> fetchLocalRecognitions() async{}
}
