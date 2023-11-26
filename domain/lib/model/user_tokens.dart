class UserTokens {
  UserTokens({required this.accessToken, this.refreshToken});

  factory UserTokens.empty() => UserTokens(accessToken: '');

  String accessToken;
  String? refreshToken;
}
