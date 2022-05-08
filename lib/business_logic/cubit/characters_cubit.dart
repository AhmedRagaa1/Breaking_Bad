import 'package:bloc_course/data/models/qoutes.dart';
import 'package:bloc_course/data/repostory/characters_repostory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState>
{
  final CharactersRepository charactersRepository;
   List<Character> characters = [];


  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<Character> getAllCharacters()
  {
    charactersRepository.getAllCharacters().then((characters)
    {
      emit(CharactersLoaded(characters));
      this.characters = characters;

    }).catchError((error)
    {

    });
    return characters;
  }

  void getQuotes(String charName)
  {
    charactersRepository.getCharactersQuotes(charName).then((quotes)
    {
      emit(QuoteLoaded(quotes));

    }).catchError((error)
    {

    });
  }
}
