import 'package:demo_riverpod/core/color.dart';
import 'package:demo_riverpod/core/supabase_cleint.dart';
import 'package:demo_riverpod/providers/auth_provider.dart';
import 'package:demo_riverpod/providers/team_provider.dart';
import 'package:demo_riverpod/services/team_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teamServiceProvider  = Provider<TeamService>((ref) => TeamService(),);
    final TextEditingController team_name =TextEditingController();
    final TextEditingController join_code =TextEditingController();
    return Scaffold(
      backgroundColor: AppsColor.solid_backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation:0,
        elevation: 0,
        backgroundColor: AppsColor.solid_backgroundColor,
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
            child: Consumer(
              builder: (context, ref, _) {
                final mode = ref.watch(teamModeProvider);
                return Column(
                  children: [
                    Text(
                      'Create or Join Team',
                      style: GoogleFonts.italiana(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            ref.read(teamModeProvider.notifier).state = TeamMode.create;
                          },
                          child: Container(
                            width: 150.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              gradient: LinearGradient(
                                colors: mode == TeamMode.create
                                ?[Colors.grey, Colors.grey] 
                                :[Color(0xFF071952), Color(0xFF088395)] ,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                'Create Team',
                                style: GoogleFonts.italiana(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(teamModeProvider.notifier).state = TeamMode.join;
                          },
                          child: Container(
                            width: 150.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: mode == TeamMode.join
                                ? Colors.grey
                                : Colors.blueAccent,
                            ),
                            child: Center(
                              child: Text(
                                'Join Team',
                                style: GoogleFonts.italiana(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100.h),
                    mode == TeamMode.create
                    ? Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 0.2
                        ),
                        borderRadius: BorderRadius.circular(6.0)
                      ),
                      child: Padding(
                        padding:EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Text(
                            'Create Team',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            TextFormField(
                              controller: team_name,
                              decoration: InputDecoration(
                                hintText: "Team Name",
                                hintStyle: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              filled: true,
                              fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
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
                            try{
                              final teamService = ref.read(teamServiceProvider);
                              final teamName = team_name.text.trim();
                              final userId = ref.watch(currentUserIdProvider);

                              final session = SupabaseClientManager.client.auth.currentSession;
                              debugPrint('SESSION USER: ${session?.user.id}');

                              debugPrint('!--------$userId, $teamName');
                              await teamService.createTeam(teamName, userId!);
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:Text('Create successful')),
                            );                            
                           }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:Text('$e')),
                            );
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
                              gradient: LinearGradient(
                              colors: [
                                Color(0xFF071952),
                                Color(0xFF088395),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                "Create Team",
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
                )
                : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.2
                      ),
                      borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        child: Column(
                          children: [
                            Text(
                            'Join Team',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            TextFormField(
                              controller: join_code,
                              decoration: InputDecoration(
                                hintText: "Join code",
                                hintStyle: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              filled: true,
                              fillColor: Colors.white24,
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
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
                            try{
                              final teamService = ref.read(teamServiceProvider);
                              final joincode = join_code.text.trim();
                              final userId = ref.watch(currentUserIdProvider);
                              //final teamId =  ref.read(currentTeamIdProvider);
                              final session = SupabaseClientManager.client.auth.currentSession;
                              debugPrint('SESSION USER: ${session?.user.id}');

                              debugPrint('!--------$userId, $joincode');
                              await teamService.joinTeam(joincode, userId!);
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:Text('JOining successful')),
                            ); 
                            context.push('/feedbacklist');                           
                           }catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content:Text('$e')),
                            );
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
                              gradient: LinearGradient(
                              colors: [
                                Color(0xFF071952),
                                Color(0xFF088395),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  "Join Team",
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
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}