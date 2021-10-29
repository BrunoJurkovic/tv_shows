import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tv_shows/business_logic/viewmodels/episode_viewmodel.dart';
import 'package:tv_shows/services/service_locator.dart';

class AddEpisodePage extends StatelessWidget {
  AddEpisodePage({Key? key}) : super(key: key);

  final _key = GlobalKey<FormBuilderState>();
  final episodeViewModel = serviceLocator<EpisodeViewModel>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          'Add episode',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: size.width * 0.25,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Add',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          AddImageButton(onTap: () async {
            final mediaId = await episodeViewModel.uploadImage();
            print(mediaId);
          }),
          SizedBox(
            height: size.height * 0.75,
            child: FormBuilder(
              key: _key,
              child: Column(
                children: const [
                  EpisodeDetailInput(id: 'title', title: 'Title'),
                  EpisodeDetailInput(id: 'episode', title: 'Episode'),
                  EpisodeDetailInput(id: 'season', title: 'Season'),
                  EpisodeDetailInput(id: 'description', title: 'Description'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EpisodeDetailInput extends StatelessWidget {
  const EpisodeDetailInput({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String id;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: FormBuilderTextField(
        name: id,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(context),
          FormBuilderValidators.minLength(context, 2),
          FormBuilderValidators.maxLength(context, 20),
        ]),
        decoration: InputDecoration(
          label: Text(title),
          hintText: title,
        ),
      ),
    );
  }
}

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.camera_alt,
                color: Theme.of(context).colorScheme.secondary,
                size: 36,
              ),
              Text(
                'Upload photo',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
