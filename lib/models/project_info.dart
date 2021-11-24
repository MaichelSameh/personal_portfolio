class ProjectInfo {
  late List<dynamic> _imageURL;
  late String _name;
  late String _id;
  late String _description;

  String get id => _id;
  String get name => _name;
  List<dynamic> get imageURL => _imageURL;
  String get description => _description;

  ProjectInfo({
    required List<dynamic> imageURL,
    required String name,
    required String id,
    required String description,
  }) {
    _imageURL = imageURL;
    _name = name;
    _id = id;
    _description = description;
  }

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
      'id': id,
      "description": description,
    };
  }

  ProjectInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _imageURL = map['image_url'];
    _name = map['title'];
    _id = id;
    _description = map["description"];
  }

  @override
  String toString() =>
      'ProjectInfo(imageURL: $imageURL, name: $name, id: $id, description: $description)';
}
