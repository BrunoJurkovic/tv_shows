import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/add_episode/add_episode_page.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_app_bar.dart';
import 'package:tv_shows/ui/widgets/show_detail/episode_view_body.dart';

class ShowDetailPage extends StatefulWidget {
  const ShowDetailPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  final _showViewModel = serviceLocator<ShowsViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const EpisodePageAppBar(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute<AddEpisodePage>(
            builder: (ctx) => AddEpisodePage(id: widget.id),
          ),
        ),
      ),
      body: FutureBuilder<ShowDetails>(
        future: _showViewModel.fetchShowDetails(widget.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final showDetails = snapshot.data!;
          return EpisodeViewBody(size: size, showDetails: showDetails);
        },
      ),
    );
  }
}
