import 'dart:convert';

List<User> userListFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userListToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
        this.division,
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
    String? division;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? token;

    factory User.fromJson(Map<String, dynamic> json) => User(
        password: json["password"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        images: json["images"] != null 
            ? List<dynamic>.from(json["images"].map((x) => x))
            : [],
        sold: json["sold"],
        isDeleted: json["isDeleted"],
        balance: json["balance"],
        id: json["_id"],
        userName: json["userName"],
        name: json["name"] ?? json["fullName"],
        division: json["division"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
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
        "division": division,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "token": token,
    };
}
