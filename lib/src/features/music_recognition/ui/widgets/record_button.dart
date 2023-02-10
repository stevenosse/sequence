import 'package:flutter/material.dart';
import 'package:flutter_hicons/flutter_hicons.dart';
import 'package:sequence/src/core/theme/dimens.dart';

class RecordButton extends StatelessWidget {
  const RecordButton({
    super.key,
    this.onRecordPressed,
  });

  final VoidCallback? onRecordPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Dimens.recordButtonSize * 1.5,
          height: Dimens.recordButtonSize * 1.5,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const _Wave(),
              InkWell(
                customBorder: const CircleBorder(),
                onTap: onRecordPressed,
                child: Padding(
                  padding: const EdgeInsets.all(Dimens.padding),
                  child: Container(
                    width: Dimens.recordButtonSize,
                    height: Dimens.recordButtonSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.shadow.withOpacity(.15),
                          blurRadius: 10.0,
                        ),
                      ],
                      gradient: const RadialGradient(
                        tileMode: TileMode.decal,
                        colors: [
                          Color(0xff304FFE),
                          Color(0xff3D5AFE),
                          Color(0xff536DFE),
                        ],
                      ),
                    ),
                    child: Icon(
                      Hicons.microphone_2,
                      size: Dimens.recordButtonSize / 3,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimens.padding),
          child: Text(
            'Tap to start recognition',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ],
    );
  }
}

class _Wave extends StatefulWidget {
  const _Wave();

  @override
  State<_Wave> createState() => __WaveState();
}

class __WaveState extends State<_Wave> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  static const _scale = .4;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    _startAnimation();
    _animationController.addListener(_animationListener);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.removeListener(_animationListener);
    _animationController.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _animationController.forward();
  }

  void _animationListener() {
    if (_animationController.status == AnimationStatus.completed) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        _animationController.forward(from: 0.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: (1 - _animation.value).abs().toDouble(),
          child: Container(
            width: Dimens.recordButtonSize * (_scale + _animation.value),
            height: Dimens.recordButtonSize * (_scale + _animation.value),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(.4),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
