import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.id,
        this.fullName,
        this.email,
        this.password,
        this.phoneNumber,
        this.role,
        this.token,
    });

    String? id;
    String? fullName;
    String? email;
    String? password;
    String? phoneNumber;
    String? role;
    String? token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        role: json["role"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
        "role": role,
        "token": token,
    };
}
