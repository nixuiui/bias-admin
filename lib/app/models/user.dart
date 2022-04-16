import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    User({
        this.password,
        this.address,
        this.phoneNumber,
        this.images,
        this.sold,
        this.isDeleted,
        this.balance,
        this.id,
        this.userName,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.token,
    });

    String? password;
    String? address;
    String? phoneNumber;
    List<dynamic>? images;
    int? sold;
    bool? isDeleted;
    int? balance;
    String? id;
    String? userName;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        sold: json["sold"],
        isDeleted: json["isDeleted"],
        balance: json["balance"],
        id: json["_id"],
        userName: json["userName"],
        name: json["name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "password": password,
        "address": address,
        "phoneNumber": phoneNumber,
        "images": images != null ? List<dynamic>.from(images!.map((x) => x)) : [],
        "sold": sold,
        "isDeleted": isDeleted,
        "balance": balance,
        "_id": id,
        "userName": userName,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
    };
}
