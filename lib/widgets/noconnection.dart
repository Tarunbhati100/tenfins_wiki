import 'package:flutter/material.dart';
import 'package:tenfins_wiki/utils/color.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uh-Oh!',
              style: TextStyle(
                fontSize: 25,
                letterSpacing: 1,
                color: AppColor.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Slow or no internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your internet settings and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                letterSpacing: 1,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
