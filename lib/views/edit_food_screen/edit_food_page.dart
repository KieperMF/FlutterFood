import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditFoodPage extends StatefulWidget {
  const EditFoodPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => EditFoodStore(service: FoodService()),
      child: const EditFoodPage(),
    );
  }

  @override
  State<EditFoodPage> createState() => _EditFoodPageState();
}

class _EditFoodPageState extends State<EditFoodPage> {
  EditFoodStore? store;
  List<TextEditingController> namesController = [];
  List<TextEditingController> descriptionsController = [];
  List<TextEditingController> pricesController = [];
  String? dropDownValue;

  @override
  void initState() {
    store = context.read();
    load();
    dropDownValue = store!.categories[0];
    super.initState();
  }

  load() async {
    await store!.getFoods();
    store!.visibility = List.generate(store!.foods.length, (index) => false);
    namesController =
        List.generate(store!.foods.length, (index) => TextEditingController());
    descriptionsController =
        List.generate(store!.foods.length, (index) => TextEditingController());
    pricesController =
        List.generate(store!.foods.length, (index) => TextEditingController());
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        title: const Text(
          'Edit Food',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
            child: SizedBox(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: store!.foods.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => store!.toggleVisibility(index),
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(38, 38, 38, 1),
                              border: Border.all(color: Colors.amberAccent)),
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.amberAccent)),
                                  width: 150,
                                  height: 100,
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    cacheWidth: 200,
                                    '${store!.foods[index].foodImage}',
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
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
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                      Icons.image_not_supported_rounded,
                                      size: 100,
                                      color: Colors.white,
                                    ),
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                textScaler: const TextScaler.linear(1.3),
                                '${store!.foods[index].name}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amberAccent),
                              color: const Color.fromRGBO(38, 38, 38, 1)),
                          duration: const Duration(milliseconds: 1000),
                          height: store!.visibility[index] == true
                              ? MediaQuery.maybeOf(context)!.size.height / 3
                              : 0,
                          curve: Curves.easeInOut,
                          child: store!.visibility[index] == true
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        flex: 40,
                                        child: TextField(
                                          style: const TextStyle(color: Colors.white, fontSize: 18),
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText:
                                                  'Name: ${store!.foods[index].name}',
                                              hintStyle: const TextStyle(fontSize: 18,
                                                  color: Colors.white)),
                                          controller: namesController[index],
                                        ),
                                      ),
                                      const Flexible(
                                        flex: 5,
                                        child:  SizedBox(
                                          height: 5,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 40,
                                        child: TextField(style: const TextStyle(fontSize: 18, color: Colors.white),
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText:
                                                  'Description: ${store!.foods[index].description}',
                                              hintStyle: const TextStyle(fontSize: 18,
                                                  color: Colors.white)),
                                          controller:
                                              descriptionsController[index],
                                        ),
                                      ),
                                      const Flexible(
                                        flex: 10,
                                        child:  SizedBox(
                                          height: 5,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 40,
                                        child: TextField(
                                          style: const TextStyle(fontSize: 18, color: Colors.white),
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              border: const OutlineInputBorder(),
                                              hintText:
                                                  'Price: ${store!.foods[index].price}',
                                              hintStyle: const TextStyle(fontSize: 18,
                                                  color: Colors.white)),
                                          controller: pricesController[index],
                                        ),
                                      ),
                                      const Flexible(
                                        flex: 10,
                                        child:  SizedBox(
                                          height: 5,
                                        ),
                                      ),
                                      Flexible(
                                        flex: 40,
                                        child: DropdownButton<String>(
                                            icon: const Icon(
                                                color: Colors.white,
                                                Icons.download_rounded),
                                            value: dropDownValue,
                                            style: const TextStyle(
                                                color: Colors.white),
                                            items: store!.categories
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value));
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                dropDownValue = value!;
                                              });
                                            }),
                                      ),
                                      Flexible(
                                        flex: 50,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                  onPressed: () {
                                                    store!.updateFood(
                                                        namesController[index].text,
                                                        descriptionsController[
                                                                index]
                                                            .text,
                                                        dropDownValue!,
                                                        double.parse(
                                                            pricesController[index]
                                                                .text),
                                                        index);
                                                  },
                                                  child: const Text(
                                                    textScaler:
                                                        TextScaler.linear(1),
                                                    'Update',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  )),
                                            TextButton(
                                                  onPressed: () {
                                                    store!.deleteFood(
                                                        store!.foods[index]);
                                                  },
                                                  child: const Text(
                                                    textScaler:
                                                        TextScaler.linear(1),
                                                    'Delete',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white),
                                                  )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : null),
                    ],
                  ),
                );
              }),
        )),
      ),
    );
  }
}
