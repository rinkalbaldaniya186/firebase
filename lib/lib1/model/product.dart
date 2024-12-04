class Product {
  String? id;
  String title;

  String description;
  double mrp;
  int discount;
  int categoryId;
  String imagePath;
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  Product(
      {required this.title,
      required this.description,
      required this.mrp,
      required this.discount,
      required this.categoryId,
      required this.imagePath});

  Product.withId(
      {this.id,
      required this.title,
      required this.description,
      required this.mrp,
      required this.discount,
      required this.categoryId,
      required this.imagePath,
      required this.timestamp});

  factory Product.fromMap(Map<dynamic, dynamic> map) {
    return Product.withId(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      mrp: double.parse(map['mrp'].toString()),
      discount: map['discount'] as int,
      categoryId: map['categoryId'] as int,
      imagePath: map['imagePath'] as String,
      timestamp: map['timestamp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'mrp': this.mrp,
      'discount': this.discount,
      'categoryId': this.categoryId,
      'imagePath': this.imagePath,
      'timestamp': this.timestamp,
    };
  }
}
