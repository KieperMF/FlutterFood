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
  void didChangeDependencies() {
    store = context.read();
    load();
    super.didChangeDependencies();
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
        backgroundColor:const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    physics:const BouncingScrollPhysics(),
                    itemCount: store!.foods.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(107, 114, 128, 1),
                                borderRadius: BorderRadius.circular(32),
                                border: Border.all(color: Colors.grey)),
                            height: 170,
                            width: 180,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                fit: BoxFit.cover,
                                "${store!.foods[index].foodImage}",
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
                                  return const Icon(Icons.image_not_supported_rounded, size: 100,);
                                },
                              ),
                            ),
                          ),
                          Text('${store!.foods[index].name}'),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
