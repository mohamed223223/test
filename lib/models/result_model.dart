class ResultModel {
  ResultModel({
    required this.result,
    this.targetUrl,
    required this.success,
    this.error,
    required this.unAuthorizedRequest,
  });
  late final List<Result> result;
  late final Null targetUrl;
  late final bool success;
  late final Null error;
  late final bool unAuthorizedRequest;

  ResultModel.fromJson(Map<String, dynamic> json) {
    result = List.from(json['result']).map((e) => Result.fromJson(e)).toList();
    targetUrl = null;
    success = json['success'];
    error = null;
    unAuthorizedRequest = json['unAuthorizedRequest'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.map((e) => e.toJson()).toList();
    _data['targetUrl'] = targetUrl;
    _data['success'] = success;
    _data['error'] = error;
    _data['unAuthorizedRequest'] = unAuthorizedRequest;
    return _data;
  }
}

class Result {
  Result({
    required this.name,
    required this.aboute,
    required this.city,
    this.lat,
    this.lng,
  });
  late final String name;
  late final String? aboute;
  late final String city;
  late final String? lat;
  late final String? lng;

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    aboute = json["about"];
    city = json['city'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['aboute'] = aboute;
    _data['city'] = city;
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}
