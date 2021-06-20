import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rive_nav/rive_icon.dart';

import 'navs.dart';

///刷新盒子
class RefreshBody extends StatefulWidget {
  const RefreshBody({Key? key, required this.nav}) : super(key: key);

  @override
  _RefreshBodyState createState() => _RefreshBodyState();

  final NavModle nav;
}

class _RefreshBodyState extends State<RefreshBody> {
  final RefreshController _controller = RefreshController();

  int _count = 40;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Future<void>.delayed(const Duration(seconds: 2), () {});
    _count = 40;
    setState(() {});

    _controller.refreshCompleted();
    _controller.loadComplete();
  }

  Future<void> _load() async {
    await Future<void>.delayed(const Duration(seconds: 2), () {});
    if (_count < 100) {
      _count += 20;
      _controller.loadComplete();
    } else {
      _footerText = '没有更多了';
      _controller.loadNoData();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: kBottomNavigationBarHeight + 20),
        child: SmartRefresher(
          physics: const BouncingScrollPhysics(),
          controller: _controller,
          header: _header,
          footer: _footer,
          enablePullUp: true,
          enablePullDown: true,
          child: ListView.separated(
            itemCount: _count,
            itemBuilder: (_, int i) => ListTile(
              leading: ActionChip(label: Text(i.toString()), onPressed: () {}),
              title: Text(widget.nav.title),
              subtitle: Text(widget.nav.tag),
            ),
            separatorBuilder: (_, __) => const Divider(),
          ),
          onRefresh: _refresh,
          onLoading: _load,
        ),
      ),
      floatingActionButton: navBars(widget.nav),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  CustomHeader get _header {
    return CustomHeader(
      height: 80,
      builder: (_, RefreshStatus? status) {
        String content = 'turn';

        switch (status) {
          case RefreshStatus.idle:
            content = 'open';
            break;
          case RefreshStatus.canRefresh:
            content = 'open';
            break;
          case RefreshStatus.refreshing:
            content = 'turn';
            break;
          case RefreshStatus.completed:
            content = 'close';
            break;
          default:
            content = 'open';
            break;
        }

        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: RiveIcon(rivPath: 'riv_files/book.riv', animation: content),
        );
      },
    );
  }

  CustomFooter get _footer {
    return CustomFooter(
      height: 80,
      builder: (_, LoadStatus? status) {
        return Container(
          height: 80,
          padding: const EdgeInsets.symmetric(vertical: 20),
          alignment: Alignment.center,
          child: status == LoadStatus.noMore
              ? const Text('noMore')
              : const RiveIcon(
                  rivPath: 'riv_files/book.riv', animation: 'turn'),
        );
      },
    );
  }
}
