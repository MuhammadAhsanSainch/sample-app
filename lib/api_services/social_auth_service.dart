import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path_to_water/api_core/custom_exception_handler.dart';
import 'package:path_to_water/api_services/auth_services.dart';
import 'package:path_to_water/features/home/home_binding.dart';
import 'package:path_to_water/features/home/home_view.dart';
import 'package:path_to_water/utilities/app_extensions.dart';
import 'package:path_to_water/utilities/app_globals.dart';
import 'package:path_to_water/utilities/shared_preference.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static Future<void> signInWithGoogle([void Function()? onSuccess]) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      User? user = _auth.currentUser;

      // final googleAuth = await googleUser.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // await _auth.signInWithCredential(credential);
      log('Full Name :${user?.displayName}');
      log('User Name :${user!.displayName?.removeAllWhiteSpaces.toLowerCase()}');
      log('Email :${user?.email}');
      log('Email :${user?.photoURL}');

      //Login
      await _logIn(
        {
          "email": user.email,
          "userName": user.displayName?.removeAllWhiteSpaces.toLowerCase(),
          "name": user.displayName,
          "authProvider": "GOOGLE",
        },

        // {"email": user?.email, "authProvider": "GOOGLE"},
        onSuccess,
      );
    } catch (e) {
      log('Error: ${e.toString()}');
      Get.snackbar('Error', e.toString());
    }
  }

  static Future<void> signInWithApple([void Function()? onSuccess]) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final user = authResult.user;
      log('Full Name : ${user?.displayName ?? appleCredential.givenName ?? 'Unknown'}');
      log(
        'User Name : ${(user?.displayName ?? appleCredential.givenName ?? '').removeAllWhiteSpaces.toLowerCase()}',
      );
      log('Email : ${user?.email ?? 'No Email (Possibly hidden by Apple)'}');
      log('Photo URL : ${user?.photoURL ?? 'Not available'}');

      //Login
      await _logIn(
        {
          "email": user?.email,
          "userName": (user?.displayName?.removeAllWhiteSpaces ?? user?.email)?.toLowerCase(),
          "name": user?.displayName,
          "authProvider": "GOOGLE",
        },

        // {"email": user?.email, "authProvider": "APPLE"},
        onSuccess,
      );
    } catch (e) {
      log('Apple Sign-In Error: ${e.toString()}');
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  static Future _logIn(Map<String, dynamic> data, [void Function()? onSuccess]) async {
    try {
      AppGlobals.isLoading(true);

      final res = await AuthServices.signUp(data);
      if (res?.user != null) {
        UserPreferences.loginData = res?.user?.toJson() ?? {};
        UserPreferences.isLogin = true;
        UserPreferences.isSocialLogin = true;
        UserPreferences.authToken = res?.accessToken ?? "";
        UserPreferences.userId = res?.user?.id ?? "";
        if (onSuccess != null) {
          onSuccess?.call();
        } else {
          Get.to(() => HomeView(), binding: HomeBinding());
        }
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
