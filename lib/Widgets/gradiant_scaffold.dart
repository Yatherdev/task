import 'package:flutter/material.dart';

import '../Model/custom_color.dart';

class GradientScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Color> gradientColors;
  final AppBar? appBar;
  final Widget? floatingActionButton;

  const GradientScaffold({
    super.key,
    required this.body,
    this.title,
    this.gradientColors = const [
      CustomColors.oxygenated,
      CustomColors.arterial,
      CustomColors.venous,
      CustomColors.clotted,
      CustomColors.dried,
    ],
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar ??
          (title != null
              ? AppBar(
                title: Text(title!),
                backgroundColor: Colors.transparent,
                elevation: 0,
              )
              : null),
      extendBodyBehindAppBar: true,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
