import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pizza_selection/core/model/pizza.dart';
import 'package:flutter_pizza_selection/core/model/shopping.dart';
import 'package:flutter_pizza_selection/core/theme/color_theme.dart';

import 'pizza_drawer.dart';

void main() {
  runApp(const MyApp());
}

const _pizzaMovementDuration = Duration(milliseconds: 1900);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeWidget(),
    );
  }
}

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final pageController = PageController();
  double page = 0;
  Pizza pizza = Pizza.pizzaList.first;
  final shopping = Shopping();

  void _onListener() {
    setState(() {
      page = pageController.page ?? 0;
    });
  }

  @override
  void initState() {
    pageController.addListener(_onListener);
    super.initState();
  }

  @override
  void dispose() {
    pageController.removeListener(_onListener);
    pageController.dispose();
    super.dispose();
  }

  void _animateTo(
    int page, {
    Duration duration = const Duration(milliseconds: 700),
  }) {
    if (page < 0 || page > Pizza.pizzaList.length - 1) return;
    pageController.animateToPage(
      page.round(),
      duration: duration,
      curve: Curves.elasticOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      endDrawer: Drawer(
        width: 120,
        child: PizzaDrawer(
          pizzas: shopping.pizzas,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(builder: (context, constraints) {
              final height = constraints.maxHeight;
              final width = constraints.maxWidth;
              final size = width * 0.6;
              final backgroundPosition = -height / 2;
              return Stack(
                children: [
                  // Create the background
                  Positioned(
                    top: backgroundPosition,
                    left: backgroundPosition,
                    right: backgroundPosition,
                    bottom: size / 2,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        color: ColorTheme.pinkLight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),

                  //Create the pizza
                  Listener(
                    onPointerUp: (_) {
                      _animateTo(page.round());
                    },
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: Pizza.pizzaList.length,
                        onPageChanged: (index) {
                          pizza = Pizza.pizzaList[index];
                        },
                        itemBuilder: (context, index) {
                          final pizza = Pizza.pizzaList[index];
                          final percent = page - index;
                          final opacity = 1.0 - percent.abs();
                          final verticalSpace = size / 1.2;
                          final radius = height - verticalSpace;
                          final x = radius * sin(percent);
                          final y =
                              radius * cos(percent) - height + verticalSpace;

                          return Opacity(
                            opacity:
                                opacity < 0.3 ? 0.0 : opacity.clamp(0.0, 1.0),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.001)
                                ..translate(x, y)
                                ..rotateZ(percent),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: CircularPizza(
                                  pizza: pizza,
                                  size: size,
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),

                  Positioned(
                    top: MediaQuery.of(context).viewPadding.top,
                    left: 20,
                    child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: ColorTheme.pinkBlack,
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PizzaTitle(
                    pizza: pizza,
                    onTapLeft: () {
                      _animateTo(
                        page.round() - 1,
                        duration: _pizzaMovementDuration,
                      );
                    },
                    onTapRight: () {
                      _animateTo(
                        page.round() + 1,
                        duration: _pizzaMovementDuration,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  (index + 1) <= pizza.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow[700],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('${pizza.reviews} reviews'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(pizza.description),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              '\$${pizza.price.toStringAsPrecision(2)}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Wrap(
                                children: List.generate(
                                  pizza.components.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                      vertical: 3.0,
                                    ),
                                    child: Container(
                                      color: ColorTheme.pinkLight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          pizza.components[index],
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        MaterialButton(
                            color: Colors.black,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.shop,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Add to cart',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                            onPressed: () {
                              shopping.add(pizza);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircularPizza extends StatelessWidget {
  const CircularPizza({
    Key? key,
    required this.pizza,
    required this.size,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final Pizza pizza;
  final double size;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: Padding(
        padding: padding,
        child: ClipOval(
          child: Image.asset(
            pizza.asset,
            height: size,
          ),
        ),
      ),
    );
  }
}

class _PizzaTitle extends StatelessWidget {
  const _PizzaTitle({
    required this.pizza,
    this.onTapLeft,
    this.onTapRight,
  });

  final Pizza pizza;
  final VoidCallback? onTapLeft;
  final VoidCallback? onTapRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          InkWell(
            onTap: () => onTapLeft?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_back,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                pizza.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onTapRight?.call(),
            child: const CircleAvatar(
              backgroundColor: ColorTheme.pinkLight,
              child: Icon(
                Icons.arrow_forward,
                color: ColorTheme.pinkBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
