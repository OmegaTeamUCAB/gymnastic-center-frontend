abstract class IAuthRepository {
  Future login(loginCredentials);
  Future signUp(formData);
}
