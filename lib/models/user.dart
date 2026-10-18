class User {
  final String id;
  final String email;
  final String name;
  final String? district;
  final int? experience;
  final bool verified;
  final String? bio;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.district,
    this.experience,
    required this.verified,
    this.bio,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      district: json['district'] as String?,
      experience: json['experience'] as int?,
      verified: json['verified'] as bool? ?? false,
      bio: json['bio'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'district': district,
      'experience': experience,
      'verified': verified,
      'bio': bio,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
