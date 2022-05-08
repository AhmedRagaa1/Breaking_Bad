import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_course/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_course/constants/my_colors.dart';
import 'package:bloc_course/data/models/characters.dart';
import 'package:bloc_course/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharacterScreen extends StatefulWidget {

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final searchTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.myGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsManager.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarItem(),
        leading: isSearching ? BackButton(color: ColorsManager.myGrey,) : Container(),
        actions: buildAppActions(),
      ),
      body:  OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              )
          {
            final bool connected = connectivity != ConnectivityResult.none;
            if(connected)
            {
              return buildBlocWidget();
            }else
              {
                return buildNoInternetWidget();
              }

          },
          child: Center(child: CircularProgressIndicator()),
          ),


    );
  }



  Widget buildBlocWidget()
  {
    return BlocBuilder<CharactersCubit , CharactersState>(builder: (context , state)
    {
      if(state is CharactersLoaded)
        {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();

        }else
          {
           return Center(
             child: CircularProgressIndicator(
               color: ColorsManager.myGrey,
             ),
           );
          }

    });
  }

  Widget buildLoadedListWidgets()
  {
    return SingleChildScrollView(
      child: Container(
        color: ColorsManager.myGrey,
        child: Column(
          children:
          [
             buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList()
  {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2/3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: searchTextController.text.isEmpty ?allCharacters.length : searchedForCharacters.length,
        itemBuilder: (context , index)
        {
          return CharactersItem(character: searchTextController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index]
          );
        }
    );
  }

  Widget buildSearchField()
  {
    return TextField(
      controller: searchTextController,
      cursorColor: ColorsManager.myGrey,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: ColorsManager.myGrey,
          fontSize: 18,
        )
      ),
      style: TextStyle(
        color: ColorsManager.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacter)
      {
         addSearchedForSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedForSearchedList( String searchedCharacter)
  {
     searchedForCharacters = allCharacters.where((character) =>
         character.name.toLowerCase().startsWith(searchedCharacter))
         .toList();

     setState(() {

     });
  }

  List<Widget> buildAppActions()
  {
    if(isSearching)
    {
      return [
        IconButton(
            onPressed: ()
            {
              clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: ColorsManager.myGrey,
            ))
      ];
    }else
      {
         return [IconButton(
             onPressed: startSearch,
             icon: Icon(
               Icons.search,
               color: ColorsManager.myGrey,
             )
         )
    ];
      }
  }

  void startSearch()
  {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));

    setState(() {
      isSearching = true;
    });
  }

  void stopSearching()
  {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }
  void clearSearch()
  {
    searchTextController.clear();
  }

  Widget buildAppBarItem()
  {
    return Text(
      'Characters',
      style: TextStyle(
        color: ColorsManager.myGrey,
      ),
    );
  }

  Widget buildNoInternetWidget()
  {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            SizedBox(
              height: 20,
            ),
          //   SizedBox(
          //   width: 250.0,
          //   child: TextLiquidFill(
          //     text: 'Can\'t connect...'.toUpperCase(),
          //     waveColor: ColorsManager.myYellow,
          //     boxBackgroundColor: Colors.white,
          //     textStyle: TextStyle(
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     boxHeight: 150.0,
          //   ),
          // ),
            DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
            color: ColorsManager.myYellow,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText('Can\'t connect....'),
              WavyAnimatedText('Please, Check internet'),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
            Image.asset('assets/images/12.png'),
          ],
        ),
      ),
    );
  }


}
