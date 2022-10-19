class ReviewModel {
  final String? author;
  final AuthorDetailModel? authorDetails;
  final String? content;
  final int? createdAt;
  final String? id;
  final bool? updatedAt;
  final String? url;

  ReviewModel({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      author: json['author'],
      authorDetails: AuthorDetailModel.fromJson(json['author_details']),
      content: json['content'],
      createdAt: json['created_at'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
    );
  }
}

class AuthorDetailModel {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  AuthorDetailModel({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  factory AuthorDetailModel.fromJson(Map<String, dynamic> json) {
    return AuthorDetailModel(
      name: json['name'],
      username: json['username'],
      avatarPath: json['avatar_path'],
      rating: json['rating'],
    );
  }

}