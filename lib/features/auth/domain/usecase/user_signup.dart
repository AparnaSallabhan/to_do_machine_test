import 'package:fpdart/fpdart.dart';
import 'package:to_do_machine_test/core/error/failures.dart';
import 'package:to_do_machine_test/core/common/entities/user.dart';
import 'package:to_do_machine_test/features/auth/domain/repositories/auth_repository.dart';

class UserSignup {
  final AuthRepository authRepository;

  UserSignup(this.authRepository);

  Future<Either<Failure, User>> call(UserParams userdata) async {
    return await authRepository.signUpWithEmailPassword(
      email: userdata.email,
      passWord: userdata.passWord,
    );
  }
}

class UserParams {
  final String email;
  final String passWord;

  UserParams({required this.email, required this.passWord});
}
