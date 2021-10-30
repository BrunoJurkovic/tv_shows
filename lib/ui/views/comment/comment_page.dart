// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/models/comment.dart';
import 'package:tv_shows/business_logic/viewmodels/comment_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_app_bar.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.episodeId}) : super(key: key);

  final String episodeId;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _key = GlobalKey<FormBuilderState>();

  final commentViewModel = serviceLocator<CommentViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const EpisodePageAppBar(),
      body: FutureBuilder<List<Comment>>(
        future: commentViewModel.fetchComments(widget.episodeId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final comments = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (comments.isEmpty) const Expanded(child: SizedBox()),
              if (comments.isEmpty) EmptyComments(size: size),
              if (comments.isNotEmpty)
                Expanded(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
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
                ),
              if (comments.isEmpty) const Expanded(child: SizedBox()),
              const Align(
                alignment: Alignment.bottomCenter,
                child: Divider(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      FormBuilder(
                        key: _key,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: size.height * 0.05,
                          width: size.width * 0.65,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: FormBuilderTextField(
                            name: 'comment',
                            validator: FormBuilderValidators.required(context),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.025,
                      ),
                      IconButton(
                        onPressed: () {
                          final state = _key.currentState!..save();
                          if (state.validate()) {
                            commentViewModel.postComment(
                              state.value['comment'] as String,
                              widget.episodeId,
                            );
                          }
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class EmptyComments extends StatelessWidget {
  const EmptyComments({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: size.height * 0.15,
              height: size.height * 0.15,
              child: Image.asset(
                'assets/images/empty.png',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              width: size.height * 0.3,
              height: size.height * 0.15,
              child: const Text(
                'Sorry, we don’t have comments yet. Be first who will write a review.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
