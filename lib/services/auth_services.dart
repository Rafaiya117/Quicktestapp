import 'package:demo_riverpod/core/supabase_cleint.dart';
import 'package:demo_riverpod/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthService {
  final _client = SupabaseClientManager.client;

  Future<void> signIn(String email, String password, WidgetRef ref) async {
    final res = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = res.user;
    if(user != null){
      ref.read(currentUserIdProvider.notifier).state = user.id;
    }
  }

  Future<void> signUp(String email, String password, String name, WidgetRef ref) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) throw Exception('User creation failed');
    ref.read(currentUserIdProvider.notifier).state = user.id;

    debugPrint('!---------- User ID: ${user}');
    if (user == null) throw Exception('User creation failed');

    await _client.from('profiles').insert({
      'id': user.id,
      'name': 'rushdha',
    });
  }

  Future<void> signOut(WidgetRef ref) async {
    await _client.auth.signOut();
    ref.read(currentUserIdProvider.notifier).state = null;
  }
}