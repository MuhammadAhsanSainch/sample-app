import '../../api_core/custom_exception_handler.dart';
import '../../api_services/auth_services.dart';
import '../../utilities/app_exports.dart';
import '../home/home_binding.dart';
import '../home/home_view.dart';

class LoginController extends GetxController {
  // final FirebaseAuth _auth= FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn= GoogleSignIn();
  final TextEditingController emailTFController = TextEditingController();
  final TextEditingController passwordTFController = TextEditingController();

  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return;

  //     // final googleAuth = await googleUser.authentication;
  //     // final credential = GoogleAuthProvider.credential(
  //     //   accessToken: googleAuth.accessToken,
  //     //   idToken: googleAuth.idToken,
  //     // );
  //     // await _auth.signInWithCredential(credential);
  //     log('Full Name :${user?.displayName}');
  //     log('User Name :${user?.displayName.removeAllWhiteSpaces.toLowerCase()}');
  //     log('Email :${user?.email}');
  //     log('Email :${user?.photoURL}');
  //     logIn({
  //       "email": user?.email,
  //       "authProvider": "GOOGLE"
  //     });
  //   } catch (e) {
  //     log('Error: ${e.toString()}');
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  // Future<void> signInWithApple() async {
  //   try {
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       accessToken: appleCredential.authorizationCode,
  //     );

  //     final authResult =
  //     await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  //     final user = authResult.user;
  //     log('Full Name : ${user?.displayName ?? appleCredential.givenName ?? 'Unknown'}');
  //     log('User Name : ${(user?.displayName ?? appleCredential.givenName ?? '').removeAllWhiteSpaces.toLowerCase()}');
  //     log('Email : ${user?.email ?? 'No Email (Possibly hidden by Apple)'}');
  //     log('Photo URL : ${user?.photoURL ?? 'Not available'}');
  //     logIn({
  //       "email": user?.email,
  //       "authProvider": "APPLE"
  //     });
  //   } catch (e) {
  //     log('Apple Sign-In Error: ${e.toString()}');
  //     Get.snackbar('Error', e.toString());
  //   }
  // }

  // Future<void> signOut() async {
  //   await _googleSignIn.signOut();
  //   await _auth.signOut();
  // }

  // User? get user => _auth.currentUser;
  @override
  void dispose() {
    emailTFController.dispose();
    passwordTFController.dispose();
    super.dispose();
  }

  static LoginController get to {
    try {
      return Get.find<LoginController>();
    } catch (e) {
      return Get.put(LoginController());
    }
  }

  Future logIn(Map<String, dynamic>? payload) async {
    try {
      AppGlobals.isLoading(true);
      Map<String, dynamic> data =
          payload ??
          {
            "email": emailTFController.text,
            "password": passwordTFController.text,
            "fcmToken": AppGlobals.fcmToken,
          };
      final res = await AuthServices.loginIn(data);
      if (res?.user != null) {
        UserPreferences.loginData = res?.user?.toJson() ?? {};
        UserPreferences.isLogin = true;
        UserPreferences.isSocialLogin = false;
        UserPreferences.authToken = res?.accessToken ?? "";
        UserPreferences.userId = res?.user?.id ?? "";
        Get.off(() => HomeView(), binding: HomeBinding());
      }
    } on Exception catch (e) {
      ExceptionHandler().handleException(e);
    } catch (e) {
      log(e.toString());
    } finally {
      AppGlobals.isLoading(false);
    }
  }
}
