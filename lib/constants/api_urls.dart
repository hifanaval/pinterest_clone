String clientId = "J0aGZgs3-YzBOfQW-SoajRx2zbct0LsoErdi5_eNaus";

class ApiUrls {
  static const String baseUrl = "https://api.unsplash.com";

  static String getImageList({int page = 1}) {
    return '$baseUrl/photos/?page=$page&client_id=$clientId';
  }
}
