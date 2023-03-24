import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/UI/Component/Input.dart';
import 'package:steam_app/UI/Component/widget/Game_widget.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/view/DetailJeu.dart';
import 'package:steam_app/UI/ViewFlow/Search/bloc/SearchBloc.dart';
import 'package:steam_app/UI/ViewFlow/Search/bloc/SearchEvent.dart';
import 'package:steam_app/UI/ViewFlow/Search/bloc/SearchState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/resources/resources.dart';

class Search extends StatelessWidget {
  final controler;

  Search({super.key, required this.controler});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) =>
          SearchBloc(SearchController: controler)..add(FirstLoadEvent()),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: SvgPicture.asset(AppVactorialImages.close)),
          title: const Text("Recherche"),
        ),
        body: Container(
          child: Column(
            children: [
              SearchBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 16),
                    child: BlocBuilder<SearchBloc, SearchState>(
                        builder: (BuildContext context, SearchState state) {
                      return Text("Nombre de résultats : ${state.posts.length}",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.white,
                              fontSize: 15,
                              decoration: TextDecoration.underline));
                    }),
                  ),
                ],
              ),
              BlocBuilder<SearchBloc, SearchState>(
                  builder: (BuildContext context, SearchState state) {
                return state.isField
                    ? state.isFirstLoadRunning
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : state.posts.length == 0
                            ? Container(
                                child: const Text("Aucun resultat",
                                    style: TextStyle(color: AppColors.white)),
                              )
                            : Expanded(
                                child: Center(
                                  child: SizedBox(
                                      child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: state.posts.length,
                                          controller: state.controller,
                                          itemBuilder: (_, index) => Gamewidget(
                                              game: state.posts[index],
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailJeu(
                                                              game: state.posts[
                                                                  index]),
                                                    ));
                                              }),
                                        ),
                                      ),
                                      if (state.isLoadMoreRunning == true)
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 40),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      if (state.hasNextPage == false)
                                        Container(),
                                    ],
                                  )),
                                ),
                              )
                    : const Text("nop");
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget SearchBar() {
    return BlocBuilder<SearchBloc, SearchState>(
        builder: (BuildContext context, SearchState state) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Form(
          key: _formKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                MyTextFieldResearch(
                    controler: controler,
                    hintText: "Rechercher un jeu...",
                    obscureText: false,
                    formKey: _formKey,
                    action: () {
                      context.read<SearchBloc>().add(IsFieldNotEmpty());
                      context.read<SearchBloc>().add(FirstLoadEvent());
                    }),
                const SizedBox(height: 10),
              ]),
        ),
      );
    });
  }

/*@override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    if (widget.controler.text != null) {
      setState(() {
        _isField = true;
      });
    }
  }*/
}
