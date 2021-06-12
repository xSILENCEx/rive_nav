import 'package:flutter/material.dart';
import 'package:rive_nav/navs.dart';
import 'package:rive_nav/rive_icon.dart';

///爱奇艺导航栏
class AiqiyiNavBar extends StatefulWidget {
  const AiqiyiNavBar({Key? key, required this.navModle}) : super(key: key);

  @override
  _AiqiyiNavBarState createState() => _AiqiyiNavBarState();

  final NavModle navModle;
}

class _AiqiyiNavBarState extends State<AiqiyiNavBar> {
  late String _navTag;

  @override
  void initState() {
    super.initState();
    _navTag = widget.navModle.icons.first;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight + 20,
      color: Colors.white,
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        children: widget.navModle.icons
            .map((String icon) => _buildItem(icon))
            .toList(),
      ),
    );
  }

  Widget _buildItem(String icon) {
    return Expanded(
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          _navTag = icon;
          setState(() {});
        },
        child: SizedBox(
          height: kBottomNavigationBarHeight + 20,
          child: Column(
            children: <Widget>[
              Expanded(
                child: RiveIcon(
                  rivPath: '${widget.navModle.filePath}$icon.riv',
                  isSelected: _navTag == icon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, top: 6),
                child: Text(icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
