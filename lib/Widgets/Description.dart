import 'package:bookreaderapp/Widgets/TitleBold500.dart';
import 'package:flutter/material.dart';

import '../Utils/Constants.dart';

class Description extends StatelessWidget {
  final String? description, count;
  const Description({Key? key, this.description, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: [
            const TextSpan(
                text: "Page Count : ", style: TextStyle(color: greyColor)),
            TextSpan(text: count, style: const TextStyle(color: blackColor))
          ])),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TitleBold500(
              title: description ?? "",
              maxLines: 80,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
