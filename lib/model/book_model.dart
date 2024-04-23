class Book {
  final String title;
  final String author;
  final String publishedYear;
  final String coverId;
  bool isRead;

  Book({
    required this.title,
    required this.author,
    required this.publishedYear,
    required this.coverId,
    this.isRead = false,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'] ?? 'Unknown Title',
      author: (json['author_name'] != null && json['author_name'].isNotEmpty)
          ? json['author_name'][0]
          : 'Unknown Author',
      publishedYear: (json['first_publish_year'] != null)
          ? json['first_publish_year'].toString()
          : 'Unknown Year',
      coverId: json['cover_i']?.toString() ?? '',
    );
  }

  String getCoverImageUrl(String size) {
    return 'https://covers.openlibrary.org/b/id/$coverId-$size.jpg';
  }
}
