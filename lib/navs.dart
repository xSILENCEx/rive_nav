import 'package:flutter/cupertino.dart';

import 'nav_bars/aiqiyi_nav_bar.dart';
import 'nav_bars/xiaomi_nav_bar.dart';

///导航栏数据
class NavModle {
  const NavModle({
    required this.tag,
    required this.title,
    required this.filePath,
    required this.icons,
    this.idle = 'idle',
    this.active = 'active',
  });

  final String tag;

  ///标题
  final String title;

  ///rive文件路径
  final String filePath;

  ///rive文件名称
  final List<String> icons;

  ///闲置状态
  final String idle;

  ///激活状态
  final String active;
}

///导航栏数据列表
const List<NavModle> navs = <NavModle>[
  NavModle(
    tag: 'xiaomi',
    title: '小米商店导航栏',
    filePath: 'riv_files/xiaomi/nav_',
    icons: <String>['home', 'game', 'star', 'pkg', 'me'],
  ),
  NavModle(
    tag: 'aiqiyi',
    title: '爱奇艺导航栏',
    filePath: 'riv_files/aiqiyi/nav_',
    icons: <String>['home', 'fire', 'vip', 'find', 'my'],
  ),
];

///导航栏样式
Widget navBars(NavModle modle) {
  switch (modle.tag) {
    case 'xiaomi':
      return XiaomiNavBar(navModle: modle);
    case 'aiqiyi':
      return AiqiyiNavBar(navModle: modle);
    default:
      return const SizedBox.shrink();
  }
}
