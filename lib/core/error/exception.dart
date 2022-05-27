

class ServerException implements Exception {

  String reason;
  ServerException({this.reason = ""});
}

class CacheException implements Exception {

  String reason ;
  CacheException({this.reason = ""});
}

