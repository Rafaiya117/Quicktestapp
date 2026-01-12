import 'package:demo_riverpod/models/feedback_model.dart';
import 'package:demo_riverpod/services/feedback_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final feedbackServiceProvider = Provider((ref) => FeedbackService());

final feedbackStreamProvider = StreamProvider.family<List<FeedbackModel>, String>((ref, teamId) {
  return ref.read(feedbackServiceProvider).streamFeedback(teamId);
});