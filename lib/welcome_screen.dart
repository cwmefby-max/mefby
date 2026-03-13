
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  bool _showSlider = false;
  late AnimationController _arrowAnimationController;
  late Animation<Offset> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _arrowAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: const Offset(0.1, 0),
    ).animate(_arrowAnimationController);
  }

  @override
  void dispose() {
    _arrowAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF303030),
              Colors.black,
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: [
                  TyperAnimatedText(
                    'Hello Mefby!',
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                ],
                onFinished: () {
                  setState(() {
                    _showSlider = true;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              bottom: _showSlider ? 50 : -100,
              left: 20,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _showSlider ? 1.0 : 0.0,
                child: SlideAction(
                  borderRadius: 12,
                  innerColor: Colors.black,
                  outerColor: Colors.white.withAlpha(204),
                  sliderButtonIcon: const Icon(Icons.lock, color: Colors.white),
                  onSubmit: () {
                    context.go('/home');
                    return null;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SlideTransition(
                        position: _arrowAnimation,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Slide to unlock bike',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
