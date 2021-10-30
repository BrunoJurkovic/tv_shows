import 'package:tv_shows/business_logic/utils/media_utils.dart';

abstract class BaseHttpPostRequest {
  const BaseHttpPostRequest({
    required this.endpoint,
  });
  final String endpoint;
  Map<String, dynamic> toMap();
}

abstract class BaseHttpGetRequest {
  const BaseHttpGetRequest({
    required this.endpoint,
  });
  final String endpoint;
}

abstract class BaseHttpDeleteRequest {
  const BaseHttpDeleteRequest({
    required this.endpoint,
  });
  final String endpoint;
  Map<String, dynamic> toMap();
}

abstract class BaseHttpService {
  Future get({
    required BaseHttpGetRequest request,
  });
  Future post({
    required BaseHttpPostRequest request,
  });
  Future delete({
    required BaseHttpDeleteRequest request,
  });
  Future<dynamic> postFormData({
    required MediaRequest request,
  });
}
