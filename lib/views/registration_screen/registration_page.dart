import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
import 'package:flutter_food/views/bottom_navigation_bar.dart';
import 'package:flutter_food/views/registration_screen/registration_store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  static Widget create() {
    return ChangeNotifierProvider(
      create: (_) => RegistrationStore(service: UserService()),
      child: const RegistrationPage(),
    );
  }

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController textNameController = TextEditingController();
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  final bool isValid = false;
  RegistrationStore? store;

  @override
  void initState() {
    store = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register page'),
          leading: IconButton(onPressed: (){
            context.go('/login');
          }, icon:const Icon(Icons.arrow_back_rounded)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textNameController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 18), hintText: 'Name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textEmailController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Email',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textPasswordController,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontSize: 18),
                    hintText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () async {
                    if (EmailValidator.validate(textEmailController.text)) {
                      await store!.createVerification(textEmailController.text,
                          textPasswordController.text, textNameController.text);
                      if (store!.createVerif) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const GoogleNavBar()));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Invalid Credentials'),
                          duration: Duration(milliseconds: 1000),
                        ));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid Email'),
                        duration: Duration(milliseconds: 1000),
                      ));
                    }
                  },
                  child: const Text('Register'))
            ],
          ),
        ));
  }
}
