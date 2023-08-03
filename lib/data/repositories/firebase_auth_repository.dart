import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:garage/core/services/firebase/fb_auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthRepository {


  static Future withGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FBAuthService.I.signInWithCredential(credential);
    }
  }

  static Future withFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if(result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;

      final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

      return await FBAuthService.I.signInWithCredential(credential);
    }
  }

  static Future withApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
    final OAuthCredential firebaseCredential = oAuthProvider.credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    return await FBAuthService.I.signInWithCredential(firebaseCredential);

  }

}