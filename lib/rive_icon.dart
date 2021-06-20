import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

///rive图标封装
class RiveIcon extends StatefulWidget {
  const RiveIcon({
    Key? key,
    required this.rivPath,
    required this.animation,
  }) : super(key: key);

  ///文件路径
  final String rivPath;

  ///动画名
  final String animation;

  @override
  _RiveIconState createState() => _RiveIconState();
}

class _RiveIconState extends State<RiveIcon> {
  ///画布
  Artboard? _riveArtboard;

  ///当前动画控制器
  late SimpleAnimation _currentAnimationController;

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void didUpdateWidget(covariant RiveIcon oldWidget) {
    if (oldWidget.animation != widget.animation) {
      _update(widget.animation);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _riveArtboard?.remove();
    super.dispose();
  }

  ///初始化
  Future<void> _init() async {
    _currentAnimationController = SimpleAnimation(widget.animation);

    _riveArtboard =
        RiveFile.import(await rootBundle.load(widget.rivPath)).mainArtboard;

    setState(() {});

    _update(widget.animation);
  }

  ///切换动画
  void _update(String newAnimation) {
    _riveArtboard?.removeController(_currentAnimationController);
    _currentAnimationController = SimpleAnimation(newAnimation);
    _riveArtboard?.addController(_currentAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? const SizedBox.shrink()
        : Rive(artboard: _riveArtboard!);
  }
}
