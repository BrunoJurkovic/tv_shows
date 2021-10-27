import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show_details.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/service_locator.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: FutureBuilder<ShowDetails>(
        future: _showViewModel.fetchShowDetails(widget.id),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          final showDetails = snapshot.data;
          return Center(child: Text(showDetails!.title));
        },
      ),
    );
  }
}
