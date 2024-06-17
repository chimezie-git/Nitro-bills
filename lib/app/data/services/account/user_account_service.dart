import 'package:dio/dio.dart' as dio;
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:nitrobills/app/controllers/account/user_account_controller.dart';
import 'package:nitrobills/app/data/models/user_account.dart';
import 'package:nitrobills/app/data/provider/app_error.dart';
import 'package:nitrobills/app/data/services/http/http_service.dart';
import 'package:nitrobills/app/data/services/type_definitions.dart';

class UserAccountService {
  static AsyncOrError<UserAccount> getAccount() async {
    String token = Get.find<UserAccountController>().authToken.value;

    TypeOrError<dio.Response> response = await HttpService.get(
        "https://nitrobills-backend.onrender.com/api/auth/user_data/",
        header: {
          "Content-Type": "application/json",
          "Authorization": "Token $token",
        });

    if (response.isRight) {
      String msg = response.right.data["msg"];
      if (response.right.statusCode == 200) {
        return Right(UserAccount.fromJson(response.right.data));
      } else {
        return Left(AppError(msg));
      }
    } else {
      return Left(response.left);
    }
  }
}