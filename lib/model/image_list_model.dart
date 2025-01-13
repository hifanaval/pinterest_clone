// To parse this JSON data, do
//
//     final imageModelDart = imageModelDartFromJson(jsonString);

import 'dart:convert';

List<ImageModelDart> imageModelDartFromJson(String str) =>
    List<ImageModelDart>.from(
        json.decode(str).map((x) => ImageModelDart.fromJson(x)));

String imageModelDartToJson(List<ImageModelDart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModelDart {
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;

  String? altDescription;

  Urls? urls;

  ImageModelDart({
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.altDescription,
    this.urls,
  });

  factory ImageModelDart.fromJson(Map<String, dynamic> json) => ImageModelDart(
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        altDescription: json["alt_description"],
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "alt_description": altDescription,
        "urls": urls?.toJson(),
      };
}

class Urls {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smallS3;

  Urls({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        raw: json["raw"],
        full: json["full"],
        regular: json["regular"],
        small: json["small"],
        thumb: json["thumb"],
        smallS3: json["small_s3"],
      );

  Map<String, dynamic> toJson() => {
        "raw": raw,
        "full": full,
        "regular": regular,
        "small": small,
        "thumb": thumb,
        "small_s3": smallS3,
      };
}
