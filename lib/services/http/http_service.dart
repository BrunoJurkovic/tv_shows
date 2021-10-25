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
  });
  Future post({
    required BaseHttpRequest request,
  });
  Future delete({
    required BaseHttpRequest request,
  });
}
