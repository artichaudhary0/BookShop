
import 'package:assessment/model/book_model.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final Book book;
  final bool isRead;
  final VoidCallback onToggleReadStatus;

  const BookItem({
    super.key,
    required this.book,
    required this.isRead,
    required this.onToggleReadStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: SizedBox(
          height: 120,
          width: 40,
          child: Image.network(
            book.getCoverImageUrl('M'),
            fit: BoxFit.fill,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
        title: Text(book.title),
        subtitle: Text('${book.author}, ${book.publishedYear}'),
        trailing: InkWell(
          onTap: onToggleReadStatus,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: isRead ? Colors.green : Colors.transparent,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isRead ? 'Read' : 'Unread',
              style: TextStyle(color: isRead ? Colors.green : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
