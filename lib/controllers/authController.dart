import 'package:e_book/utils/exports.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  var _firebaseAuth = FirebaseAuth.instance;
  var _firebaseUser = Rx<User?>(null);
  var _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  logInWithGoogle() async {
    googleAccount.value = await _googleSignIn.signIn();
  }

  logoOutFromGoogle() async {
    googleAccount.value = await _googleSignIn.signOut();
  }

  // Future<User?> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount!.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken,
  //     );
  //     final userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //
  //     final User? user = userCredential.user;
  //
  //     assert(!user!.isAnonymous);
  //     assert(await user!.getIdToken() != null);
  //
  //     final User? currentUser = _firebaseAuth.currentUser;
  //
  //     assert(currentUser!.uid == user!.uid);
  //     return user;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
