class FoodModel {
  String? id;
  String? name;
  String? foodImage;
  num? price;
  String? description;
  String? category;
  num? avaliation;
  num? avaliationNumber;
  num? avaliationsPoints;

  FoodModel(
      {this.avaliation,
      this.avaliationNumber,
      this.avaliationsPoints,
      this.category,
      this.description,
      this.foodImage,
      this.id,
      this.name,
      this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'avaliationsPoints' : avaliationsPoints,
      'avaliationNumber' : avaliationNumber,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'foodImage': foodImage,
      'avaliation': avaliation
    };
  }

  factory FoodModel.fromJson(Map<dynamic, dynamic> json) {
    return FoodModel(
      id: json['id'],
      name: json['name'],
      avaliationNumber: json['avaliationNumber'],
      avaliationsPoints: json['avaliationsPoints'],
      avaliation: json['avaliation'],
      category: json['category'],
      description: json['description'],
      foodImage: json['foodImage'],
      price: json['price'] ,
    );
  }
}
