class LibroDetalleModel {
    String? status;
    String? id;
    String? title;
    String? subtitle;
    String? description;
    String? authors;
    String? publisher;
    String? pages;
    String? year;
    String? image;
    String? url;
    String? download;

    LibroDetalleModel({
        this.status,
        this.id,
        this.title,
        this.subtitle,
        this.description,
        this.authors,
        this.publisher,
        this.pages,
        this.year,
        this.image,
        this.url,
        this.download,
    });

    factory LibroDetalleModel.fromMap(Map<String,dynamic> map){
    return LibroDetalleModel(
      status: map['status'],
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      description: map['description'],
      authors: map['authors'],
      publisher: map['publisher'],
      pages: map['pages'],
      year: map['year'],
      image: map['image'],
      url: map['url'],
      download: map['download'],
    );
  }
}

