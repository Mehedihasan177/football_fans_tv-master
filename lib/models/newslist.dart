class NewsModel {
  List<News>? news;

  NewsModel({this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (news != null) {
      data['news'] = news!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class News {
  String? link;
  String? title;
  String? image;
  String? source;
  String? paragraph;
  String? time;
  String? description;

  News(
      {this.link,
      this.title,
      this.image,
      this.source,
      this.paragraph,
      this.time,
      this.description});

  News.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    title = json['title'];
    image = json['image'].toString().split(',').first;
    source = json['source'];
    paragraph = json['paragraph'];
    time = json['time'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link'] = link;
    data['title'] = title;
    data['image'] = image;
    data['source'] = source;
    data['paragraph'] = paragraph;
    data['time'] = time;
    data['description'] = description;
    return data;
  }
}
