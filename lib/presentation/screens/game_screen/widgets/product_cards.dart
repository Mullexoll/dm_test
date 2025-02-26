import 'package:dayme_test/core/constants/app_assets.dart';
import 'package:dayme_test/data/models/product.model.dart';
import 'package:dayme_test/presentation/blocs/game_bloc/game_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProductCards extends StatefulWidget {
  final List<Product> products;
  final int currentLevel;

  const ProductCards({
    super.key,
    required this.products,
    required this.currentLevel,
  });

  @override
  State<ProductCards> createState() => _ProductCardsState();
}

class _ProductCardsState extends State<ProductCards> {
  Product? product1;
  Product? product2;
  bool isLikedProduct1 = false;
  bool isLikedProduct2 = false;

  @override
  void initState() {
    super.initState();

    if (widget.products.length >= 2) {
      product1 = widget.products[0];
      product2 = widget.products[1];
    }
  }

  void toggleLikeProduct1() {
    setState(() {
      isLikedProduct1 = !isLikedProduct1;
      if (isLikedProduct2) {
        isLikedProduct2 = false;
      }
    });
    if (isLikedProduct1) {
      BlocProvider.of<GameBloc>(context).add(
        GameSelectProductEvent(
          selectedProductId: product1?.id ?? 0,
          secondProductId: product2?.id ?? 0,
          currentLevel: widget.currentLevel,
        ),
      );
    } else {
      BlocProvider.of<GameBloc>(context).add(
        GameDeselectProductEvent(
          productId: product1?.id ?? 0,
          currentLevel: widget.currentLevel,
        ),
      );
    }
  }

  void toggleLikeProduct2() {
    setState(() {
      isLikedProduct2 = !isLikedProduct2;
      if (isLikedProduct1) {
        isLikedProduct1 = false;
      }
      if (isLikedProduct2) {
        BlocProvider.of<GameBloc>(context).add(
          GameSelectProductEvent(
            selectedProductId: product2?.id ?? 0,
            secondProductId: product1?.id ?? 0,
            currentLevel: widget.currentLevel,
          ),
        );
      } else {
        BlocProvider.of<GameBloc>(context).add(
          GameDeselectProductEvent(
            productId: product2?.id ?? 0,
            currentLevel: widget.currentLevel,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print('image ${product1?.photoUrl} ${product2?.photoUrl}');

    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = (screenWidth - 45) / 2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: containerWidth,
          height: 319,
          padding:
              const EdgeInsets.only(top: 16, bottom: 20, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(208, 216, 255, 0.5),
                spreadRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.network(
                product1?.photoUrl ?? '',
                width: 150,
                height: 150,
              ),
              Gap(16),
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  child: Text(
                    product1?.name ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Gap(7),
              InkWell(
                onTap: toggleLikeProduct1,
                child: SvgPicture.asset(
                  isLikedProduct1
                      ? AppAssets.activeLikeIcon
                      : AppAssets.defaultLikeIcon,
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        Container(
          width: containerWidth,
          height: 319,
          padding:
              const EdgeInsets.only(top: 16, bottom: 20, left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(208, 216, 255, 0.5),
                spreadRadius: 4,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            children: [
              Image.network(
                product2?.photoUrl ?? '',
                width: 150,
                height: 150,
              ),
              Gap(16),
              SizedBox(
                height: 60,
                child: SingleChildScrollView(
                  child: Text(
                    product2?.name ?? '',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Gap(7),
              InkWell(
                onTap: toggleLikeProduct2,
                child: SvgPicture.asset(
                  isLikedProduct2
                      ? AppAssets.activeLikeIcon
                      : AppAssets.defaultLikeIcon,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
