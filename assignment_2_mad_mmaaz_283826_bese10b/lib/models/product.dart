class Product {
  final int id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});
  factory Product.fromJson(Map<String, dynamic> json) {
    int id = json["id"];
    String title = json["title"];
    dynamic price = json["price"];
    String description = json["description"];
    String category = json["category"];
    String image = json["image"];
    Rating rating = Rating.fromJson(json["rating"]);
    return Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
        rating: rating);
  }
}

class Rating {
  final dynamic rate;
  final dynamic count;
  Rating({required this.rate, required this.count});
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(rate: json["rate"], count: json["count"]);
  }
}
