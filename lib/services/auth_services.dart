import 'package:demo_riverpod/core/supabase_cleint.dart';

class AuthService {
  final _client = SupabaseClientManager.client;

  Future<void> signIn(String email, String password) async {
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp(String email, String password, String name) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) throw Exception('User creation failed');

    await _client.from('profiles').insert({
      'id': user.id,
      'name': name,
    });
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
  }
}