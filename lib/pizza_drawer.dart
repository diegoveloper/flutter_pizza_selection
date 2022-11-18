import 'package:flutter/material.dart';
import 'package:flutter_pizza_selection/core/theme/color_theme.dart';
import 'package:flutter_pizza_selection/main.dart';

import 'core/model/pizza.dart';

class PizzaDrawer extends StatelessWidget {
  const PizzaDrawer({required this.pizzas, super.key});

  final List<Pizza> pizzas;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: ColorTheme.pink,
      ),
      child: ListView.builder(
        itemCount: pizzas.length,
        itemBuilder: (context, index) {
          final pizza = pizzas[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: CircularPizza(
              pizza: pizza,
              size: 80,
            ),
          );
        },
      ),
    );
  }
}
