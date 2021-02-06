abstract class IHttpClient {
  Future<HttpResult> get(String url, {Map<String, String> headers});
  Future<HttpResult> post(String url, String body,
      {Map<String, String> headers});
}

class HttpResult {
  final String data;
  final Status status;

  const HttpResult(this.data, this.status);
}

enum Status { success, failure }
