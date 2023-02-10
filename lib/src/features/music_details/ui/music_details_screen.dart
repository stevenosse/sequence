import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sequence/src/core/i18n/l10n.dart';
import 'package:sequence/src/core/theme/dimens.dart';

import 'package:sequence/src/datasource/models/responses/recognition_response/recognition_result.dart';
import 'package:sequence/src/features/music_details/services/open_in_player_service.dart';
import 'package:sequence/src/generated/assets.gen.dart';
import 'package:sequence/src/shared/locator.dart';

class MusicDetailsScreen extends StatelessWidget {
  MusicDetailsScreen({
    super.key,
    required this.recognitionResult,
    OpenInPlayerService? openInPlayerService,
  }) : _openInPlayerService = openInPlayerService ?? locator<OpenInPlayerService>();

  final RecognitionResult recognitionResult;
  final OpenInPlayerService _openInPlayerService;

  @override
  Widget build(BuildContext context) {
    final songCoverImagePath =
        recognitionResult.spotify?.album?.images.firstOrNull?.url ?? recognitionResult.appleMusic?.artwork?.url;

    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _AlbumCover(url: songCoverImagePath),
            const _OverlayGradient(),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.height * .8,
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.all(Dimens.padding),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(recognitionResult.title, textScaleFactor: 1),
                        Text(
                          recognitionResult.artist,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        if (recognitionResult.album != null) ...[
                          const SizedBox(height: Dimens.halfSpace),
                          Text(
                            recognitionResult.album!,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: Theme.of(context).colorScheme.onPrimary, fontSize: 8.0),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: Dimens.space)),
                SliverToBoxAdapter(
                  child: Wrap(
                    spacing: Dimens.space,
                    runSpacing: Dimens.space,
                    alignment: WrapAlignment.center,
                    children: [
                      if (recognitionResult.spotify != null)
                        _SpotifyButton(
                          onPressed: () {
                            final trackUrl = recognitionResult.spotify!.externalUrls?.spotify;
                            if (trackUrl != null) {
                              _openInPlayerService.open(trackUrl);
                            } else {
                              log('Failed to oepn spotify music: url is null');
                            }
                          },
                        ),
                      if (recognitionResult.appleMusic != null)
                        _AppleMusicButton(
                          onPressed: () {
                            final trackUrl = recognitionResult.appleMusic!.url;

                            _openInPlayerService.open(trackUrl);
                          },
                        ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _AlbumCover extends StatelessWidget {
  const _AlbumCover({this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: (url == null ? AssetImage(Assets.images.coverFallback.path) : NetworkImage(url!)) as ImageProvider,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _OverlayGradient extends StatelessWidget {
  const _OverlayGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Colors.black54,
            Colors.white54,
          ],
        ),
      ),
    );
  }
}

class _SpotifyButton extends StatelessWidget {
  const _SpotifyButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white24,
          shape: const StadiumBorder(),
        ),
        icon: Logo(Logos.spotify, size: Dimens.doubleSpace),
        label: Text(I18n.of(context).musicDetails_spotifyButtonlabel),
      ),
    );
  }
}

class _AppleMusicButton extends StatelessWidget {
  const _AppleMusicButton({this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.buttonHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white24,
          shape: const StadiumBorder(),
        ),
        icon: Logo(Logos.apple_music, size: Dimens.doubleSpace),
        label: Text(I18n.of(context).musicDetails_appleMusicButtonlabel),
      ),
    );
  }
}
