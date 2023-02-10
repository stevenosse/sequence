import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sequence/src/core/routing/app_router.dart';
import 'package:sequence/src/core/theme/dimens.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_state.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';
import 'package:sequence/src/features/music_recognition/ui/widgets/record_button.dart';
import 'package:sequence/src/generated/assets.gen.dart';

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
            );
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
            'Looking for matches...',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          recognitionFailed: (request) {
            return _RecognitionFailedView(
              onRetry: () => context.read<SampleRecorderCubit>().recordSample(),
            );
          },
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}

class _RecognitionFailedView extends StatelessWidget {
  const _RecognitionFailedView({this.onRetry});

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimens.padding),
      child: Column(
        children: [
          Text(
            'Recognition failed',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: Dimens.space),
          Text(
            'No match found', // TODO: fix this with reason
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: Dimens.doubleSpace),
          SizedBox(
            height: Dimens.buttonHeight,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimens.radius)),
              ),
              child: Text(
                'Try again',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
