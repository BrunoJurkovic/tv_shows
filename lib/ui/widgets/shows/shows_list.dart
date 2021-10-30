import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/ui/views/show_detail/show_detail_page.dart';

class ShowsList extends StatelessWidget {
  const ShowsList({
    Key? key,
    required this.shows,
    required this.size,
  }) : super(key: key);

  final List<Show> shows;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shows.length,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute<ShowDetailPage>(
                  builder: (_) {
                    return ShowDetailPage(id: shows[i].id);
                  },
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.15,
                    width: size.width * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://api.infinum.academy/${shows[i].imageUrl}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      shows[i].title,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
