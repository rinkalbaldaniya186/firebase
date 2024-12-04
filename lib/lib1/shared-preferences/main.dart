import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shared Preferences',
        home: MyHomePage()
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _salaryController = TextEditingController();

  var result = '';

  saveRecord(String name, int age, double salary) async {

    try{

      final SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('NAME', name);
      await pref.setInt('AGE', age);
      await pref.setDouble('SALARY', salary);

      print('data saved successfully..');

    }catch(e){
      print(e.toString());
    }

  }

  readRecord() async {

    try{

      final SharedPreferences pref = await SharedPreferences.getInstance();
      String name = pref.getString('NAME') ?? "";
      int age = pref.getInt("AGE") ?? 0;
      double salary = pref.getDouble("SALARY") ?? 0.0;

    setState(() {
      result = '''
      name : $name
      age : $age
      salary : $salary
      ''';
    });

    }catch(e){
      print(e.toString());
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: 'Enter employee name'
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                    hintText: 'Enter employee age'
                ),
              ),
              SizedBox(height: 16,),
              TextField(
                controller: _salaryController,
                decoration: InputDecoration(
                    hintText: 'Enter employee salary'
                ),
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(onPressed: () {

                      String name = _nameController.text.toString().trim();
                      int age = int.parse(_ageController.text.toString().trim());   // convert string into int
                      double salary = double.parse(_salaryController.text.toString().trim());   // converts string into double

                      saveRecord(name, age, salary);

                    }, child: Text('Save'), ),
                  ),
                  SizedBox(width: 24,),
                  Expanded(
                    child: ElevatedButton(onPressed: () {
                        readRecord();
                    }, child: Text('Read'), ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text(result, style: TextStyle(fontSize: 16),),
            ],
          ),
        ),
      ),
    );
  }


}
