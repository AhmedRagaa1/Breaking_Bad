
part of 'characters_cubit.dart';


@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState{
  final List<Character> characters;

  CharactersLoaded(this.characters);
}

class QuoteLoaded extends CharactersState{
  final List<Quote> quote;

  QuoteLoaded(this.quote);
}