import 'package:flutter/material.dart';
import 'package:steam_app/resources/AppColors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steam_app/UI/Component/widget/Game_widget.dart';
import 'package:steam_app/UI/ViewFlow/DetailJeu/view/DetailJeu.dart';
import 'package:steam_app/UI/ViewFlow/FlowCubit.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/bloc/WishlistBloc.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/bloc/WishlistEvent.dart';
import 'package:steam_app/UI/ViewFlow/Wishlist/bloc/WishlistState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steam_app/resources/resources.dart';

class Wishlist extends StatelessWidget {
  Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WishlistBloc>(
      create: (_) => WishlistBloc(flowCubit: context.read<FlowCubit>())
        ..add(SetLikeEvent()),
      child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: const Text("Ma liste de souhaits"),
            leading: IconButton(
                onPressed: () => context.read<FlowCubit>().showHome(),
                icon: const Icon(Icons.arrow_back)),
          ),
          body: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (BuildContext context, WishlistState state) {
              return state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.empty
                      ? emptyContainer()
                      : Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: SizedBox(
                                  child: ListView.builder(
                                    itemCount: state.posts.length,
                                    controller: state.controller,
                                    itemBuilder: (_, index) => Gamewidget(
                                      game: state.posts[index],
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => DetailJeu(
                                              game: state.posts[index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
            },
          )),
    );
  }

  Widget emptyContainer() {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 0.0, top: 250.0, right: 0.0, bottom: 50.0),
              child: SvgPicture.asset(AppVactorialImages.emptyWhishlist),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Vous n’avez encore pas liké de contenu.',
                style: TextStyle(
                    fontFamily: 'Proxima Nova',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
            const Text(
              'Cliquez sur l’étoile pour en rajouter.',
              style: TextStyle(
                  fontFamily: 'Proxima Nova',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                  color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
