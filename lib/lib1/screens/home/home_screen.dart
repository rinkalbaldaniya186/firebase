import 'package:firebaseauth111/lib1/screens/home/components/home_screen_drawer.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/screens/home/components/body.dart';
// import 'package:shoppio_flutter_app/screens/home/components/body_old.dart';
// import 'package:shoppio_flutter_app/screens/home/components/home_screen_drawer.dart';
import '../home/components/body.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      drawer: HomeScreenDrawer(),
    );
  }
}
