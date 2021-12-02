class User {
  final int pk;
  final String email;
  final String username;
  final String date_joined;
  final String last_login;
  final int numTel;
  final bool is_active;
  final String password;

  User({this.pk, this.email, this.username, this.date_joined, this.last_login,this.numTel, this.is_active, this.password});



  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      pk: json['pk'],
      email: json['email'],
      username: json['username'],
      date_joined: json['date_joined'],
      last_login: json['last_login'],
      is_active: json['is_active'],
      numTel: json['numTel'],
      password: json['password'],
    );
  }
}


