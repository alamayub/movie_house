class MovieVideoModel {
  // final String iso_639_1;
  // final String iso_3166_1;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String? id;
  final String? img;
  final String? url;

  MovieVideoModel({
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
    this.img,
    this.url,
  });

  factory MovieVideoModel.fromJson(Map<String, dynamic> json) {
    return MovieVideoModel(
      name: json['name'],
      key: json['key'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
      official: json['official'],
      publishedAt: json['published_at'],
      id: json['id'],
      img: 'https://img.youtube.com/vi/${json['key']}/hqdefault.jpg',
      url: 'https://www.youtube.com/watch?v=${json['key']}.mp4',
    );
  }
}

// Width | Height | URL
// ------|--------|----
// 120   | 90     | https://i.ytimg.com/vi/<VIDEO ID>/1.jpg
// 120   | 90     | https://i.ytimg.com/vi/<VIDEO ID>/2.jpg
// 120   | 90     | https://i.ytimg.com/vi/<VIDEO ID>/3.jpg
// 120   | 90     | https://i.ytimg.com/vi/<VIDEO ID>/default.jpg
// 320   | 180    | https://i.ytimg.com/vi/<VIDEO ID>/mq1.jpg
// 320   | 180    | https://i.ytimg.com/vi/<VIDEO ID>/mq2.jpg
// 320   | 180    | https://i.ytimg.com/vi/<VIDEO ID>/mq3.jpg
// 320   | 180    | https://i.ytimg.com/vi/<VIDEO ID>/mqdefault.jpg
// 480   | 360    | https://i.ytimg.com/vi/<VIDEO ID>/0.jpg
// 480   | 360    | https://i.ytimg.com/vi/<VIDEO ID>/hq1.jpg
// 480   | 360    | https://i.ytimg.com/vi/<VIDEO ID>/hq2.jpg
// 480   | 360    | https://i.ytimg.com/vi/<VIDEO ID>/hq3.jpg
// 480   | 360    | https://i.ytimg.com/vi/<VIDEO ID>/hqdefault.jpg

// Width | Height | URL
// ------|--------|----
// 640   | 480    | https://i.ytimg.com/vi/<VIDEO ID>/sd1.jpg
// 640   | 480    | https://i.ytimg.com/vi/<VIDEO ID>/sd2.jpg
// 640   | 480    | https://i.ytimg.com/vi/<VIDEO ID>/sd3.jpg
// 640   | 480    | https://i.ytimg.com/vi/<VIDEO ID>/sddefault.jpg
// 1280  | 720    | https://i.ytimg.com/vi/<VIDEO ID>/hq720.jpg
// 1920  | 1080   | https://i.ytimg.com/vi/<VIDEO ID>/maxresdefault.jpg
