import 'package:bloc_course/data/models/characters.dart';
import 'package:bloc_course/data/models/qoutes.dart';
import 'package:bloc_course/data/wec_serv/characters_web_service.dart';

class CharactersRepository
{
  late final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacters() async
  {
    final characters = await charactersWebServices.getAllCharacters();
    return characters!.map((characters) => Character.fromJson(characters)).toList();
  }

  Future<List<Quote>> getCharactersQuotes(String charName) async
  {
    final quotes = await charactersWebServices.getCharactersQuotes(charName);
    return quotes!.map((charQuotes) => Quote.fromJson(charQuotes)).toList();
  }


}