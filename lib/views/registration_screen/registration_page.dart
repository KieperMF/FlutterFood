import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/services/user_service.dart';
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
  bool visibilityPassword = true;

  @override
  void initState() {
    store = context.read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = context.watch();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(24, 24, 24, 1),
          title: const Text(
            'Register page',
            textScaler: TextScaler.linear(1.2),
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                context.go('/login');
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white)),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textNameController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                      hintText: 'Name'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: textEmailController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                    hintStyle: TextStyle(fontSize: 18, color: Colors.white),
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
                  obscureText: visibilityPassword,
                  controller: textPasswordController,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      hintStyle:
                          const TextStyle(fontSize: 18, color: Colors.white),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              visibilityPassword = !visibilityPassword;
                            });
                          },
                          icon: visibilityPassword == false
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )
                              : const Icon(Icons.visibility_off,
                                  color: Colors.white))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.white)),
                  onPressed: () async {
                    if (EmailValidator.validate(textEmailController.text)) {
                      await store!.createVerification(textEmailController.text,
                          textPasswordController.text, textNameController.text);
                      if (store!.createVerif) {
                        context.go('/home');
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
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                    textScaler: TextScaler.linear(1.3),
                  ))
            ],
          ),
        ));
  }
}
