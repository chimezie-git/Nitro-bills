import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/data/enums/button_enum.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/repository/auth_repo.dart';
import 'package:nitrobills/app/data/services/validators.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_buttons.dart';
import 'package:nitrobills/app/ui/global_widgets/nb_field.dart';
import 'package:nitrobills/app/ui/utils/nb_colors.dart';
import 'package:nitrobills/app/ui/utils/nb_text.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({
    super.key,
  });

  @override
  State<ForgetPasswordPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<ForgetPasswordPage> {
  late TextEditingController phoneCntrl;
  ValueNotifier<ButtonEnum> buttonStatus = ValueNotifier(ButtonEnum.disabled);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool errorPhone = false;
  String? errorPhoneText;

  @override
  void initState() {
    super.initState();

    phoneCntrl = TextEditingController();
  }

  @override
  void dispose() {
    phoneCntrl.dispose();
    buttonStatus.dispose();
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
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NbButton.backIcon(_back),
                        55.verticalSpace,
                        NbText.sp22("Enter Phone Number").w500.darkGrey,
                        12.verticalSpace,
                        NbText.sp16(
                                "Enter the phone number associated with your account")
                            .w400
                            .setColor(const Color(0xFF929090)),
                        32.verticalSpace,
                        NbField.text(
                            keyboardType: TextInputType.phone,
                            hint: "080 - 0000 -0000",
                            controller: phoneCntrl,
                            forcedError: errorPhone,
                            forcedErrorString: errorPhoneText,
                            onChanged: _onChange,
                            validator: () {
                              if (!NbValidators.isPhone(phoneCntrl.text)) {
                                return "Enter a valid Phone Number";
                              } else {
                                return null;
                              }
                            }),
                        24.verticalSpace,
                        ValueListenableBuilder(
                            valueListenable: buttonStatus,
                            builder: (context, value, child) {
                              return NbButton.primary(
                                text: "Reset Password",
                                onTap: _resetPassword,
                                status: value,
                              );
                            }),
                      ],
                    ),
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

  void _onChange(String? v) {
    if (NbValidators.isPhone(phoneCntrl.text)) {
      buttonStatus.value = ButtonEnum.active;
    } else {
      buttonStatus.value = ButtonEnum.disabled;
    }
    formKey.currentState?.reset();
    _resetForcedError();
  }

  void _resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      buttonStatus.value = ButtonEnum.loading;
      final data = await AuthRepo().forgetPassword(context, phoneCntrl.text);
      if (data.isLeft) {
        _setError(data.left);
      }
      buttonStatus.value = ButtonEnum.active;
    }
  }

  void _setError(SingleFieldError error) {
    errorPhone = true;
    errorPhoneText = error.message;
    setState(() {});
  }

  void _resetForcedError() {
    errorPhone = false;
    errorPhoneText = null;
    setState(() {});
  }
}
