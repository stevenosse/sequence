import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sequence/generated/assets.gen.dart';
import 'package:sequence/src/core/i18n/l10n.dart';
import 'package:sequence/src/core/routing/app_router.dart';
import 'package:sequence/src/core/theme/dimens.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_state.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';
import 'package:sequence/src/features/music_recognition/ui/widgets/recognition_failed_view.dart';
import 'package:sequence/src/features/music_recognition/ui/widgets/record_button.dart';

class MusicRecognitionScreen extends StatefulWidget implements AutoRouteWrapper {
  const MusicRecognitionScreen({super.key});

  @override
  State<MusicRecognitionScreen> createState() => _MusicRecognitionScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SampleRecorderCubit()),
        BlocProvider(create: (_) => MusicRecognizerCubit()),
      ],
      child: this,
    );
  }
}

class _MusicRecognitionScreenState extends State<MusicRecognitionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarColor: Theme.of(context).colorScheme.primary,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: BlocListener<MusicRecognizerCubit, MusicRecognizerState>(
        listener: (context, state) {
          state.whenOrNull(
            recognitionSucceeded: (request, response) {
              context.read<SampleRecorderCubit>().reset();
              context.router.push(MusicDetailsRoute(recognitionResult: response.result!));
            },
          );
        },
        child: BlocConsumer<SampleRecorderCubit, SampleRecorderState>(
          listener: (context, state) {
            state.whenOrNull(
              recordSuccessful: (filePath) {
                context.read<MusicRecognizerCubit>().recognize(filePath: filePath);
              },
              recordFailed: (exception) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    content: Text(
                      I18n.of(context).musicRecognition_recordFailed,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Theme.of(context).colorScheme.onError),
                    ),
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  AnimatedCrossFade(
                    firstChild: const _RecordView(),
                    secondChild: const _RecognitionStatus(),
                    crossFadeState: state.maybeWhen(
                      recordSuccessful: (filePath) => CrossFadeState.showSecond,
                      orElse: () => CrossFadeState.showFirst,
                    ),
                    duration: const Duration(milliseconds: 500),
                    excludeBottomFocus: false,
                    sizeCurve: Curves.decelerate,
                  ),
                  const Spacer(),
                  Text(
                    I18n.of(context).developerNotice,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary, fontWeight: FontWeight.normal, fontSize: 12.0),
                  ),
                  const SizedBox(height: Dimens.doubleSpace),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RecordView extends StatelessWidget {
  const _RecordView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SampleRecorderCubit, SampleRecorderState>(
      builder: (context, state) {
        return state.maybeWhen(
          recordSuccessful: (filePath) => const SizedBox(),
          orElse: () => AnimatedCrossFade(
            firstChild: RecordButton(
              onRecordPressed: () => context.read<SampleRecorderCubit>().recordSample(),
            ),
            secondChild: Lottie.asset(Assets.animations.waves),
            crossFadeState: state.maybeWhen(
              recordPending: () => CrossFadeState.showSecond,
              orElse: () => CrossFadeState.showFirst,
            ),
            duration: const Duration(milliseconds: 500),
          ),
        );
      },
    );
  }
}

class _RecognitionStatus extends StatelessWidget {
  const _RecognitionStatus();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicRecognizerCubit, MusicRecognizerState>(
      builder: (context, state) {
        return state.maybeWhen(
          recognitionLoading: (request) => Text(
            I18n.of(context).musicRecognition_loadingLabel,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          recognitionFailed: (request, reason) {
            return RecognitionFailedView(
              reason: reason,
              onRetry: () => context.read<SampleRecorderCubit>().recordSample(),
            );
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
