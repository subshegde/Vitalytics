class User {
  int? id;
  String username;
  String email;
  String password;
  String? bio;
  String? profilePicPath;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    this.bio,
    this.profilePicPath,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int?,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      bio: map['bio'] as String?,
      profilePicPath: map['profile_pic_path'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'bio': bio,
      'profile_pic_path': profilePicPath,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }
}
