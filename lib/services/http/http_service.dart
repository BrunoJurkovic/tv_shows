abstract class BaseHttpRequest {
  const BaseHttpRequest({
    required this.endpoint,
  });
  final String endpoint;
  Map<String, dynamic> toMap();
}

abstract class BaseHttpService {
  Future get({
    required BaseHttpRequest request,
    required Function(Map<String, dynamic> data) converter,
  });
  Future post({
    required BaseHttpRequest request,
    required Function(Map<String, dynamic> data) converter,
  });
  Future delete({
    required BaseHttpRequest request,
    required Function(Map<String, dynamic> data) converter,
  });
}
