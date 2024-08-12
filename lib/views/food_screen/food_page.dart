import 'package:flutter/material.dart';
import 'package:flutter_food/views/home_screen/home_store.dart';
import 'package:go_router/go_router.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.yellow,
            )),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(24, 24, 24, 1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.amberAccent, width: 2)),
                height: MediaQuery.of(context).size.height / 3.9,
                width: MediaQuery.of(context).size.width / 1.4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    fit: BoxFit.cover,
                    "${selectedFood!.foodImage}",
                    cacheWidth: 500,
                    cacheHeight: 500,
                    loadingBuilder: (context, child, loadingProgress) {
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
            ],
          ),
        ),
      ),
    );
  }
}
