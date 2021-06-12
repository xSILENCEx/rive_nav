import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

///rive图标封装
class RiveIcon extends StatefulWidget {
  const RiveIcon({
    Key? key,
    required this.isSelected,
    required this.rivPath,
    this.idle = 'idle',
    this.active = 'active',
  }) : super(key: key);

  ///是否选中
  final bool isSelected;

  ///文件路径
  final String rivPath;

  ///闲置状态
  final String idle;

  ///激活状态
  final String active;

  @override
  _RiveIconState createState() => _RiveIconState();
}

class _RiveIconState extends State<RiveIcon> {
  ///画布
  Artboard? _riveArtboard;

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
    if (oldWidget.isSelected != widget.isSelected) {
      widget.isSelected ? _select() : _unSelect();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _riveArtboard?.remove();
    super.dispose();
  }

  ///选中
  void _select() {
    _riveArtboard?.removeController(SimpleAnimation(widget.idle));
    _riveArtboard?.addController(SimpleAnimation(widget.active));
  }

  ///未选中
  void _unSelect() {
    _riveArtboard?.removeController(SimpleAnimation(widget.active));
    _riveArtboard?.addController(SimpleAnimation(widget.idle));
  }

  ///初始化
  Future<void> _init() async {
    _riveArtboard =
        RiveFile.import(await rootBundle.load(widget.rivPath)).mainArtboard;

    setState(() {});

    widget.isSelected ? _select() : _unSelect();
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? const SizedBox.shrink()
        : Rive(artboard: _riveArtboard!);
  }
}
