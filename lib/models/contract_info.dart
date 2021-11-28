class ContractInfo {
  late String _id;
  late String _email;
  late String _message;
  late String _name;
  late String _phone;
  late double _budget;
  late DateTime _createdAt;

  String get id => _id;
  String get email => _email;
  String get message => _message;
  String get name => _name;
  String get phone => _phone;
  double get budget => _budget;
  DateTime get createdAt => _createdAt;

  ContractInfo({
    required String id,
    required String email,
    required String message,
    required String name,
    required String phone,
    required double budget,
    required DateTime createdAt,
  }) {
    _id = id;
    _budget = budget;
    _createdAt = createdAt;
    _email = email;
    _message = message;
    _name = name;
    _phone = phone;
  }

  ContractInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _id = id;
    _budget = map["budget"];
    _createdAt = DateTime.parse(map["created_at"]);
    _email = map["email"];
    _message = map["message"];
    _name = map["name"];
    _phone = map["phone"];
  }

  @override
  String toString() {
    return 'ContractInfo(_email: $_email, _message: $_message, _name: $_name, _phone: $_phone, _budget: $_budget, _createdAt: $_createdAt)';
  }
}
