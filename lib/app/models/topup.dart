import 'dart:convert';

import 'package:bias_admin/app/models/user.dart';

List<Topup> topupFromJson(String str) => List<Topup>.from(json.decode(str).map((x) => Topup.fromJson(x)));

String topupToJson(List<Topup> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Topup {
    Topup({
        this.note,
        this.balance,
        this.currentBalance,
        this.id,
        this.user,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? note;
    int? balance;
    int? currentBalance;
    String? id;
    User? user;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Topup.fromJson(Map<String, dynamic> json) => Topup(
        note: json["note"],
        balance: json["balance"],
        currentBalance: json["currentBalance"],
        id: json["_id"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "note": note,
        "balance": balance,
        "currentBalance": currentBalance,
        "_id": id,
        "user": user?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}