abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? query,
  });

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  });

  Future<dynamic> put(
    String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  });
}
