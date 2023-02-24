import 'package:drift/drift.dart';
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sequence/src/datasource/local/converters/apple_music_db.dart';
import 'package:sequence/src/datasource/local/converters/spotify_db.dart';

part 'database.g.dart';

@DataClassName('RecognitionResultEntity')
class RecognitionResultEntityy extends Table {
  TextColumn get artist => text()();
  TextColumn get title => text()();
  TextColumn get album => text()();
  TextColumn get releaseDate => text()();
  TextColumn get label => text()();
  TextColumn get timeCode => text()();
  TextColumn get songLink => text()();
  TextColumn get appleMusic => text().map(AppleMusicConverter())();
  TextColumn get spotify => text().map(SpotifyConverter())();
}

abstract class RecognitionResultView extends View {
  RecognitionResultEntityy get recognitions;

  @override
  Query as() => select([recognitions.album]).from(recognitions);
}

@DriftDatabase(
  tables: [
    RecognitionResultEntityy,
  ],
  views: [
    RecognitionResultView,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (m, from, to) async {
        await customStatement('PRAGMA foreign_keys = OFF');
        for (var step = from + 1; step <= to; step++) {
          switch (step) {
            case 2:
              //Do something here
              break;
          }
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(
    () async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase.createInBackground(file);
    },
  );
}
