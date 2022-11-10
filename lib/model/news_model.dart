class NewsModel {
  String title;
  String description;
  String source;
  String url;
  String image;
  String date;
  NewsModel(
      {required this.title,
      required this.description,
      required this.source,
      required this.url,
      required this.image,
      required this.date});
  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        description: json["description"],
        source: json["source"]["name"],
        url: json['url'],
        image: json["urlToImage"],
        date: json["publishedAt"],
      );
}
