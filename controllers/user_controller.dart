import 'package:JF_InfoTech/data/repository/user_repo.dart';
import 'package:JF_InfoTech/models/user_model.dart';
import 'package:get/get.dart';

import '../models/response_model.dart';
import '../models/signupbody_body_model.dart';
class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isoloading = false;
  bool get isLoading => _isoloading;

  late UserModel _userModel;
  UserModel get userModel =>_userModel;

  Future<ResponseModel>getUserInfo() async {

    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isoloading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}