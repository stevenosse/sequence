# Sequence

Music Recognition app using https://audd.io

[![HitCount](https://hits.dwyl.com/stevenosse/sequence.svg?style=flat)](http://hits.dwyl.com/stevenosse/sequence)

## 🚧 Getting Started 🚧

🏗️ Construction is underway,there may be a lot of elements missing in this README

### Running the app

#### Step 1

An API Token is required to run the app. This API Token is retrieved from environment variables read throught dart define. You'll need to provide is as well as the api base url:

```shell
$ flutter run --dart-define apiBaseUrl=https://api.audd.io --dart-define AUDD_API_TOKEN=<YOUR_API_TOKEN>
```

#### Step 2

Install dependencies:

```shell
$ flutter pub get
```

#### Step 3

Run code generation:

```shell
$ flutter pub run build_runner build --delete-conflicting-outputs
```

### App Demo:

![Application Demo](demo.mp4)

## Architecture and Folter Structure

```markdown
lib/
├── generated/
└── src/
├── core/
│ ├── i18n/
│ ├── routing/
│ ├── theme/
│ ├── app_initialiser.dart
│ ├── application.dart
│ └── environment.dart
├── datasource/
│ ├── http/
│ ├── models/
│ └── repositories/
│ └── base_repository.dart
├── features/
│ ├── music_recognition/
│ │ ├── enums/
│ │ ├── exceptions/
│ │ ├── logic/
│ │ ├── repositories/
│ │ ├── services/
│ │ └── ui/
│ └── music_details/
└── main.dart
```

## Tools

- [fvm](fvm.app): used for flutter version management
- [flutter_gen](https://pub.dev/packages/flutter_gen): Used to generated assets

## TODO

- Finish Documentation
- CI Setup
- Write tests
