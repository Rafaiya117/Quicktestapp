import 'package:demo_riverpod/core/color.dart';
import 'package:demo_riverpod/providers/feedback_provider.dart';
import 'package:demo_riverpod/providers/team_provider.dart';
import 'package:demo_riverpod/services/feedback_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubmitFeedback extends ConsumerWidget {
  const SubmitFeedback({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMode = ref.watch(feedbackModeProvider);
    final feedbackService = Provider<FeedbackService>((ref) => FeedbackService());
    final feedservice = ref.read(feedbackService);
    return Scaffold(
      backgroundColor: AppsColor.solid_backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: AppsColor.solid_backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Submit Feedback',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Category',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white24),
                ),
                child: DropdownButton<FeedbackMode>(
                  value: selectedMode,
                  isExpanded: true,
                  dropdownColor: Colors.grey[900],
                  underline: const SizedBox.shrink(),
                  items: FeedbackMode.values.map((mode) {
                    return DropdownMenuItem(
                      value: mode,
                      child: Text(
                        mode.name.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(feedbackModeProvider.notifier).state = value;
                    }
                  },
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                'Feedback',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  hintText: "write feedback.....",
                  hintStyle: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 10.sp,
                ),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w,
                  ),
                ),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 20.h,),
              ElevatedButton(
                onPressed: () async {
                  final teamId = ref.read(currentTeamIdProvider);
                  if (teamId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Team ID not available')),
                    );
                    return; 
                  }
                  try {
                    await feedservice.submitFeedback(teamId, 'Work', 'message');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Feedback submitted successfully'),
                      ),
                    );
                  } on AuthApiException catch (e) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(e.message)));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 4,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF071952), Color(0xFF088395)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      "Send Feedback",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
