import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/cart_screen/cart_store.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => CartStore(service: UserService()),
      child: const CartPage(),
    );
  }

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartStore? store;

  @override
  void initState() {
    super.initState();
    store = context.read();
    load();
  }

  void load(){
    store!.getCartProducts();
  }
  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              if(store!.cartProducts.isNotEmpty)...[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1,
                  child: ListView.builder(
                    itemCount: store!.cartProducts.length,
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 6,
                            child: Image.network('${store!.cartProducts[index].foodImage}'),),
                          Text('${store!.cartProducts[index].name}')
                        ],
                      );
                    }),
                ),
              ] else...[
                const Text('Cart Empty', textScaler: TextScaler.linear(1.5),)
              ],
            ],
          ),
        ),
      ),
    );
  }
}
