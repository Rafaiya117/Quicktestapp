import 'dart:ui';

import 'package:demo_riverpod/core/color.dart';
import 'package:demo_riverpod/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final  authService = AuthService();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: AppsColor.solid_backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: GoogleFonts.italiana(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            children: [
                              TextSpan(text: "Q"),
                              TextSpan(
                                text: "uickTest",
                                style: GoogleFonts.italiana(
                                  fontSize: 40.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white, 
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          "Annonymous Team Feedback",
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.h,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white.withOpacity(0.2),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white12,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 16.w,
                                  ),
                                ),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white12,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 16.w,
                                  ),
                                ),
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 30.h),
                              ElevatedButton(
                                onPressed: ()async {
                                  final email = emailController.text.trim();
                                  final password = passwordController.text.trim();
                                  await authService.signIn(
                                    email, 
                                    password
                                  );
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
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              TextButton(
                                onPressed: (){},
                                child: Text(
                                "Forgot Password?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}