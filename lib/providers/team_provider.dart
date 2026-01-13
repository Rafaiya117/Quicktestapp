import 'package:demo_riverpod/providers/auth_provider.dart';
import 'package:demo_riverpod/services/team_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final teamServiceProvider = Provider((ref) => TeamService());

final teamProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) throw Exception('Not authenticated');

  return ref.read(teamServiceProvider).getUserTeam(user.id);
});

enum TeamMode { create, join }
final teamModeProvider = StateProvider<TeamMode>((ref) => TeamMode.create);

final currentTeamIdProvider = StateProvider<String?>((ref) => null);

