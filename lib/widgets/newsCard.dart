// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flashnewsapp/constants/sizeConstants.dart';
import 'package:flashnewsapp/constants/uiConstants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final String imaUrl, title, desc, content, posturl;
  const NewsCard({
    Key? key,
    required this.posturl,
    required this.imaUrl,
    required this.title,
    required this.desc,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Sizes.dimen_4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(Sizes.dimen_10),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(
          Sizes.dimen_16, 0, Sizes.dimen_16, Sizes.dimen_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.dimen_10),
              topRight: Radius.circular(Sizes.dimen_10),
            ),
            child: Image.network(
              imaUrl,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: Icon(Icons.broken_image_rounded),
                  ),
                );
              },
            ),
          ),
          vertical15,
          Padding(
            padding: const EdgeInsets.all(Sizes.dimen_16),
            child: Text(
              title,
              maxLines: 2,
              style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            desc,
            maxLines: 2,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          )
        ],
      ),
    );
  }
}
