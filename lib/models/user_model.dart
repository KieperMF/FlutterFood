class UserModel{
  String? name;
  String? email;
  String? uid;
  String? userPic;
  String? city;
  String? street;
  String? neighborhood;
  String? state;

  UserModel({
    this.city,
    this.email,
    this.name,
    this.neighborhood,
    this.state,
    this.street,
    this.uid,
    this.userPic
  });

  Map<String, dynamic> toMap(){
    return{
      'name' : name,
      'email' : email,
      'userPic' : userPic,
      'city' : city,
      'street' : street,
      'state' : state,
      'neighborhood' : neighborhood
    };
  }

  factory UserModel.fromJson(Map<dynamic, dynamic> json){
    return UserModel(
      name: json['name'],
      street: json['street'],
      city: json['city'],
      email: json['email'],
      neighborhood: json['neighborhood'],
      state: json['neighborhood'],
      userPic: json['userPic'],
    );
  }
}