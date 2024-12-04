import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:shoppio_flutter_app/components/custom_suffix_icon.dart';
// import 'package:shoppio_flutter_app/firebase/firebase_service.dart';
// import 'package:shoppio_flutter_app/model/app_user.dart';
// import 'package:shoppio_flutter_app/utils/utils.dart';
import '../../../components/custom_suffix_icon.dart';
import '../../../firebase/firebase_service.dart';
import '../../../model/app_user.dart';
import '../../../routes/app_route.dart';
import '../../../utils/utils.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  FirebaseService _service = FirebaseService();

  String gender = 'male',
      dob = '',
      fName = '',
      lName = '',
      contact = '',
      email = '',
      password = '',
      userType = '',
      address = '';

  final _dobController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void updateGenderSelection(String selection) {
    setState(() {
      gender = selection;
    });
  }

  Future _selectDate() async {
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly
        /*helpText: 'Select date of birth',
      confirmText: 'Done',
      cancelText: 'Cancel',
      fieldLabelText: 'DOB',
      */
        );

    if (pickedDate != null) {
      setState(() {
        dob =
            '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}';
        _dobController.text = dob;
      });
    }
  }

  Future<void> createAccount(AppUser user, BuildContext context) async {
    var credential = await _service.signUp(user.email!, user.password!);

    if (credential is UserCredential) {
      // success
      if (credential!.user != null) {
        print('uid : ${credential!.user!.uid}');
        user.id = credential.user!.uid!;

        _service.createUser(user).then((value) {
          // success
          // navigate to home screen
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.homeScreen, (route) => false);
        }).catchError((error) {
          // error
          print('error : ${error.toString()}');
        });
      }
    } else if (credential is String) {
      print(credential);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildNameFormField(),
            SizedBox(
              height: 16,
            ),
            buildEmailFormField(),
            SizedBox(
              height: 16,
            ),
            buildContactFormField(),
            SizedBox(
              height: 16,
            ),
            buildGenderSelectionWidget(),
            SizedBox(
              height: 16,
            ),
            buildUserTypeFormField(),
            SizedBox(
              height: 16,
            ),
            buildDateOfBirthFormField(context),
            SizedBox(
              height: 16,
            ),
            buildAddressFormField(),
            SizedBox(
              height: 16,
            ),
            buildPasswordFormField(),
            SizedBox(
              height: 16,
            ),
            buildConfirmPasswordFormField(),
            SizedBox(
              height: 16,
            ),
            buildSignUpButtonWidget(context)
          ],
        ),
      ),
    );
  }

  buildNameFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'First Name';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              fName = newValue.toString();
            },
            decoration: InputDecoration(
              labelText: "First Name",
              hintText: 'First Name',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Last Name';
              } else {
                return null;
              }
            },
            onSaved: (newValue) {
              lName = newValue.toString();
            },
            decoration: InputDecoration(
              labelText: "Last Name",
              hintText: 'Last Name',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        )
      ],
    );
  }

  buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || !Utils.isValidEmail(value)) {
          return 'Enter valid email address';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {
        email = newValue.toString();
      },
      decoration: InputDecoration(
          labelText: "Email",
          hintText: 'Email address',
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: CustomSuffixIcon('assets/icons/Mail.svg')),
    );
  }

  buildContactFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || !Utils.isValidContact(value)) {
          return 'Enter valid contact';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {
        contact = newValue.toString();
      },
      decoration: InputDecoration(
        labelText: "Contact",
        hintText: 'Contact',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Call.svg'),
      ),
    );
  }

  buildGenderSelectionWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: [
          Text('Gender'),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'male',
                  groupValue: gender,
                  onChanged: (value) {
                    updateGenderSelection(value.toString());
                  },
                ),
                Text('Male'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'female',
                  groupValue: gender,
                  onChanged: (value) {
                    updateGenderSelection(value.toString());
                  },
                ),
                Text('Female'),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: 'other',
                  groupValue: gender,
                  onChanged: (value) {
                    updateGenderSelection(value.toString());
                  },
                ),
                Text('Others'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildUserTypeFormField() {
    return DropdownButtonFormField(
      iconEnabledColor: Colors.black45,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Select user type';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {
        userType = newValue.toString();
      },
      decoration: InputDecoration(
          labelText: "User Type",
          hintText: 'Select User Type',
          floatingLabelBehavior: FloatingLabelBehavior.auto),
      items: [
        DropdownMenuItem(
          value: 'Vendor',
          child: Text('Vender'),
        ),
        DropdownMenuItem(
          value: 'User',
          child: Text('User'),
        )
      ],
      onChanged: (value) {
        print(value);
      },
    );
  }

  buildDateOfBirthFormField(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      onTap: () {
        _selectDate();
        FocusScope.of(context).requestFocus(FocusNode());
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Select date';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {
        dob = newValue.toString();
      },
      decoration: InputDecoration(
        labelText: "Date of birth",
        hintText: 'Date of birth',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Dob.svg'),
      ),
    );
  }

  buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      onSaved: (newValue) {
        address = newValue.toString();
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: 'Address',
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }

  buildPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      controller: _passwordController,
      obscureText: true,
      validator: (value) {
        if (value == null || !Utils.isValidPassword(value)) {
          return 'Enter valid password';
        } else {
          return null;
        }
      },
      onSaved: (newValue) {
        password = newValue.toString();
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: 'Enter password',
        helperText:
            'should be contain at least one upper, lower, digit and special character',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Lock.svg'),
      ),
    );
  }

  buildConfirmPasswordFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      validator: (value) {
        if (value == null || value != _passwordController.text.toString()) {
          return 'Password mismatch';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Confirm password",
        hintText: 'Enter password',
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: CustomSuffixIcon('assets/icons/Lock.svg'),
      ),
    );
  }

  buildSignUpButtonWidget(BuildContext context) {
    return MaterialButton(
      color: Colors.green,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print('''
            first name : $fName
            last name : $lName
            email : $email
            contact : $contact
            password : $password
            user type : $userType
            gender : $gender
            dob : $dob
            address : $address
            ''');

          var user = AppUser(
              fName: fName,
              dob: dob,
              gender: gender,
              lName: lName,
              email: email,
              contact: contact,
              password: password,
              userType: userType,
              address: address);

          createAccount(user, context);

          // store this data to database or server
          /*PrefUtils.updateLoginStatus(true).then((value) {
              if(value){
                Navigator.pushNamedAndRemoveUntil(context, AppRoute.homeScreen, (route) => false);
              }
            });*/
        }
      },
      child: Text(
        'Sign Up',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
