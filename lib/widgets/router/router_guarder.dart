import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food/widgets/router/router_guard_store.dart';
import 'package:provider/provider.dart';

class RouterGuarder extends StatefulWidget {
  const RouterGuarder({super.key, required this.child});

  final Widget child;

  static Widget create(Widget child) {
    return ChangeNotifierProvider(
      create: (_) => RouterGuardStore(auth: FirebaseAuth.instance),
      child: RouterGuarder(child: child),
    );
  }

  @override
  State<RouterGuarder> createState() => _RouterGuarderState();
}

class _RouterGuarderState extends State<RouterGuarder> {
  RouterGuardStore? guardStore;

  @override
  void initState() {
    super.initState();
    guardStore = context.read();
    guardStore!.startListening();
  }
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}