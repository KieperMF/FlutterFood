import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:go_router/go_router.dart';
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

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
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

  refresh() async {
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
          color: Colors.lightBlueAccent.shade700,
          onRefresh: () => refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  if (store!.bestRated.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: Shimmer.fromColors(
                          baseColor: Colors.yellow,
                          highlightColor: Colors.orange,
                          child: const Text(
                            textScaler: TextScaler.linear(1.2),
                            'Top Rateds',
                            style: TextStyle(
                                color: Colors.amberAccent, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                    CarouselSlider.builder(
                        itemCount: store!.bestRated.length,
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 0.5,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(38, 38, 38, 1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 1,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(24, 24, 24, 1),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        fit: BoxFit.cover,
                                        '${store!.bestRated[index].foodImage}',
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress != null) {
                                            return const Icon(
                                              Icons.image_rounded,
                                              size: 150,
                                              color: Colors.white,
                                            );
                                          } else {
                                            return child;
                                          }
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(
                                            Icons.image_not_supported_rounded,
                                            size: 150,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          textScaler:
                                              const TextScaler.linear(1),
                                          '${store!.bestRated[index].name}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        const SizedBox(height: 5,),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                            ),
                                            Text(
                                              '${store!.bestRated[index].avaliation}',
                                              textScaler:
                                                  const TextScaler.linear(1.5),
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                        Text(
                                          textScaler:
                                              const TextScaler.linear(1),
                                          '\$${store!.bestRated[index].price}',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlayCurve: Curves.easeIn,
                            autoPlayInterval:
                                const Duration(seconds: 3),
                            autoPlay: true,
                            height: MediaQuery.of(context).size.height / 5)),
                  ],
                  const SizedBox(
                    height: 10,
                  ),
                  store!.hamburger.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Shimmer.fromColors(
                              baseColor: Colors.yellow,
                              highlightColor: Colors.orange,
                              child: const Text(
                                textScaler: TextScaler.linear(1.2),
                                'Hamburgers',
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 22),
                              ),
                            ),
                          ),
                        )
                      : const Text(''),
                  store!.hamburger.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(store!.hamburger.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(38, 38, 38, 1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.amberAccent, width: 2)),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          selectedFood =
                                              store!.hamburger[index];
                                          context.push('/foodPage');
                                        },
                                        icon: SizedBox(
                                          height: 180,
                                          width: 190,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              "${store!.hamburger[index].foodImage}",
                                              cacheWidth: 500,
                                              cacheHeight: 500,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress != null) {
                                                  return const Center(
                                                      child: Icon(
                                                    Icons.image_rounded,
                                                    size: 100,
                                                    color: Colors.white,
                                                  ));
                                                } else {
                                                  return child;
                                                }
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons
                                                      .image_not_supported_rounded,
                                                  size: 100,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        textScaler: const TextScaler.linear(1),
                                        '${store!.hamburger[index].name}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            '${store!.hamburger[index].avaliation}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            textScaler:
                                                const TextScaler.linear(1),
                                            '\$ ${store!.hamburger[index].price}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : const Text(''),
                  store!.meals.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Shimmer.fromColors(
                              baseColor: Colors.yellow,
                              highlightColor: Colors.orange,
                              child: const Text(
                                textScaler: TextScaler.linear(1.2),
                                'Meals',
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 22),
                              ),
                            ),
                          ),
                        )
                      : const Text(''),
                  const SizedBox(
                    height: 10,
                  ),
                  store!.meals.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(store!.meals.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(38, 38, 38, 1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.amberAccent, width: 2)),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          selectedFood = store!.meals[index];
                                          context.push('/foodPage');
                                        },
                                        icon: SizedBox(
                                          height: 180,
                                          width: 190,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              "${store!.meals[index].foodImage}",
                                              cacheWidth: 500,
                                              cacheHeight: 500,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress != null) {
                                                  return const Center(
                                                      child: Icon(
                                                    Icons.image_rounded,
                                                    size: 100,
                                                    color: Colors.white,
                                                  ));
                                                } else {
                                                  return child;
                                                }
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons
                                                      .image_not_supported_rounded,
                                                  size: 100,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        textScaler: const TextScaler.linear(1),
                                        '${store!.meals[index].name}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          store!.meals[index].avaliation != null
                                              ? Text(
                                                  '${store!.meals[index].avaliation}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              : const Text(''),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            textScaler:
                                                const TextScaler.linear(1),
                                            '\$ ${store!.meals[index].price}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : const Text(''),
                  const SizedBox(
                    height: 10,
                  ),
                  store!.drinks.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Shimmer.fromColors(
                              baseColor: Colors.yellow,
                              highlightColor: Colors.orange,
                              child: const Text(
                                textScaler: TextScaler.linear(1.5),
                                'Drinks',
                                style: TextStyle(
                                    color: Colors.amberAccent, fontSize: 22),
                              ),
                            ),
                          ),
                        )
                      : const Text(''),
                  store!.drinks.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(store!.drinks.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color:
                                          const Color.fromRGBO(38, 38, 38, 1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: Colors.amberAccent, width: 2)),
                                  child: Column(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          selectedFood = store!.drinks[index];
                                          context.push('/foodPage');
                                        },
                                        icon: SizedBox(
                                          height: 180,
                                          width: 190,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              fit: BoxFit.fill,
                                              "${store!.drinks[index].foodImage}",
                                              cacheWidth: 500,
                                              cacheHeight: 500,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress != null) {
                                                  return const Center(
                                                      child: Icon(
                                                    Icons.image_rounded,
                                                    size: 100,
                                                    color: Colors.white,
                                                  ));
                                                } else {
                                                  return child;
                                                }
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons
                                                      .image_not_supported_rounded,
                                                  size: 100,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        textScaler: const TextScaler.linear(1),
                                        '${store!.drinks[index].name}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            '${store!.drinks[index].avaliation}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            textScaler:
                                                const TextScaler.linear(1),
                                            '\$ ${store!.drinks[index].price}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        )
                      : const Text(''),
                ],
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
