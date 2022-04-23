import 'dart:convert';

List<Division> divisionListFromJson(String str) => List<Division>.from(json.decode(str).map((x) => Division.fromJson(x)));

String divisionListToJson(List<Division> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Division divisionFromJson(String str) => Division.fromJson(json.decode(str));

String divisionToJson(Division data) => json.encode(data.toJson());

class Division {
    Division({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    factory Division.fromJson(Map<String, dynamic> json) => Division(
        id: json["_id"],
        name: json["name"],
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
