import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

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

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  HomeStore? store;
  
  @override
  void initState() {
    super.initState();
    store = context.read();
    load();
  }

  load() async {
    await store!.getFoods();
  }

  refresh() async{
    await store!.refreshMethod();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    store = context.watch();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    store!.hamburger.isNotEmpty ? 
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Shimmer.fromColors(
                        baseColor: Colors.yellow,
                        highlightColor: Colors.orange,
                        child: const Text(
                          'Hamburgers',
                          style: TextStyle(color: Colors.amberAccent, fontSize: 22),
                        ),
                      ),
                    ) : const Text(''),
                    store!.hamburger.isNotEmpty ? 
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(store!.hamburger.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(24, 24, 24, 1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.amberAccent,width: 2)),
                                    height: 180,
                                    width: 190,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        "${store!.hamburger[index].foodImage}",
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
                                  Text(
                                    textScaler:const TextScaler.linear(1),
                                    '${store!.hamburger[index].name}',
                                    style: const TextStyle(color: Colors.amberAccent, fontSize: 20),
                                  ),
                                  Text(
                                    textScaler:const TextScaler.linear(1),
                                    '\$ ${store!.hamburger[index].price}',
                                    style: const TextStyle(color: Colors.amberAccent, fontSize: 20),
                                  ),
                                ],
                            ),
                          );
                        }),
                      ),
                    ): const Text(''),
                    const SizedBox(
                      height: 10,
                    ),
                    store!.drinks.isNotEmpty ? 
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Shimmer.fromColors(
                        baseColor: Colors.yellow,
                        highlightColor: Colors.orange,
                        child: const Text(
                          textScaler: TextScaler.linear(1.5),
                          'Drinks',
                          style: TextStyle(color: Colors.amberAccent, fontSize: 22),
                        ),
                      ),
                    ) : const Text(''),
                    store!.drinks.isNotEmpty ? 
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:List.generate(store!.drinks.length, (index){
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color:
                                            const Color.fromRGBO(24, 24, 24, 1),
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.amberAccent,width: 2)),
                                    height: 180,
                                    width: 190,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        fit: BoxFit.fill,
                                        "${store!.drinks[index].foodImage}",
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
                                  Text(
                                    textScaler:const TextScaler.linear(1),
                                    '${store!.drinks[index].name}',
                                    style: const TextStyle(color: Colors.amberAccent, fontSize: 20),
                                  ),
                                  Text(
                                    textScaler:const TextScaler.linear(1),
                                    '\$ ${store!.drinks[index].price}',
                                    style: const TextStyle(color: Colors.amberAccent, fontSize: 20),
                                  ),
                                ],
                            ),
                          );
                        }),
                      ),
                    ) : const Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
