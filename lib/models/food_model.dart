class FoodModel {
  String? id;
  String? name;
  String? foodImage;
  double? price;
  String? description;
  String? category;
  double? avaliation;

  FoodModel(
      {this.avaliation,
      this.category,
      this.description,
      this.foodImage,
      this.id,
      this.name,
      this.price});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      avaliation: json['avaliation'],
      category: json['category'],
      description: json['description'],
      foodImage: json['foodImage'],
      price: json['price'],
    );
  }
}
