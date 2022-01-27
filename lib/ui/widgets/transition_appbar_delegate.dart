import 'package:flutter/material.dart';

class TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarTween = SizeTween(begin: Size(200, 200), end: Size(110, 110));
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.fromLTRB(0, 0, 0, 30),
      end: EdgeInsets.fromLTRB(0, 50, 50, 30));
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.bottomRight);

  final _titleMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(left: 20, top: 80),
      end: EdgeInsets.only(left: 60, top: 32));
  final _titleSizeTween = IntTween(begin: 240, end: 400);

  final _addiTitleMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(left: 144, top: 50),
      end: EdgeInsets.only(left: 360, top: 31));
  final _addiTitleFontSizeTween = IntTween(begin: 72, end: 40);

  final _subtitleMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(left: 20, top: 110),
      end: EdgeInsets.only(left: 50, top: 91));

  final _bgAlignmentXTween = IntTween(begin: 30, end: 70);
  final _bgAlignmentYTween = IntTween(begin: 40, end: 30);
  final _bgAlignmentRTween = IntTween(begin: 16, end: 20);

  final _barMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 320), end: EdgeInsets.only(top: 200));

  final _visibilityTween = IntTween(begin: 0, end: 100);

  final Widget avatar;
  final Widget avatarBg;
  final String title;
  final String addiTitle;
  final Widget subtitle;
  final List<Color> bgColors;
  final Widget bar;

  TransitionAppBarDelegate(
      {required this.avatar,
      required this.avatarBg,
      required this.title,
      required this.addiTitle,
      required this.subtitle,
      required this.bgColors,
      required this.bar})
      : assert(avatar != null),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = (shrinkOffset / 130.0).clamp(0, 1.0).toDouble();

    final avatarSize = _avatarTween.lerp(progress);
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);

    final titleMargin = _titleMarginTween.lerp(progress);
    final titleSize = _titleSizeTween.lerp(progress);

    final addiTitleMargin = _addiTitleMarginTween.lerp(progress);
    final addiTitleFontSize = _addiTitleFontSizeTween.lerp(progress);

    final subtitleMargin = _subtitleMarginTween.lerp(progress);

    final bgX = _bgAlignmentXTween.lerp(progress);
    final bgY = _bgAlignmentYTween.lerp(progress);
    final bgR = _bgAlignmentRTween.lerp(progress);

    final barMargin = _barMarginTween.lerp(progress);

    final visibility = _visibilityTween.lerp(progress);

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: shrinkOffset * 2,
          constraints: BoxConstraints(maxHeight: minExtent),
          decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: bgColors,
                radius: bgR / 10,
                center: Alignment(bgX / 100, bgY / 100)),
          ),
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox.fromSize(size: avatarSize, child: avatarBg),
          ),
        ),
        Padding(
          padding: avatarMargin,
          child: Align(
            alignment: avatarAlign,
            child: SizedBox.fromSize(size: avatarSize, child: avatar),
          ),
        ),
        Padding(
          padding: addiTitleMargin,
          child: Text(
            addiTitle,
            style: TextStyle(
                color: Colors.white24,
                fontSize: addiTitleFontSize.toDouble(),
                letterSpacing: 2.0,
                fontWeight: FontWeight.w900),
          ),
        ),
        Padding(
          padding: titleMargin,
          child: Text(
            title,
            style: TextStyle(
                fontSize: titleSize / 10,
                color: Color.fromRGBO(255, 255, 255, visibility / 100),
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800),
          ),
        ),
        Opacity(
          opacity: visibility / 100,
          child: Padding(
            padding: subtitleMargin,
            child: subtitle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20 + 10, left: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: barMargin,
          child: bar,
        )
      ],
    );
  }

  @override
  double get maxExtent => 350.0;

  @override
  double get minExtent => 230.0;

  @override
  bool shouldRebuild(TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}
