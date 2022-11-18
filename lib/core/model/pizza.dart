class Pizza {
  String id;
  String asset;
  String name;
  String description;
  int reviews;
  int rating;
  double price;
  List<String> components;

  Pizza({
    required this.id,
    required this.asset,
    required this.name,
    required this.description,
    required this.reviews,
    required this.rating,
    required this.price,
    required this.components,
  });

  static List<Pizza> pizzaList = [
    Pizza(
        id: 'P-2',
        asset: 'assets/images/img2.png',
        name: 'Veggie 6 Quesos',
        description:
            'Mix de seis quesos, cebolla, pimientos verdes, tomate, aceitunas negras, champiñones y sazonador italiano',
        reviews: 140,
        rating: 4,
        price: 34.90,
        components: ['450 cal', '1 cebolla', '2 queso', '4 tomates']),
    Pizza(
        id: 'P-3',
        asset: 'assets/images/img3.png',
        name: 'Vegan Royal',
        description:
            'Queso Vegano, champiñones, pimiento, aceitunas, carne NotMeat y orégano',
        reviews: 18,
        rating: 3,
        price: 34.90,
        components: ['7 pimiento', '1/4 champiñones']),
    Pizza(
        id: 'P-4',
        name: 'Mini Cheesesticks',
        asset: 'assets/images/img4.png',
        description:
            'Nuestros deliciosos cheesesticks, también conocido como palitos de queso',
        reviews: 1800,
        rating: 5,
        price: 24.90,
        components: ['salsa de ajo', 'masa fresca', '1/4 Mozzarella']),
    Pizza(
        id: 'P-5',
        asset: 'assets/images/img5.png',
        name: 'Pizza Americana',
        description:
            'Una de las Pizzas Más Clásica: Pizza Americana Entre sus ingredientes, encontrarás',
        reviews: 320,
        rating: 4,
        price: 24.90,
        components: ['4 mozzarella', '1/4 Jamón']),
    Pizza(
        id: 'P-6',
        asset: 'assets/images/img6.png',
        name: 'Pizza Súper Margarita',
        description: 'Prueba nuestra deliciosa Pizza Súper Margarita 6 Quesos',
        reviews: 50,
        rating: 3,
        price: 29.9,
        components: ['Tomate', 'Oregano', '6 Quesos']),
    Pizza(
        id: 'P-7',
        asset: 'assets/images/img7.png',
        name: 'Española',
        description:
            'Nuestra Pizza Española incluye Chorizo, champiñones y salsa de ajo',
        reviews: 95,
        rating: 2,
        price: 24.9,
        components: ['Mozarella', 'Cebolla', "Aceitunas"]),
    Pizza(
        id: 'P-8',
        asset: 'assets/images/img8.png',
        name: "Pizza Chicken Bbq",
        description:
            '¿Ya probeste nuestra Pizza Chicken BBQ? Esta deliciosa pizza tiene pollo a la parrilla, salsa bbq y tocino. ¿Se te antoja?',
        reviews: 22,
        rating: 4,
        price: 34.9,
        components: [
          'Mozzarella',
          'Salsa barbacoa',
          "Pollo a la parrilla",
          "Tocino"
        ]),
    Pizza(
        id: 'P-9',
        asset: 'assets/images/img9.png',
        name: "Pizza Vegetariana",
        description:
            '¡La garden Vegi es La Mejor Pizza Vegetariana que probarás!',
        reviews: 69,
        rating: 5,
        price: 24.9,
        components: [
          'Aceitunas Negras',
          'Cebolla',
          "Mozarella",
        ]),
  ];
}
