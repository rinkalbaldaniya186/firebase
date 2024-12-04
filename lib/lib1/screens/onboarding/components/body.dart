import 'package:firebaseauth111/lib1/screens/onboarding/components/slide_view.dart';
import 'package:flutter/material.dart';
// import 'package:shoppio_flutter_app/preference/pref_utils.dart';
// import 'package:shoppio_flutter_app/routes/app_route.dart';
// import 'package:shoppio_flutter_app/screens/onboarding/components/indicator.dart';
// import 'package:shoppio_flutter_app/screens/onboarding/components/slide_view.dart';

import '../../../model/item.dart';
import '../../../preference/pref_utils.dart';
import '../../../routes/app_route.dart';
import 'indicator.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Item> itemList = [];

  int currentIndex = 0;
  final _pageController = PageController();

  @override
  void initState() {
    itemList.add(
      Item(
          title: 'Select Item',
          desc:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
          image: 'assets/images/onboarding.jpg'),
    );
    itemList.add(
      Item(
          title: 'Purchase',
          desc:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
          image: 'assets/images/onboarding.jpg'),
    );
    itemList.add(
      Item(
          title: 'Delivery',
          desc:
              'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
          image: 'assets/images/onboarding.jpg'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Scaffold(
        body: PageView.builder(
          controller: _pageController,
          onPageChanged: (value) {
            //print(value);
            setState(() {
              currentIndex = value;
            });
          },
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return SlideView(itemList[index]);
          },
        ),
        bottomSheet: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                  for(int i = 0; i<itemList.length; i++)
                    if(i==currentIndex)
                      getIndicator(true)
                    else
                      getIndicator(false)
              ],
            ),

            ElevatedButton(
              onPressed: () {
                  if(currentIndex != itemList.length - 1){
                    // navigate to next slide
                    currentIndex++;
                    _pageController.animateToPage(currentIndex, duration: Duration(milliseconds: 500), curve: Curves.linear);

                  }else{
                      PrefUtils.updateOnboardingStatus(true).then((value) {
                        if(value){
                          // navigate to login screen
                          Navigator.pushReplacementNamed(context, AppRoute.signInScreen);
                        }
                      });
                  }
              },
              child: Text(currentIndex != itemList.length - 1 ? 'NEXT' : 'FINISH'),
            )
          ],
        ),
      ),
    );
  }
}
