import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Color.fromRGBO(154, 127, 255, 1),
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Center(
        child: Text(
          'або',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}
