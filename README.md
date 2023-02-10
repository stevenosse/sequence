# Sequence

<p style="text-align: center;">
Music Recognition app using <a href="https://audd.io">Audd</a/>'s Music recognition API
</p>

<p align="center">
    <a href="https://github.com/stevenosse/sequence/actions">
        <img src="https://github.com/stevenosse/sequence/actions/workflows/main.yml/badge.svg" alt="ci" />
    </a>
    <a href="http://hits.dwyl.com/stevenosse/sequence"><img src="https://hits.dwyl.com/stevenosse/sequence.svg?style=flat" alt="ci"></a>
    <a href="https://twitter.com/intent/follow?screen_name=nossesteve">
        <img src="https://img.shields.io/twitter/follow/nossesteve?style=social&logo=twitter"
            alt="follow on Twitter"></a>
</p>


## 🚧 Getting Started 🚧

🏗️ Construction is underway, there may be a lot of elements missing in this README

### Running the app

Couple steps are required to run this app on your local machine.

First, get an API Token from Audd by following [this link](https://docs.audd.io/).
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

![Application Demo](demo.gif)

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

- [ ] Finish Documentation
- [ ] Add Widget tests
