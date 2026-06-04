import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign Up with Email & Password
  // Returns null on success, error message on failure
  Future<String?> signUp(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update Profile immediately
      await credential.user?.updateDisplayName("$firstName $lastName");
      await credential.user?.reload(); // Ensure profile is refreshed
      
      // Sign out so they have to login properly to start session
      await _auth.signOut();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "An error occurred during signup";
    } catch (e) {
      return e.toString();
    }
  }

  // Login
  // Returns null on success, error message on failure
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message ?? "Login failed. Please check your credentials.";
    } catch (e) {
      return e.toString();
    }
  }

  // Logout
  Future<void> logout() async {
    await _auth.signOut();
  }
}
