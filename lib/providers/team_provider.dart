import 'package:demo_riverpod/providers/auth_provider.dart';
import 'package:demo_riverpod/services/team_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final teamServiceProvider = Provider((ref) => TeamService());

final teamProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) throw Exception('Not authenticated');

  return ref.read(teamServiceProvider).getUserTeam(user.id);
});