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
  void didChangeDependencies() {
    super.didChangeDependencies();
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
        child: RefreshIndicator(
          onRefresh: () => store!.refresh(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Subtotal \$${store!.totalprice} (${store!.cartProducts.length} items)",
                        style: const TextStyle(
                            color: Colors.white, fontStyle: FontStyle.italic),
                        textScaler: const TextScaler.linear(1.5),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    store!.cartProducts.isNotEmpty
                        ? TextButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.yellow)),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.black),
                                          textScaler: TextScaler.linear(1.5),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              content: const Text(
                                                'Thanks for the prefrerence',
                                                textScaler:
                                                    TextScaler.linear(1.4),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    textScaler:
                                                        TextScaler.linear(1.5),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                          store!.payment();
                                        },
                                        child: const Text(
                                          'Confirm',
                                          style: TextStyle(color: Colors.black),
                                          textScaler: TextScaler.linear(1.5),
                                        ),
                                      ),
                                    ],
                                    content: Text(
                                      'Confirm payment of \$${store!.totalprice}',
                                      textScaler: const TextScaler.linear(1.4),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Buy',
                              style: TextStyle(color: Colors.black),
                              textScaler: TextScaler.linear(1.4),
                            ))
                        : const Text(''),
                  ],
                ),
                if (store!.cartProducts.isNotEmpty) ...[
                  Column(
                    children:
                        List.generate(store!.cartProducts.length, (index) {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.yellow),
                                      color:
                                          const Color.fromRGBO(38, 38, 38, 1)),
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${store!.cartProducts[index].name}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textScaler:
                                                  const TextScaler.linear(1.5),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${store!.cartProducts[index].price}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textScaler:
                                                      const TextScaler.linear(
                                                          1.3),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                  size: 24,
                                                ),
                                                Text(
                                                  '${store!.cartProducts[index].avaliation}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  textScaler:
                                                      const TextScaler.linear(
                                                          1.3),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: const Alignment(1, -0.5),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: const Text(
                                              'Remove from cart?',
                                              style: TextStyle(
                                                  color: Colors.black),
                                              textScaler:
                                                  TextScaler.linear(1.3),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                              TextButton(
                                                  onPressed: () {
                                                    store!.deleteFoodFromCart(
                                                        store!.cartProducts[
                                                            index],
                                                        index);
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                            const SnackBar(
                                                      content: Text(
                                                        'Product removed',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        textScaler:
                                                            TextScaler.linear(
                                                                1.5),
                                                      ),
                                                      backgroundColor:
                                                          Color.fromRGBO(
                                                              39, 39, 42, 1),
                                                    ));
                                                  },
                                                  child: const Text(
                                                    'Remove',
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.delete_rounded,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ] else ...[
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Text(
                        'Cart Empty',
                        style: TextStyle(color: Colors.white),
                        textScaler: TextScaler.linear(1.5),
                      ),
                    ),
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
