import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tv_shows/business_logic/models/show.dart';
import 'package:tv_shows/business_logic/viewmodels/login_viewmodel.dart';
import 'package:tv_shows/business_logic/viewmodels/shows_viemodel.dart';
import 'package:tv_shows/services/service_locator.dart';
import 'package:tv_shows/ui/views/login/login_page.dart';
import 'package:tv_shows/ui/widgets/shows/app_bar.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({Key? key}) : super(key: key);

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  final _loginViewModel = serviceLocator<LoginViewModel>();
  final _showsViewModel = serviceLocator<ShowsViewModel>();

  @override
  void initState() {
    Future.delayed(Duration.zero, _showsViewModel.fetchShows);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: ShowsAppBar(
        onTap: () async {
          await _loginViewModel.logout();
          // ignore: use_build_context_synchronously
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute<LoginPage>(
              builder: (_) {
                return const LoginPage();
              },
            ),
          );
        },
      ),
      body: FutureBuilder(
          future: _showsViewModel.fetchShows(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            final shows = snapshot.data! as List<Show>;
            return ListView.builder(
                itemCount: shows.length,
                itemBuilder: (ctx, i) {
                  return Container(
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
                  );
                });
          }),
    );
  }
}
