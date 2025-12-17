import 'package:to_do_machine_test/core/common/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] ?? "", email: json['email'] ?? '');
  }

  UserModel copyWith({String? id, String? email}) {
    return UserModel(id: id ?? this.id, email: email ?? this.email);
  }
}
