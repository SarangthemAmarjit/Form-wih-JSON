enum gender { Male, Female, Other }

class User {
  String? post;
  String? name;
  String? email;
  String? password;
  String? phone_number;
  String? address;
  String? qualification;
  gender? gen;

  User(this.post, this.name, this.email, this.password, this.phone_number,
      this.address, this.qualification, this.gen);

  //ENCODING TO JSON FILE
  Map<String, dynamic> toJson() => {
        'post': post,
        'name': name,
        'email': email,
        'password': password,
        'contact_number': phone_number,
        'address': address,
        'qualification': qualification,
        'gender': gen,
      };

  // DECODING FROM JSON FILE
  User.fromJson(Map<String, dynamic> json)
      : post = json['post'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        phone_number = json['contact_number'],
        address = json['address'],
        qualification = json['qualification'],
        gen = json['gender'];
}
