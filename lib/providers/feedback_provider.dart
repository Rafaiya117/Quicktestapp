import 'package:demo_riverpod/models/feedback_model.dart';
import 'package:demo_riverpod/services/feedback_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final feedbackServiceProvider = Provider((ref) => FeedbackService());

final feedbackStreamProvider = StreamProvider.family<List<FeedbackModel>, String>((ref, teamId) {
  return ref.read(feedbackServiceProvider).streamFeedback(teamId);
});

enum FeedbackMode { all, work, culture, management }

final feedbackModeProvider = StateProvider<FeedbackMode>((ref) => FeedbackMode.all);
final selectedFeedbackProvider = StateProvider<FeedbackModel?>((ref) => null);

final filteredFeedbackProvider = Provider.family<AsyncValue<List<FeedbackModel>>, String>((ref, teamId) {
  final feedbackAsync = ref.watch(feedbackStreamProvider(teamId));
  final selectedMode = ref.watch(feedbackModeProvider);

  return feedbackAsync.whenData((feedbacks) {
    if (selectedMode == FeedbackMode.all) {
      return feedbacks;
    }
    return feedbacks.where((f) => f.feedbackMode == selectedMode).toList();
  });
});

