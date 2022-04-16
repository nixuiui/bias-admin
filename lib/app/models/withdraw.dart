import 'dart:convert';

import 'package:bias_admin/app/models/user.dart';

List<Withdraw> withdrawFromJson(String str) => List<Withdraw>.from(json.decode(str).map((x) => Withdraw.fromJson(x)));

String withdrawToJson(List<Withdraw> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Withdraw {
    Withdraw({
        this.note,
        this.balance,
        this.currentBalance,
        this.id,
        this.merchant,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? note;
    int? balance;
    int? currentBalance;
    String? id;
    User? merchant;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Withdraw.fromJson(Map<String, dynamic> json) => Withdraw(
        note: json["note"],
        balance: json["balance"],
        currentBalance: json["currentBalance"],
        id: json["_id"],
        merchant: json["merchant"] != null ? User.fromJson(json["merchant"]) : null,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "note": note,
        "balance": balance,
        "currentBalance": currentBalance,
        "_id": id,
        "merchant": merchant?.toJson(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}