import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sequence/src/core/theme/dimens.dart';
import 'package:sequence/src/features/music_recognition/enums/recognition_failure_reason.dart';

const _shakeCount = 4;
const _shakeOffset = 10.0;
const _animationDuration = Duration(milliseconds: 500);

class RecognitionFailedView extends StatefulWidget {
  final RecognitionFailureReason reason;
  const RecognitionFailedView({
    super.key,
    required this.reason,
    this.onRetry,
  });

  final VoidCallback? onRetry;

  @override
  State<RecognitionFailedView> createState() => _RecognitionFailedViewState();
}

class _RecognitionFailedViewState extends State<RecognitionFailedView> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    _animationController.addStatusListener(_updateStatus);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Waiting for the fade animation to finish
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        shake();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
    }
  }

  void shake() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final sineValue = sin(_shakeCount * 2 * pi * _animationController.value);
        return Transform.translate(
          offset: Offset(sineValue * _shakeOffset, 0),
          child: Padding(
            padding: const EdgeInsets.all(Dimens.padding),
            child: Column(
              children: [
                Text(
                  'Recognition failed',
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(height: Dimens.space),
                Text(
                  () {
                    switch (widget.reason) {
                      case RecognitionFailureReason.noMatchFound:
                        return 'No match found';
                      case RecognitionFailureReason.other:
                        return 'An unexpected error occured. Please try again';
                    }
                  }(), // TODO: fix this with reason
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(height: Dimens.doubleSpace),
                SizedBox(
                  height: Dimens.buttonHeight,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: widget.onRetry,
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
          ),
        );
      },
    );
  }
}
