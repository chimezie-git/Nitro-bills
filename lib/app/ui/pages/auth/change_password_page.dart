import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/pages/auth/signin_page.dart';
import 'package:nitrobills/app/ui/pages/auth/widgets/auth_modal.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_image.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  ValueNotifier<bool> obscurePassword1 = ValueNotifier(true);
  ValueNotifier<bool> obscurePassword2 = ValueNotifier(true);

  @override
  void dispose() {
    obscurePassword1.dispose();
    obscurePassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 1.h,
              left: 5.w,
              right: 5.w,
              height: 110.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: const Color(0xFF434242),
                ),
              ),
            ),
            Positioned(
              top: 7.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: NbColors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NbButton.backIcon(_back),
                      60.verticalSpace,
                      NbText.sp22("Change password").w500.darkGrey,
                      12.verticalSpace,
                      NbText.sp16("Enter a new password and confirm.")
                          .w400
                          .darkGrey,
                      24.verticalSpace,
                      ValueListenableBuilder(
                          valueListenable: obscurePassword1,
                          builder: (context, obscure, child) {
                            return NbField.textAndIcon(
                              hint: "Enter Password",
                              obscureText: obscure,
                              trailing: InkWell(
                                onTap: () {
                                  obscurePassword1.value = !obscure;
                                },
                                child: SvgPicture.asset(
                                    obscure ? NbSvg.visible : NbSvg.notVisible),
                              ),
                            );
                          }),
                      20.verticalSpace,
                      ValueListenableBuilder(
                          valueListenable: obscurePassword2,
                          builder: (context, obscure, child) {
                            return NbField.textAndIcon(
                              hint: "Confirm Password",
                              obscureText: obscure,
                              trailing: InkWell(
                                onTap: () {
                                  obscurePassword2.value = !obscure;
                                },
                                child: SvgPicture.asset(
                                    obscure ? NbSvg.visible : NbSvg.notVisible),
                              ),
                            );
                          }),
                      32.verticalSpace,
                      NbButton.primary(
                          text: "Reset Password", onTap: _resetPassword),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _back() {
    Get.back();
  }

  void _resetPassword() {
    AuthModal.show(const SigninPage());
  }
}
