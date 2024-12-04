import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/preference/pref_utils.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';

import '../../../preference/pref_utils.dart';
import '../../../routes/app_route.dart';

class BodyOld extends StatelessWidget {
  const BodyOld({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Home Screen'),
          SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
                PrefUtils.logout().then((value) {
                  if(value){
                    Navigator.pushNamedAndRemoveUntil(context, AppRoute.signInScreen, (route) => false);
                  }
                });
            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}
