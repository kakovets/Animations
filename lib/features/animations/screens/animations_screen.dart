import 'package:flutter/material.dart';
import '../../../core/widgets/my_custom_scroll_view.dart';
import '../widgets/divider_with_text.dart';
import '../animatedWidgets/barrel.dart';

class AnimationsScreen extends StatefulWidget {
  const AnimationsScreen({super.key});

  @override
  State<AnimationsScreen> createState() => _AnimationsScreenState();
}

class _AnimationsScreenState extends State<AnimationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const MyCustomScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

              DividerWithText(text: 'Implicit',),

              MyAnimatedAlignRotation(),

              SizedBox(height: 30,),

              MyAnimatedOpacity(),

              SizedBox(height: 30,),

              MyAnimatedContainer(),

              SizedBox(height: 30,),

              HeaterSwitch(),

              DividerWithText(text: 'TweenAnimationBuilder',),

              MyTweenAnimationBuilder(),

              DividerWithText(text: 'Built-in Explicit',),

              MyAnimatedSwitcher(),

              MyFadeTransition(),

              MySlideTransition(),

              DividerWithText(text: 'Custom Explicit',),

              MyScalingAnimation(),

              SizedBox(height: 30,),

              DiceIconButton(),

              HeaterTemp(),

              SizedBox(height: 100,),

              MyAnimatedWidget(),

              SizedBox(height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}