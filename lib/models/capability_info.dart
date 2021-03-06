import 'package:intl/intl.dart';

class CapabilityInfo {
  CapabilityInfo({
    required String id,
    required String title,
    required String description,
    required String imageURL,
  }) {
    _id = id;
    _title = title;
    _description = description;
    _imageURL = imageURL;
  }

  CapabilityInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _id = id;
    _title = map["title"];
    _description = map["description"];
    _imageURL = map["image_url"];
  }

  late String _description;
  late String _id;
  late String _imageURL;
  late String _title;

  @override
  String toString() {
    return 'CapabilityInfo(_id: $_id, _title: $_title, _description: $_description, _imageURL: $_imageURL)';
  }

  String get id => _id;

  String get title => _title;

  String get description => _description;

  String get imageURL => _imageURL;

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "image_url": imageURL,
      "crated_at": DateFormat("yyyy-MM-dd").format(DateTime.now()),
    };
  }
}
