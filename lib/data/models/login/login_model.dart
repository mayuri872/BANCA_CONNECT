

class RequestLogin {
  String? username;
  String? password;

  RequestLogin({
    this.username,
    this.password,
  });

  RequestLogin.fromJson(Map<String, dynamic> json) {
    username = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = username;
    data['password'] = password;
    return data;
  }
}
