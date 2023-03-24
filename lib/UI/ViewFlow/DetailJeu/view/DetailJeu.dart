import 'package:flutter/material.dart';
import 'package:steam_app/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/bloc/DetailJeuBloc.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/bloc/DetailJeuEvent.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/bloc/DetailJeuState.dart';
import 'package:steam_app/domain/entities/GameDescriptionQuestion.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/resources/resources.dart';

class DetailJeu extends StatelessWidget {
  DetailJeu({super.key, required this.game});

  final gameDescriptionQuestion game;

  late final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailJeuBloc>(
      create: (_) => DetailJeuBloc(games: game)
        ..add(IsWishEvent())
        ..add(IsLikeEvent()),
      child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            actions: <Widget>[
              BlocBuilder<DetailJeuBloc, DetailJeuState>(
                builder: (BuildContext context, DetailJeuState state) {
                  return IconButton(
                      onPressed: () =>
                          context.read<DetailJeuBloc>().add(LikeEvent()),
                      icon: state.isLike
                          ? SvgPicture.asset(AppVactorialImages.likeFull)
                          : SvgPicture.asset(AppVactorialImages.like));
                },
              ),
              BlocBuilder<DetailJeuBloc, DetailJeuState>(
                builder: (BuildContext context, DetailJeuState state) {
                  return IconButton(
                      onPressed: () =>
                          context.read<DetailJeuBloc>().add(WishEvent()),
                      icon: state.isWish
                          ? SvgPicture.asset(AppVactorialImages.whishlistFull)
                          : SvgPicture.asset(AppVactorialImages.whishlist));
                },
              )
            ],
            title: const Text("Détail du jeu"),
          ),
          body: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  Container(
                    height: 430,
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                      children: [
                        imageSection(),
                        Positioned.fill(
                          top: 290,
                          child: Wrap(
                            children: [
                              titleSection(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  buttonSection(),
                  BlocBuilder<DetailJeuBloc, DetailJeuState>(
                      builder: (BuildContext context, DetailJeuState state) {
                    return state.description
                        ? descriptionSection()
                        : state.loading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Column(
                                children: [
                                  ListView.builder(
                                      itemCount: state.avisList.length,
                                      controller: _controller,
                                      shrinkWrap: true,
                                      itemBuilder: (_, index) {
                                        return Card(
                                          color: AppColors.input,
                                          margin: const EdgeInsets.only(
                                              top: 8,
                                              left: 16,
                                              right: 16,
                                              bottom: 8),
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.all(32.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: AppColors.input,
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            state
                                                                .avisList[index]
                                                                .msg,
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .clip,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .white)),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              );
                  })
                ],
              ),
            ],
          )),
    );
  }

  Widget titleSection() {
    return Card(
        color: AppColors.input,
        margin: const EdgeInsets.all(16),
        elevation: 5,
        child: BlocBuilder<DetailJeuBloc, DetailJeuState>(
          builder: (BuildContext context, DetailJeuState state) {
            return Container(
                decoration: BoxDecoration(
                  color: AppColors.input,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.dstATop),
                    image: NetworkImage(
                      state.game.imgURL,
                    ),
                  ),
                ),
                child: Row(children: [
                  Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.5, color: AppColors.placeholder)),
                        child: Image.network(
                          state.game.imgURL,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 70,
                        ),
                      )),
                  Expanded(
                    flex: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.game.name,
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: AppColors.white)),
                        Text(
                          state.game.publisher[0],
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Text("Prix : ${state.game.prix}",
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: AppColors.white))
                      ],
                    ),
                  )
                ]));
          },
        ));
  }

  Widget buttonSection() {
    return BlocBuilder<DetailJeuBloc, DetailJeuState>(
        builder: (BuildContext context, DetailJeuState state) {
      return state.description
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8))),
                        backgroundColor: AppColors.primary,
                      ),
                      child: const Text(
                        "DESCRIPTION",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<DetailJeuBloc>().add(ShowAvis()),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          backgroundColor:
                              AppColors.background.withOpacity(1.0),
                          side: const BorderSide(color: AppColors.primary)),
                      child: const Text(
                        "AVIS",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<DetailJeuBloc>().add(ShowDescription()),
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  topLeft: Radius.circular(8))),
                          backgroundColor:
                              AppColors.background.withOpacity(1.0),
                          side: const BorderSide(color: AppColors.primary)),
                      child: const Text(
                        "DESCRIPTION",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  topRight: Radius.circular(8))),
                          backgroundColor: AppColors.primary),
                      child: const Text(
                        "AVIS",
                        style: TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ));
    });
  }

  Widget descriptionSection() {
    return BlocBuilder<DetailJeuBloc, DetailJeuState>(
        builder: (BuildContext context, DetailJeuState state) {
      return Padding(
        padding: const EdgeInsets.only(
            left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
        child: Text(
          state.game.description,
          style: const TextStyle(
              fontFamily: 'Proxima Nova',
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: AppColors.white),
        ),
      );
    });
  }

  Widget avisSection() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Text('avis'),
    );
  }

  Widget imageSection() {
    return BlocBuilder<DetailJeuBloc, DetailJeuState>(
        builder: (BuildContext context, DetailJeuState state) {
      return Image.network(
        state.game.imgURL,
        width: 600,
        height: 350,
        fit: BoxFit.cover,
      );
    });
  }

  Column _buildButtonColumn(ColoredBox color, String label) {
    return Column(
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: 'Google Sans',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColors.white)),
      ],
    );
  }
}
