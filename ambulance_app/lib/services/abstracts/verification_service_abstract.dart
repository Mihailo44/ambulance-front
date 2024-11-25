import 'package:ambulance_app/model/account_activation_credentials.dart';

abstract class VerificationServiceAbstract {
  Future<bool> activateAccount(AccountActivationCredentials credentials);
  Future<void> resendActivationCode();
}