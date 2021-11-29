import 'package:intl/intl.dart';

class CategoryInfo {
  CategoryInfo({
    required String id,
    required String title,
  }) {
    _title = title;
    _id = id;
    _createdAt = DateTime.now();
  }

  CategoryInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _title = map["title"];
    _id = id;
    _createdAt = DateTime.tryParse(map["created_at"]) ?? DateTime.now();
  }

  late DateTime _createdAt;
  late String _id;
  late String _title;

  @override
  String toString() =>
      'CategoryInfo(_title: $_title, _id: $_id, _createdAt: $_createdAt)';

  String get title => _title;

  String get id => _id;

  DateTime get createdAt => _createdAt;

  void copyWith({
    String? title,
    String? id,
    DateTime? createdAt,
  }) {
    _title = title ?? _title;
    _id = id ?? _id;
    _createdAt = createdAt ?? _createdAt;
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "crated_at": DateFormat("yyyy-MM-dd").format(DateTime.now()),
    };
  }
}
