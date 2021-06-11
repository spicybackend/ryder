class Profile {
  final String? id;
  final String username;
  final String? bio;
  final String? avatarUrl;

  Profile({
    this.id,
    required this.username,
    this.bio,
    this.avatarUrl,
  });

  static Profile fromJson(dynamic json) {
    return Profile(
      id: json['id'],
      username: json['username'] as String,
      bio: json['bio'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );
  }
}
