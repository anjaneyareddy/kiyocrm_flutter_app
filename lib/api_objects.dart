class ApiObjects {
  final String id;
  final String name;
  final Map<String, dynamic>? data;
  ApiObjects({required this.id, required this.name, required this.data});
  factory ApiObjects.fromjson(Map<String, dynamic> json) {
    return ApiObjects(id: json['id'], name: json['name'], data: json['data']);
  }
}
