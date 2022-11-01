import 'package:JF_InfoTech/data/repository/auth_repo.dart';
import 'package:JF_InfoTech/models/response_model.dart';
import 'package:JF_InfoTech/models/signupbody_body_model.dart';
import 'package:get/get.dart';


class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
   required this.authRepo,
});

  bool _isoloading = false;
  bool get isLoading => _isoloading;

  Future<ResponseModel>registration(SignUpBody signUpBody) async {
    _isoloading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isoloading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel>login(String phone,String password) async {
    print("getting token");
    print(authRepo.getUserToken().toString());
    _isoloading = true;
    update();
    Response response = await authRepo.login(phone ,password);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      print("Backend token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isoloading = false;
    update();
    return responseModel;
  }


    void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password) ;


  }


  bool userLoggedIn()  {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData(){
    return authRepo.clearSharedData();
  }

}