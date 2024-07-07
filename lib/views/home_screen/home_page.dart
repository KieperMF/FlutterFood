import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => HomeStore(service: FoodService()),
      child: const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeStore? store;

  @override
  void initState() {
    store = context.read();
    load();
    super.initState();
  }

  load() async {
    await store!.getFoods();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: ListView.builder(
                    itemCount: store!.foods.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            height: 100,
                            width: 190,
                            child: Image.network(
                              "${store!.foods[index].foodImage}",
                              cacheWidth: 600,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress != null) {
                                  return const CircularProgressIndicator();
                                } else {
                                  return child;
                                }
                              },
                            ),
                          ),
                          Text('${store!.foods[index].name}'),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
