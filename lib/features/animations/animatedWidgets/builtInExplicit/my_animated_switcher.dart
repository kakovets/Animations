import 'package:animations/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/theme_provider.dart';

class MyAnimatedSwitcher extends StatefulWidget {
  const MyAnimatedSwitcher({super.key});

  @override
  State<MyAnimatedSwitcher> createState() => _MyAnimatedSwitcherState();
}

class _MyAnimatedSwitcherState extends State<MyAnimatedSwitcher> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (
              Widget child,
              Animation<double> animation,
              ) {
            return ScaleTransition(
              scale: animation,
              child: RotationTransition(
                turns: animation,
                child: child,
              ),
            );
          },
          child: InkWell(
            key: ValueKey<bool>(themeProvider.themeData == lightMode),
            borderRadius: BorderRadius.circular(25),
            onTap: () => themeProvider.toggleTheme(),
            child: Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                themeProvider.themeData == lightMode
                    ? 'assets/icons/night.svg'
                    : 'assets/icons/day.svg',
                width: 30,
                height: 30,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}