class AppUser{
  String? id;
  String? fName;
  String? lName;
  String? email;
  String? contact;
  String? gender;
  String? userType;
  String? dob;
  String? address;
  String? password;

  AppUser({this.fName, this.lName, this.email, this.contact,
    this.gender, this.userType, this.dob, this.address, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'firstName': this.fName,
      'lastName': this.lName,
      'email': this.email,
      'contact': this.contact,
      'gender': this.gender,
      'userType': this.userType,
      'dob': this.dob,
      'address': this.address,
      'password': this.password,
    };
  }

}