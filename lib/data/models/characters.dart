// ignore: non_constant_identifier_names

class Character
{
  late int charId;
  late String name;
  late String nickname;
  late String image;
  late List<dynamic> jobs;
  late String category;
  late String DeadOrAlive;
  late List<dynamic> NumSeasons;
  late String ActorName;
  late List<dynamic> NumBetterCallSaulSeasons;

  Character.fromJson(Map<String , dynamic> json)
  {
    charId = json['char_id'];
    name = json['name'];
    nickname = json['nickname'];
    image = json['img'];
    jobs = json['occupation'];
    category = json['category'];
    DeadOrAlive = json['status'];
    NumSeasons = json['appearance'];
    ActorName = json['portrayed'];
    NumBetterCallSaulSeasons = json['better_call_saul_appearance'];
  }

}