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
  String? id;

  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? promotedAt;

  Urls? urls;
  ImageModelDartLinks? links;

  ImageModelDart({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.promotedAt,
    this.urls,
    this.links,
  });

  factory ImageModelDart.fromJson(Map<String, dynamic> json) => ImageModelDart(
        id: json["id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        promotedAt: json["promoted_at"] == null
            ? null
            : DateTime.parse(json["promoted_at"]),
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
        links: json["links"] == null
            ? null
            : ImageModelDartLinks.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "promoted_at": promotedAt?.toIso8601String(),
        "urls": urls?.toJson(),
        "links": links?.toJson(),
      };
}

class ImageModelDartLinks {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  ImageModelDartLinks({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory ImageModelDartLinks.fromJson(Map<String, dynamic> json) =>
      ImageModelDartLinks(
        self: json["self"],
        html: json["html"],
        download: json["download"],
        downloadLocation: json["download_location"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "html": html,
        "download": download,
        "download_location": downloadLocation,
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
