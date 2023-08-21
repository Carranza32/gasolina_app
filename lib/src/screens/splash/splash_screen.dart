import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(2.3, -1.4),
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Align(
                alignment: const AlignmentDirectional(-35, 1.7),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Center(
                child: Image.asset(
                  'assets/noCode_UI_onLight@3x.png',
                  width: 200,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}