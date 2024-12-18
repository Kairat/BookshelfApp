// ignore_for_file: prefer_const_constructors

import 'package:bookshelf_app/pages/books/catalog_page.dart';
import 'package:bookshelf_app/pages/books/my_orders_page.dart';
import 'package:bookshelf_app/system/app_colors.dart';
import 'package:bookshelf_app/system/book_model.dart';
import 'package:bookshelf_app/system/book_service.dart';
import 'package:bookshelf_app/system/user_service.dart';
import 'package:bookshelf_app/widgets/booklist_element.dart';
import 'package:bookshelf_app/widgets/booklist_states/favorite_book.dart';
import 'package:bookshelf_app/widgets/booklist_states/get_book.dart';
import 'package:bookshelf_app/widgets/booklist_states/have_book.dart';
import 'package:bookshelf_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  late List<Book> favoriteBooks = []; // Инициализация пустым списком
  bool isLoading = true;

  @override
  void initState() {
    _loadFavorites();
    super.initState();
  }

  void _loadFavorites() async {
    try {
      final token = await ApiService().getToken();
      final BookService service = BookService(token: token!);

      final List<Book> fetchedBooks = await service.fetchFavorites();
      
      setState(() {
        favoriteBooks = fetchedBooks;
        print(favoriteBooks);
        isLoading = false;
      });
    } catch (e) {
      print("Ошибка загрузки данных: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _toogle(Book bookInfo) async {
    final token = await ApiService().getToken();
    final BookService service = BookService(token: token!);

    setState(() {
      bookInfo.hasFavorite = !bookInfo.hasFavorite;
    });
    
    await service.toggleFavorites(bookInfo.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          SearchWidget(
            hintText: "Поиск по книгам",
            width: 360,
            iconButton: SizedBox(),
          ),
          // MY BOOKS TEXT
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Избранное",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // SCREEN IF NO BOOKS
          if (favoriteBooks.isEmpty)
            Center(
              child: Column(
                children: [
                  SvgPicture.asset("assets/svg/book_lover.svg"),
                  Text(
                    "Здесь пока пусто!",
                    style: TextStyle(
                        color: AppColors.secondaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Выберите книги, которые хотите взять на прокат в нашем каталоге!",
                    style: TextStyle(
                        color: Color(0xFFC83EAA),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 280,
                    height: 51,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF4850E6), Color(0xFF227FF7)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CatalogPage()));
                        },
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 24.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/books.svg",
                                  color: Colors.white,
                                ),
                                Text(
                                  'Перейти в каталог',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          if (!isLoading && favoriteBooks.isNotEmpty)
            Container(
              height: 550,
              child: ListView.builder(
                itemCount: favoriteBooks.length,
                itemBuilder: (context, index) {
                  return BookListElement(
                    bookInfo: favoriteBooks[index],
                    rightWidget: GetBook(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => CatalogPage()));
                      },
                      onFavorite: () {
                        _toogle(favoriteBooks[index]);
                      },
                      bookInfo: favoriteBooks[index],
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

