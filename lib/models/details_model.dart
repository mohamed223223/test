class DetailsModels {
  DetailsModels({
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
  late final bool _Abp;

  DetailsModels.fromJson(Map<String, dynamic> json) {
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
    required this.id,
    required this.name,
    required this.status,
    required this.labors,
  });
  late final int id;
  late final String name;
  late final int status;
  late final List<Labors> labors;

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    labors = List.from(json['labors']).map((e) => Labors.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['labors'] = labors.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Labors {
  Labors({
    this.note,
    required this.status,
    required this.statment,
    required this.arabicName,
    required this.laborName,
  });
  late final String? note;
  late final int status;
  late final int statment;
  late final String arabicName;
  late final String laborName;

  Labors.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statment = json['statment'];
    arabicName = json['arabicName'];
    laborName = json['laborName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['note'] = note;
    _data['status'] = status;
    _data['statment'] = statment;
    _data['arabicName'] = arabicName;
    _data['laborName'] = laborName;
    return _data;
  }
}
