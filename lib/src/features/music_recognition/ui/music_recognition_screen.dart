import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequence/src/core/theme/dimens.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/music_recognizer/music_recognizer_state.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_cubit.dart';
import 'package:sequence/src/features/music_recognition/logic/sample_recorder/sample_recorder_state.dart';

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
      appBar: AppBar(toolbarHeight: 0),
      body: BlocListener<MusicRecognizerCubit, MusicRecognizerState>(
        listener: (context, state) {
          state.whenOrNull(
            recognitionLoading: (request) {
              // TODO: show loader
            },
            recognitionSucceeded: (request, response) {
              // TODO: navigate to audio details
              // context.router.push(route)
            },
            recognitionFailed: (request) {
              // TODO: show error
            },
          );
        },
        child: BlocListener<SampleRecorderCubit, SampleRecorderState>(
            listener: (context, state) {
              state.whenOrNull(
                recordSuccessful: (filePath) {
                  context.read<MusicRecognizerCubit>().recognize(filePath: filePath);
                },
              );
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Start Recognition',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: Dimens.space),
                  const _RecordButton(),
                  const SizedBox(height: Dimens.space),
                  const _RecognitionStatus(),
                ],
              ),
            )),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SampleRecorderCubit, SampleRecorderState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => ElevatedButton(
            onPressed: () => context.read<SampleRecorderCubit>().recordSample(),
            child: const Text('Start recognition'),
          ),
          recordPending: () => const CircularProgressIndicator(),
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
          recognitionSucceeded: (request, response) => Column(
            children: [
              Text('Artiste: ${response.result!.artist}'),
              Text('Titre: ${response.result!.title}'),
              if (response.result!.album != null) Text('Album: ${response.result!.album}'),
            ],
          ),
          recognitionLoading: (request) => const Text('Recognition loading...'),
          orElse: () => const SizedBox(),
        );
      },
    );
  }
}
