import 'package:demo_riverpod/core/supabase_cleint.dart';

class TeamService {
  final _client = SupabaseClientManager.client;

  String _generateJoinCode() {
    return DateTime.now().millisecondsSinceEpoch.toString().substring(7);
  }

  Future<void> createTeam(String teamName, String userId) async {
    final joinCode = _generateJoinCode();

    final team = await _client.from('teams').insert({
      'name': teamName,
      'join_code': joinCode,
      'owner_id': userId,
    }).select().single();

    await _client.from('team_members').insert({
      'team_id': team['id'],
      'user_id': userId,
      'role': 'admin',
    });
  }

  Future<void> joinTeam(String joinCode, String userId) async {
    final team = await _client.from('teams').select().eq('join_code', joinCode).single();

    await _client.from('team_members').insert({
      'team_id': team['id'],
      'user_id': userId,
      'role': 'member',
    });
  }

  Future<Map<String, dynamic>> getUserTeam(String userId) async {
    return await _client
        .from('team_members')
        .select('role, teams(*)')
        .eq('user_id', userId)
        .single();
  }
}