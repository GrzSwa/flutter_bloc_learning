import 'package:block_learning/presentation/screens/login/widgets/clipper_widget.dart';
import 'package:flutter/material.dart';

class LoginLogo extends StatelessWidget {
  const LoginLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Warstwa cienia
        ClipPath(
          clipper: ClipperWidget(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.453,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2), // Kolor cienia
                    offset: const Offset(0, 0), // Przesunięcie cienia
                    blurRadius: 10,
                    spreadRadius: 5 // Promień rozmycia cienia
                    ),
              ],
            ),
          ),
        ),

        // Warstwa główna
        ClipPath(
          clipper: ClipperWidget(),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF1f2c4c),
                  Color(0xFF304c95),
                  Color(0xFF3760be),
                  Color(0xFF558edc)
                ],
                begin: Alignment.bottomRight,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png'),
                const Text(
                  "Czas pracy",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
