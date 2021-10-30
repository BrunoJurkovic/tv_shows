import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/comment.dart';

class CommentList extends StatelessWidget {
  const CommentList({
    Key? key,
    required this.comments,
    required this.size,
  }) : super(key: key);

  final List<Comment> comments;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.1,
                      height: size.height * 0.05,
                      child: Image.asset(
                        'assets/images/user.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.025,
                    ),
                    Column(
                      children: [
                        Text(
                          comments[i].email,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Text(
                          comments[i].text,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.75),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
