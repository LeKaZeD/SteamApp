import 'package:flutter/material.dart';
import 'package:steam_app/resources/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/UI/Component/Input.dart';
import 'package:steam_app/UI/Component/widget/Game_widget.dart';
import 'package:steam_app/UI/MyApp/bloc/SessionCubit.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/view/DetailJeu.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/Home/bloc/HomeBloc.dart';
import 'package:steam_app/UI/ViewFlow/Home/bloc/HomeEvent.dart';
import 'package:steam_app/UI/ViewFlow/Home/bloc/HomeState.dart';
import 'package:steam_app/UI/ViewFlow/Search/view/Search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/resources/resources.dart';

class MyHomePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(flowCubit: context.read<FlowCubit>())
          ..add(FirstLoadEvent()),
        child: Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: const Text("Accueil"),
              backgroundColor: AppColors.background,
              automaticallyImplyLeading: false,
              actions: <Widget>[
                IconButton(
                    onPressed: () => context.read<FlowCubit>().showLikeWay(),
                    icon: SvgPicture.asset(AppVactorialImages.like)),
                IconButton(
                    onPressed: () =>
                        context.read<FlowCubit>().showWishlistWay(),
                    icon: SvgPicture.asset(AppVactorialImages.whishlist)),
                IconButton(
                    onPressed: () =>
                        BlocProvider.of<SessionsCubit>(context).signOut(),
                    icon: const Icon(Icons.logout_outlined))
              ],
              //leading: Container(),
            ),
            body: Container(
              color: AppColors.background,
              child: Column(
                children: [
                  SearchWidget(context),
                  BlocListener<HomeBloc, HomeState>(
                    listener: (context, state) {
                      state.setState(
                          () => context.read<HomeBloc>().add(LoadMoreEvent()));
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (BuildContext context, HomeState state) {
                      return Container(
                          child: state.isFirstLoadRunning
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: SizedBox(
                                              child: Column(
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    itemCount:
                                                        state.posts.length,
                                                    controller:
                                                        state.controller,
                                                    itemBuilder: (_, index) {
                                                      return index == 0
                                                          ? Column(
                                                              children: [
                                                                frontitem(),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                meilleurVente(),
                                                              ],
                                                            )
                                                          : Gamewidget(
                                                              game: state
                                                                  .posts[index],
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          DetailJeu(
                                                                              game: state.posts[index]),
                                                                    ));
                                                              });
                                                    }),
                                              ),
                                              if (state.isLoadMoreRunning ==
                                                  true)
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, bottom: 40),
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                ),
                                              if (state.hasNextPage == false)
                                                Container(),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                    }),
                  )
                ],
              ),
            )));
  }

  Widget SearchWidget(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
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
                    controler: state.search,
                    hintText: "Rechercher un jeu...",
                    obscureText: false,
                    formKey: _formKey,
                    action: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Search(controler: state.search),
                          ));
                    }),
                const SizedBox(height: 10),
              ]),
        ),
      );
    });
  }

  Widget frontitem() {
    return BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, HomeState state) {
      return SizedBox(
        height: 250,
        child: state.isFirstLoadRunning
            ? Container()
            : Card(
                color: AppColors.input,
                margin: const EdgeInsets.all(0),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.input,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5), BlendMode.dstATop),
                      image: NetworkImage(state.posts[0].imgURL),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(state.posts[0].name,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: AppColors.white, fontSize: 19)),
                              const SizedBox(
                                height: 8,
                              ),
                              Flexible(
                                child: Text(
                                  state.posts[0].description,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                      color: AppColors.white, fontSize: 12),
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailJeu(game: state.posts[0]),
                                        ));
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary),
                                  child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 5.0, horizontal: 5.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "En savoir plus",
                                            style: TextStyle(
                                                color: AppColors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5, color: AppColors.placeholder)),
                            child: Image.network(
                              state.posts[0].imgURL,
                              fit: BoxFit.cover,
                              height: 150,
                              width: 120,
                            ),
                          )),
                    ],
                  ),
                ),
              ),
      );
    });
  }

  Widget meilleurVente() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8),
          child: Text("Les meilleurs ventes",
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: 15,
                  decoration: TextDecoration.underline)),
        ),
      ],
    );
  }
}
