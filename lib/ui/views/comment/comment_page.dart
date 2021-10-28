import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_app_bar.dart';

class CommentPage extends StatelessWidget {
  CommentPage({Key? key, required this.episodeId}) : super(key: key);

  final String episodeId;

  final _key = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const EpisodePageAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          EmptyComments(size: size),
          const Expanded(child: SizedBox()),
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
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xFFFF758C),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
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
      child: Expanded(
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
      ),
    );
  }
}
