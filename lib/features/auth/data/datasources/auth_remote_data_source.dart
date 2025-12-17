import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_do_machine_test/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw Exception('User not found!');
      }

      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession == null) return null;

      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession!.user.id)
          .maybeSingle();

      if (userData == null) {
        return UserModel(
          id: currentUserSession!.user.id,
          email: currentUserSession!.user.email??'',
        );
      }

      return UserModel.fromJson(userData).copyWith(
        email: currentUserSession!.user.email,
        id: currentUserSession!.user.id,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
