import 'package:flutter/widgets.dart';
import 'package:socially/utils/constants/app_constants.dart';

class ResponsiveLayoutSreen extends StatefulWidget {
  final Widget mobileSreenLayout;
  final Widget webSreenLayout;

  const ResponsiveLayoutSreen({
    super.key,
    required this.mobileSreenLayout,
    required this.webSreenLayout,
  });

  @override
  State<ResponsiveLayoutSreen> createState() => _ResponsiveLayoutSreenState();
}

class _ResponsiveLayoutSreenState extends State<ResponsiveLayoutSreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > webSreenMinWidth) {
          return widget.webSreenLayout;
        } else {
          return widget.mobileSreenLayout;
        }
      },
    );
  }
}
