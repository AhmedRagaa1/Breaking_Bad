import 'package:bloc_course/constants/my_colors.dart';
import 'package:bloc_course/constants/string.dart';
import 'package:bloc_course/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharactersItem extends StatelessWidget {
  final Character character;

  const CharactersItem({Key? key , required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8 , 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: ColorsManager.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScreen, arguments: character),
        child: GridTile(
          child: Hero(
            tag: character.charId,
            child: Container(
              color: ColorsManager.myGrey,
              child: character.image.isNotEmpty ?
              FadeInImage.assetNetwork(
                width: double.infinity,
                  height: double.infinity,
                  placeholder: 'assets/images/l1.gif',
                  image: character.image,
                  fit: BoxFit.cover,
              )
                  :Image.asset('assets/images/1.webp')
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: 15,
              vertical: 10,
            ),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
                '${character.name}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: ColorsManager.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
