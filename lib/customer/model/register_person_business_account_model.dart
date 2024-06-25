class RegisterPersonalAccount {
  String? name;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;

  RegisterPersonalAccount(
      {this.name, this.phone, this.email, this.password, this.confirmPassword});
}

class RegisterBusinessAccount {
  String? companyName;
  String? mobile;
  String? emailId;
  String? contactPerson;
  String? industry;
  String? noofPersonal;
  String? businessPassword;
  String? businessConfirmPassword;

  RegisterBusinessAccount(
      {this.companyName,
      this.mobile,
      this.emailId,
      this.contactPerson,
      this.industry,
      this.noofPersonal,
      this.businessPassword,
      this.businessConfirmPassword});
}
