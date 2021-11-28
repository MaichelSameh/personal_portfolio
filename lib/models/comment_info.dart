enum CommentStatus { accepted, rejected, pending }

class CommentInfo {
  late String _id;
  late String _name;
  late String _role;
  late String _comment;
  late CommentStatus _status;
  late DateTime _createdAt;

  String get id => _id;
  String get name => _name;
  String get role => _role;
  String get comment => _comment;
  CommentStatus get status => _status;
  DateTime get createdAt => _createdAt;

  CommentInfo({
    required String id,
    required String name,
    required String role,
    required String comment,
    required CommentStatus status,
    required DateTime createdAt,
  }) {
    _id = id;
    _name = name;
    _role = role;
    _comment = comment;
    _status = status;
    _createdAt = createdAt;
  }

  CommentInfo.fromFirebase(Map<String, dynamic> map, String id) {
    _id = id;
    _comment = map["comment"];
    _name = map["author_name"];
    _role = map["author_role"];
    _status = map["status"] == "accepted"
        ? CommentStatus.accepted
        : map["status"] == "rejected"
            ? CommentStatus.rejected
            : CommentStatus.pending;
    _createdAt = DateTime.parse(map["created_at"]);
  }

  Map<String, dynamic> toMap() {
    String status = "";
    switch (_status) {
      case CommentStatus.accepted:
        status = "accepted";
        break;
      case CommentStatus.rejected:
        status = "rejected";
        break;
      case CommentStatus.pending:
        status = "pending";
        break;
    }
    return {
      "comment": comment,
      "author_name": name,
      "author_role": role,
      "status": status,
      "created_at": createdAt,
    };
  }

  @override
  String toString() {
    return 'CommentInfo(_name: $_name, _role: $_role, _comment: $_comment, _status: $_status)';
  }
}
