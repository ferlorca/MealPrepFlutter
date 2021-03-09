class User {
  String id;
  String email;
  String displayName;
  String role;
  String lastSignInTime;
  String creationTime;

  User(
      {this.id,
      this.role,
      this.email,
      this.creationTime,
      this.displayName,
      this.lastSignInTime});

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
        id: json['uid'],
        email: json['email'],
        displayName: json['displayName'],
        role: json['role'],
        lastSignInTime: json['lastSignInTime'],
        creationTime: json['creationTime']);
  }
}
