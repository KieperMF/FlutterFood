class UserModel{
  String? name;
  String? phone;
  String? lastName;
  String? email;
  String? uid;
  String? userPic;
  String? city;
  String? street;
  String? neighborhood;
  String? state;
  String? cep;

  UserModel({
    this.cep,
    this.phone,
    this.city,
    this.email,
    this.lastName,
    this.name,
    this.neighborhood,
    this.state,
    this.street,
    this.uid,
    this.userPic
  });

  Map<String, dynamic> toMap(){
    return{
      'cep' : cep,
      'phone' : phone,
      'name' : name,
      'lastName': lastName,
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
      cep: json['cep'],
      phone: json['phone'],
      name: json['name'],
      lastName: json['lastName'],
      street: json['street'],
      city: json['city'],
      email: json['email'],
      neighborhood: json['neighborhood'],
      state: json['state'],
      userPic: json['userPic'],
    );
  }

  factory UserModel.fromJsonApiCep(Map<dynamic, dynamic> json){
    return UserModel(
      cep: json['cep'],
      street: json['logradouro'],
      city: json['localidade'],
      neighborhood: json['bairro'],
      state: json['uf'],
    );
  }
}