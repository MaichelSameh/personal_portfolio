import 'package:intl/intl.dart';

class ProjectInfo {
  ProjectInfo({
    required List<dynamic> imageURL,
    required String name,
    required String id,
    required String description,
    required DateTime createdAt,
  }) {
    _imageURL = imageURL;
    _name = name;
    _id = id;
    _description = description;
    _createdAt = createdAt;
  }

  ProjectInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _imageURL = map['image_url'];
    _name = map['title'];
    _id = id;
    _description = map["description"];
    _createdAt = DateTime.parse(map["created_at"]);
  }

  late DateTime _createdAt;
  late String _description;
  late String _id;
  late List<dynamic> _imageURL;
  late String _name;

  @override
  String toString() =>
      'ProjectInfo(imageURL: $imageURL, name: $name, id: $id, description: $description)';

  String get id => _id;

  String get name => _name;

  List<dynamic> get imageURL => _imageURL;

  String get description => _description;

  DateTime get createdAt => _createdAt;

  void copyWith({
    List<dynamic>? imageURL,
    String? name,
    String? id,
  }) {
    _imageURL = imageURL ?? _imageURL;
    _name = name ?? _name;
    _id = id ?? _id;
  }

  Map<String, dynamic> toMap() {
    return {
      'image_url': imageURL,
      'name': name,
      "description": description,
      "crated_at": DateFormat("yyyy-MM-dd").format(createdAt),
    };
  }
}
