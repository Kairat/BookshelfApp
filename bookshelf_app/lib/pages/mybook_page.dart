import 'package:auto_size_text/auto_size_text.dart';
import 'package:bookshelf_app/system/app_colors.dart';
import 'package:bookshelf_app/system/book.dart';
import 'package:bookshelf_app/widgets/booklist_element.dart';
import 'package:bookshelf_app/widgets/booklist_states/have_book.dart';
import 'package:bookshelf_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyBookPage extends StatefulWidget {
  const MyBookPage({super.key});

  @override
  State<MyBookPage> createState() => _MyBookPageState();
}

class _MyBookPageState extends State<MyBookPage> {
  List<Book> books = [
    Book(
        bookName: "451 Градус по фаренгейту",
        author: "Рэй Брэдбери",
        description:
            "«451 градус по Фаренгейту» — научно-фантастический роман-антиутопия Рэя Брэдбери, изданный в 1953 году. Роман описывает американское общество близкого будущего, в котором книги находятся под запретом. «Пожарные», к числу которых принадлежит и главный герой Гай Монтэг, сжигают любые найденные книги.\nВ ходе романа Монтэг разочаровывается в идеалах общества, частью которого он является, становится изгоем и присоединяется к небольшой подпольной группе маргиналов, сторонники которой заучивают тексты книг, чтобы спасти их для потомков.",
        genre: "Роман",
        term: "29.10.2024",
        imagePath: "assets/img/book.png",
        rating: 4.6,
        isAvailable: true,
        isAwaiting: false),
    Book(
        bookName: "Дюна",
        author: "Фрэнк Гербертс",
        description: "Описание",
        genre: "Роман",
        term: "01.11.2024",
        imagePath: "assets/img/book.png",
        rating: 4.6,
        isAvailable: true,
        isAwaiting: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SearchWidget(
            hintText: "Поиск по книгам",
            iconButton: IconButton(
                onPressed: () {
                  //on button press
                },
                icon: Icon(Icons.person_outline_rounded, size: 36)),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Мои книги",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          //SCREEN IF NO BOOKS
          if (books.isEmpty)
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
                          // Действие при нажатии
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

          //BOOK LIST
          if (books.isNotEmpty)
            Container(
              height: 550,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return BookListElement(
                      bookInfo: books[index],
                      rightWidget: HaveBook(date: books[index].term));
                },
              ),
            )
        ],
      ),
    );
  }
}
