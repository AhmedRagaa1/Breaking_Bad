import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_course/business_logic/cubit/characters_cubit.dart';
import 'package:bloc_course/constants/my_colors.dart';
import 'package:bloc_course/data/models/characters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({Key? key,required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.name);
    return Scaffold(
      backgroundColor: ColorsManager.myGrey,
      body: CustomScrollView(
        slivers:
        [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        characterInfo('Job : ' , character.jobs.join(' / ')),
                        buildDivider(290),
                        characterInfo('Appeared in : ' , character.category),
                        buildDivider(220),
                        characterInfo('Seasons : ' , character.NumSeasons.join(' / ')),
                        buildDivider(250),
                        characterInfo('Status : ' , character.DeadOrAlive),
                        buildDivider(260),

                        character.NumBetterCallSaulSeasons.isEmpty ? Container() :
                        characterInfo('Better Call saul Seasons : ' , character.NumBetterCallSaulSeasons.join(' / ')),
                        character.NumBetterCallSaulSeasons.isEmpty ? Container() :
                        buildDivider(120),
                        characterInfo('Actor/Actress : ' , character.name),
                        buildDivider(205),
                        SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<CharactersCubit , CharactersState>(
                            builder: (context, state)
                            {
                              return checkQuotesAreaLoadede(state);
                            } ,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 500,)
                ],
              ),
          ),

        ],
      ),
    );
  }

  Widget buildSliverAppBar()
  {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: ColorsManager.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickname,
          style: TextStyle(
            color: ColorsManager.myWhite,
          ),
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title , String value)
  {
    return RichText(
      maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          children:
          [
            TextSpan(
              text: title,
              style: TextStyle(
                color: ColorsManager.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: ColorsManager.myWhite,
                fontSize: 16,
              ),
            ),
          ],
        )
    );
  }

  Widget buildDivider(double endIndent)
  {
    return Divider(
      color: ColorsManager.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkQuotesAreaLoadede(CharactersState state)
  {
    if(state is QuoteLoaded)
    {
      return displayRandomQuoteOrEmptySpace(state);
    }else
      {
        return Center(
          child: CircularProgressIndicator(
            color: ColorsManager.myYellow,
          ),
        );
      }
  }

  Widget displayRandomQuoteOrEmptySpace(state)
  {
    var quotes = (state).quote;
    if(quotes.length != 0)
    {
      int randomQuoteIndex = Random().nextInt(quotes.length-1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: ColorsManager.myWhite,
            shadows:
            [
              Shadow(
                blurRadius: 7,
                color: ColorsManager.myYellow,
                offset: Offset(0,0),
              ),
            ]
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: 
            [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),

        ),
      );
    }else
      {
        return Container();
      }

  }
}
