abstract class IAuthRepository {
  Future login(Map<String, dynamic> loginCredentials);
  Future signUp(Map<String, dynamic> signUpCredentials);
  Future verifyUser();
}
