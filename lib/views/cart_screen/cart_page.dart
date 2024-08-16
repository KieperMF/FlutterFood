import 'package:flutter/material.dart';
import 'package:flutter_food/services/cart_service.dart';
import 'package:flutter_food/views/cart_screen/cart_store.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => CartStore(service: CartService()),
      child: const CartPage(),
    );
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  CartStore? store;

  @override
  void initState() {
    super.initState();
    store = context.read();
    load();
  }

  void load() {
    store!.getCartProducts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    store = context.watch();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
          textScaler: TextScaler.linear(1.3),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: RefreshIndicator(
            onRefresh: () => store!.getCartProducts(),
            child: Column(
              children: [
                if (store!.cartProducts.isNotEmpty) ...[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1,
                    child: ListView.builder(
                        itemCount: store!.cartProducts.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  color: const Color.fromRGBO(38, 38, 38, 1),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              '${store!.cartProducts[index].foodImage}',
                                              cacheWidth: 500,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress != null) {
                                                  return const Icon(
                                                    Icons.image,
                                                    size: 100,
                                                    color: Colors.white,
                                                  );
                                                } else {
                                                  return child;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '${store!.cartProducts[index].name}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                            textScaler:
                                                const TextScaler.linear(1.3),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    content: const Text(
                                                      'Remove this food from cart?',
                                                      textScaler:
                                                          TextScaler.linear(
                                                              1.3),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            store!.deleteFoodFromCart(
                                                                store!.cartProducts[
                                                                    index], index);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Remove')),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Cancel'))
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(
                                            Icons.delete_rounded,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ] else ...[
                  const Text(
                    'Cart Empty',
                    textScaler: TextScaler.linear(1.5),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
