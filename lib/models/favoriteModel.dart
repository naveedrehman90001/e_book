import 'package:hive/hive.dart';

part 'favoriteModel.g.dart';

@HiveType(typeId: 1)
class FavoriteModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? bookImage;
  @HiveField(2)
  String? title;
  @HiveField(3)
  String? author;
}
