import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseauth111/lib1/preference/pref_utils.dart';
import 'package:firebaseauth111/lib1/routes/app_route.dart';
import 'package:firebaseauth111/lib1/theme.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
// import 'package:shoppio_flutter_app/constants.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/preference/pref_utils.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';
// import 'package:shoppio_flutter_app/theme.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: appName,
      theme: appTheme(),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.generateRoute,
    );
  }
}
