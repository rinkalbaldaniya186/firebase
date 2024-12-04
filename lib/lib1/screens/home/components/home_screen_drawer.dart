import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth111/lib1/firebase/firebase_service.dart';
import 'package:firebaseauth111/lib1/routes/app_route.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          buildUserAccountHeader(),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Manage Category'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.categoryListScreen);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box),
            title: Text('Manage Product'),
            onTap: () {
              Navigator.pushNamed(context, AppRoute.productListScreen);
            },
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          ListTile(
            onTap: () {

              FirebaseService service = FirebaseService();

              service.signOut().then((value) {
                // navigate to login
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.signInScreen, (route) => false);
              });

            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          )
        ],
      ),
    );
  }

  buildUserAccountHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text('Tops Technologies', style: TextStyle(color: Colors.white),),
      accountEmail: Text('topstechnologies@gmail.com',style: TextStyle(color: Colors.white),),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.green,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Image.asset('assets/images/app_logo.png', height: 45, width: 45,),
      ),
    );
  }
}
