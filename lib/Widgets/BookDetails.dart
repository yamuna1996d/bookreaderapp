import 'package:bookreaderapp/Utils/Constants.dart';
import 'package:bookreaderapp/Widgets/TitleBold500.dart';
import 'package:flutter/material.dart';

import '../Models/BookModel.dart';

class BookDetail extends StatelessWidget {
  final BookDetails? books;
  const BookDetail({Key? key, this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleBold500(
            title: books?.volumeInfo?.categories?.join(",") ?? "",
            titleColor: blackColor,
          ),
          const SizedBox(
            height: 8,
          ),
          TitleBold500(
            title: books?.volumeInfo?.title ?? "",
            fontSize: 20,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(children: [
                const TextSpan(
                    text: "Publisher :  ", style: TextStyle(color: greyColor)),
                TextSpan(
                    text: books?.volumeInfo?.publisher,
                    style: const TextStyle(color: blackColor))
              ])),
              TitleBold500(
                title: books?.volumeInfo?.publishedDate ?? "",
                fontSize: 12,
              )
            ],
          ),
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "Authors : ", style: TextStyle(color: greyColor)),
            TextSpan(
                text: books?.volumeInfo?.authors?.join(","),
                style: const TextStyle(color: blackColor))
          ]))
        ],
      ),
    );
  }
}
