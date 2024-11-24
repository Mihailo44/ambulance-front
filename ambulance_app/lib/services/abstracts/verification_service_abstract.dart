import 'package:ambulance_app/model/account_activation_credentials.dart';

abstract class VerificationServiceAbstract {
  Future<void> activateAccount(AccountActivationCredentials credentials);
  Future<void> resendActivationCode();
}