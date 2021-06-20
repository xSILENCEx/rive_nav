import 'package:flutter/material.dart';
import 'package:rive_nav/navs.dart';
import 'package:rive_nav/rive_icon.dart';

///小米导航栏
class XiaomiNavBar extends StatefulWidget {
  const XiaomiNavBar({Key? key, required this.navModle}) : super(key: key);

  @override
  _XiaomiNavBarState createState() => _XiaomiNavBarState();

  final NavModle navModle;
}

class _XiaomiNavBarState extends State<XiaomiNavBar> {
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
      height: kBottomNavigationBarHeight + 30,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: kBottomNavigationBarHeight + 20,
            color: Colors.white,
          ),
          Row(
            children: widget.navModle.icons
                .map((String icon) => _buildItem(icon))
                .toList(),
          ),
        ],
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
          height: kBottomNavigationBarHeight + 30,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                width: kBottomNavigationBarHeight,
                height: kBottomNavigationBarHeight,
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: _navTag == icon ? 30 : 20),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                  width: double.infinity,
                  height: double.infinity,
                  child: RiveIcon(
                    rivPath: '${widget.navModle.filePath}$icon.riv',
                    animation: _navTag == icon ? 'active' : 'idle',
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: _navTag == icon
                          ? <Color>[
                              Colors.orange.withOpacity(0.8),
                              Colors.orange,
                            ]
                          : <Color>[Colors.white, Colors.white],
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(icon),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
