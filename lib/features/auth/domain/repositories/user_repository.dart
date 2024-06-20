abstract class IUserRepository {
  Future<void> addUser(String userId, String fullName, String phoneNumber);
}
