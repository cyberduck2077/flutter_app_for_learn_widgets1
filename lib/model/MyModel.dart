import 'package:json_annotation/json_annotation.dart';

part 'MyModel.g.dart';

@JsonSerializable()
class MyModel {

  final int userId;
  final int id;
  final String title;
  final bool completed;

  MyModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory MyModel.fromJson(dynamic json) => _$MyModelFromJson(json);



  Map<String, dynamic> toJson() => _$MyModelToJson(this);
}
