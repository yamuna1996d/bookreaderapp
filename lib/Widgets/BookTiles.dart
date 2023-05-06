import 'package:bookreaderapp/Utils/Constants.dart';
import 'package:bookreaderapp/Screens/DetailScreen.dart';
import 'package:bookreaderapp/Widgets/TitleBold500.dart';
import 'package:flutter/material.dart';

import '../Models/BookModel.dart';

class BooksTile extends StatelessWidget {
  final BookDetails? books;
  BooksTile({
    required this.books,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                      books: books,
                    )));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(right: 16),
        alignment: Alignment.bottomLeft,
        child: Stack(
          children: <Widget>[
            Card(
              child: Container(
                height: 160,
                alignment: Alignment.bottomLeft,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 12),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 110,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TitleBold500(
                                title: books?.volumeInfo?.title ?? "",
                                fontSize: 15,
                                titleColor: blackColor,
                                fontWeight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              TitleBold500(
                                title: books?.volumeInfo?.publisher ?? "",
                                maxLines: 3,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: TitleBold500(
                                      title: books?.volumeInfo?.authors
                                              ?.join(",") ??
                                          "",
                                      maxLines: 3,
                                      fontSize: 10,
                                    ),
                                  ),
                                  const Spacer(),
                                  TitleBold500(
                                    title: books?.volumeInfo?.categories
                                            ?.join(",") ??
                                        "",
                                    maxLines: 3,
                                    fontSize: 10,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              TitleBold500(
                                title: books?.volumeInfo?.description ?? "",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            Container(
              height: 180,
              width: 110,
              margin: const EdgeInsets.only(
                left: 10,
                top: 6,
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      books?.volumeInfo?.imageLinks?.smallThumbnail??'',
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
