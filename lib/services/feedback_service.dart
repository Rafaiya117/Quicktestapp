import 'package:demo_riverpod/core/supabase_cleint.dart';
import 'package:demo_riverpod/models/feedback_model.dart';

class FeedbackService {
  final _client = SupabaseClientManager.client;

  Future<void> submitFeedback(String teamId,String category,String message,) async {
    await _client.from('feedback').insert({
      'team_id': teamId,
      'category': category,
      'message': message,
    });
  }

  Stream<List<FeedbackModel>> streamFeedback(String teamId) {
    return _client.from('feedback').stream(primaryKey: ['id']).eq('team_id', teamId).order('created_at').map((rows) =>
      rows.map((e) => FeedbackModel.fromJson(e)).toList());
  }

  Future<List<FeedbackModel>> getAllFeedback(String teamId) async {
    final res = await _client.from('feedback').select().eq('team_id', teamId);

    return (res as List).map((e) => FeedbackModel.fromJson(e)).toList();
  }
}