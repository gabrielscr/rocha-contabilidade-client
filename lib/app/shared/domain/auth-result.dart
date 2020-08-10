class AuthResult {
  bool authenticated;
  String created;
  String expiration;
  String accessToken;
  String message;

  AuthResult(
      {this.authenticated,
      this.created,
      this.expiration,
      this.accessToken,
      this.message});

  AuthResult.fromJson(Map<String, dynamic> json) {
    authenticated = json['authenticated'];
    created = json['created'];
    expiration = json['expiration'];
    accessToken = json['accessToken'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authenticated'] = this.authenticated;
    data['created'] = this.created;
    data['expiration'] = this.expiration;
    data['accessToken'] = this.accessToken;
    data['message'] = this.message;
    return data;
  }
}
