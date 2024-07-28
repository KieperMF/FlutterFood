import 'package:flutter/material.dart';
import 'package:flutter_food/services/food_service.dart';
import 'package:flutter_food/views/edit_food_screen/edit_food_store.dart';
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
        title: const Text('Edit Food'),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
            child: SizedBox(
          child: ListView.builder(
              physics:const BouncingScrollPhysics(),
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
                              color: const Color.fromRGBO(148, 163, 184, 1),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 150,
                                  height: 100,
                                  child: Image.network(
                                    fit: BoxFit.cover,
                                    cacheWidth: 200,
                                      '${store!.foods[index].foodImage}')),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '${store!.foods[index].name}',
                                style: const TextStyle(
                                    fontSize: 18, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedContainer(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              color: const Color.fromRGBO(148, 163, 184, 1)),
                          duration: const Duration(milliseconds: 1500),
                          height: store!.visibility[index] == true ? 300 : 0,
                          curve: Curves.easeInOut,
                          child: store!.visibility[index] == true
                              ? SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        TextField(
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText:
                                                  '${store!.foods[index].name}'),
                                          controller: namesController[index],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText:
                                                  '${store!.foods[index].description}'),
                                          controller:
                                              descriptionsController[index],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        TextField(
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                              border:
                                                  const OutlineInputBorder(),
                                              hintText:
                                                  '${store!.foods[index].price}'),
                                          controller: pricesController[index],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        DropdownButton<String>(
                                            icon: const Icon(
                                                Icons.download_rounded),
                                            value: dropDownValue,
                                            style: const TextStyle(color: Colors.black),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  store!.updateFood(
                                                      namesController[index]
                                                          .text,
                                                      descriptionsController[
                                                              index]
                                                          .text,
                                                      dropDownValue!,
                                                      double.parse(
                                                          pricesController[
                                                                  index]
                                                              .text),
                                                      index);
                                                },
                                                child: const Text(
                                                  'Update',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  store!.deleteFood(store!.foods[index]);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
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
