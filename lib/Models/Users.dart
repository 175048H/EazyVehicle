class Users {
  int id;
  String fullName;
  String userName;
  String password;
  String email;
  String contactNo;
  int role;

  Users(
      {this.id,
      this.fullName,
      this.userName,
      this.password,
      this.email,
      this.contactNo,
      this.role});

  factory Users.fromJson(Map<dynamic, dynamic> json) {
    return Users(
      id: json['id'],
      fullName: json['fullName'],
      userName: json['userName'],
      password: json['password'],
      email: json['email'],
      contactNo: json['contactNo'],
      role: json['role'],
    );
  }
}
