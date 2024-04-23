import 'dart:ui';
import 'package:assessment/model/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        excludeHeaderSemantics: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
          ),
          Positioned.fill(
            child: Image.network(
              'https://covers.openlibrary.org/b/id/${book.coverId}.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.network(
                    'https://covers.openlibrary.org/b/id/${book.coverId}.jpg',
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Text(
                  'Title: ${book.title}',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Author: ${book.author}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Published Year: ${book.publishedYear}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                // Add more details here as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
