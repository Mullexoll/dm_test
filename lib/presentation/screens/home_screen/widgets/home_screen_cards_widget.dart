import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenCardsWidget extends StatelessWidget {
  const HomeScreenCardsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          SvgPicture.asset(
            AppAssets.homeScreenCards,
          ),
          Positioned(
            top: 9,
            left: 13,
            child: Transform.rotate(
              angle: -0.05,
              child: Container(
                width: 120,
                height: 195,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF7054FE).withValues(alpha: 0.8),
                      blurRadius: 20,
                      spreadRadius: 3,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SvgPicture.asset(
            AppAssets.pizzaCard,
          ),
          Positioned(
            top: 20,
            left: 15,
            child: Image.asset(
              AppAssets.pizza,
              width: 121,
              height: 97,
            ),
          ),
          Positioned(
            top: 30,
            right: 0,
            child: Image.asset(
              AppAssets.sushi,
              width: 121,
              height: 97,
            ),
          ),
        ],
      ),
    );
  }
}
