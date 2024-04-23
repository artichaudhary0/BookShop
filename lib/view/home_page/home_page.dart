import 'package:assessment/model/book_model.dart';
import 'package:assessment/repo/book_repo/book_repo.dart';
import 'package:assessment/view/detail_page/detail_page.dart';
import 'package:assessment/view/home_page/widget/book_item_tile.dart';
import 'package:assessment/view/home_page/widget/fade_animation_tile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> books = [];
  List<bool> readStatus = [];
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchBooks('the lord of the rings');
  }

  Future<void> fetchBooks(String query) async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedBooks = await BookService.fetchBooks(query);
      setState(() {
        books = fetchedBooks;
        readStatus = List.filled(books.length, false);
      });
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearch(String query) {
    if (query.isNotEmpty) {
      fetchBooks(query);
    }
  }

  void toggleReadStatus(int index) {
    setState(() {
      readStatus[index] = !readStatus[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Library'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search for books...',
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.search),
                  ),
                  onSubmitted: onSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: Lottie.asset('assets/loading_animation.json'))
                : ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      return FadeInAnimation(
                        delay: Duration(milliseconds: 200 * index),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookDetailPage(book: books[index]),
                              ),
                            );
                          },
                          child: BookItem(
                            book: books[index],
                            isRead: readStatus[index],
                            onToggleReadStatus: () => toggleReadStatus(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
