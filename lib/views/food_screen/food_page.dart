import 'package:flutter/material.dart';
import 'package:flutter_food/services/cart_service.dart';
import 'package:flutter_food/views/food_screen/food_page_store.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => FoodPageStore(service: CartService()),
      child: const FoodPage(),
    );
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  FoodPageStore? store;

  @override
  void initState() {
    super.initState();
    store = context.read();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(24, 24, 24, 1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: Colors.amberAccent, width: 2)),
                          height: MediaQuery.of(context).size.height / 3.6,
                          width: MediaQuery.of(context).size.width / 1.2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              fit: BoxFit.cover,
                              "${selectedFood!.foodImage}",
                              cacheWidth: 500,
                              cacheHeight: 500,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return const Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ));
                                } else {
                                  return child;
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.image_not_supported_rounded,
                                  size: 100,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 12),
                          child: Row(
                            children: [
                              Text(
                                '${selectedFood!.name}',
                                style: const TextStyle(color: Colors.white),
                                textScaler: const TextScaler.linear(1.7),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                applyTextScaling: true,
                              ),
                              Text(
                                '${selectedFood!.avaliation}',
                                style: const TextStyle(color: Colors.white),
                                textScaler: const TextScaler.linear(1.7),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: const Alignment(-0.8, 0),
                          child: Text(
                            '\$ ${selectedFood!.price}',
                            style: const TextStyle(color: Colors.white),
                            textScaler: const TextScaler.linear(1.7),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 1.2,
                            child: Text(
                              'Description: ${selectedFood!.description}',
                              style: const TextStyle(color: Colors.white),
                              textScaler: const TextScaler.linear(1.7),
                            )),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0, 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            selectedFood!;
                            store!.postFoodCart(selectedFood!);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                'Product added to Cart',
                                style: TextStyle(color: Colors.white),
                                textScaler: TextScaler.linear(1.5),
                              ),
                              backgroundColor: Color.fromRGBO(39, 39, 42, 1),
                            ));
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.amberAccent)),
                          child: const Text(
                            'Add to Cart',
                            textScaler: TextScaler.linear(1.5),
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 6,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.amberAccent)),
                          child: const Text(
                            'Buy now',
                            textScaler: TextScaler.linear(1.5),
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
