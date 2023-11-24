class LibrosModel {
  String? id;
  String? title;
  String? subtitle;
  String? authors;
  String? image;
  String? url;

  LibrosModel({
    this.id,
    this.title,
    this.subtitle,
    this.authors,
    this.image,
    this.url,
  });

  factory LibrosModel.fromMap(Map<String,dynamic> map){
    return LibrosModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      authors: map['authors'],
      image: map['image'],
      url: map['url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title':title,
      'subtitle':subtitle,
      'authors':authors,
      'image':image,
      'url':url,
    };
  }
}
