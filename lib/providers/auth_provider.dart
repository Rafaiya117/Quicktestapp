import 'package:demo_riverpod/core/supabase_cleint.dart';
import 'package:demo_riverpod/features/auth/controller/login_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final authStateProvider = StreamProvider((ref) {
  return SupabaseClientManager.client.auth.onAuthStateChange.map((event) => event.session);
});

final currentUserProvider = Provider((ref) {
  return SupabaseClientManager.client.auth.currentUser;
});

final authServiceProvider = StateProvider<bool>((ref) => false);
final authErrorProvider = StateProvider<String?>((ref) => null);
// final loginControllerProvider = Provider<LoginController>(
//   (ref) => LoginController(ref),
// );