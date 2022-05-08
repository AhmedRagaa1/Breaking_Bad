import 'package:bloc_course/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_course/constants/string.dart';
import 'package:bloc_course/data/models/characters.dart';
import 'package:bloc_course/data/repostory/characters_repostory.dart';
import 'package:bloc_course/data/wec_serv/characters_web_service.dart';
import 'package:bloc_course/presentation/screens/Characters_screen.dart';
import 'package:bloc_course/presentation/screens/characters_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }


  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case characterScreen:
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (BuildContext context) =>
                  CharactersCubit(charactersRepository),
              child: CharacterScreen(),
            ));

      case charactersDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(
              create: (context) => CharactersCubit(charactersRepository),
              child: CharactersDetailsScreen(character: character,),
            ));
    }
    ;
  }
}