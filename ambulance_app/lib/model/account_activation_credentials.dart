class AccountActivationCredentials {
  String? phoneNumber;
  String? activationCode;

  AccountActivationCredentials({
    this.phoneNumber,
    this.activationCode
  });

  Map<String,String> toJson(){
    return {
      "phone_number":  phoneNumber.toString(),
      "code": activationCode.toString()
    };
  }
}