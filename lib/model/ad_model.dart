import 'package:json_annotation/json_annotation.dart';
part 'ad_model.g.dart';

@JsonSerializable()
class AdModel {
  AdModel({
    required this.createdAt,
    required this.image,
    required this.country,
    required this.endDate,
    required this.www,
    required this.name,
    required this.video,
    required this.startDate,
    required this.updatedAt,
    required this.status,
  });

  int createdAt;
  String? image;
  String? country;
  int endDate;
  String www;
  String name;
  String? video;
  int startDate;
  int updatedAt;
  int status;

  factory AdModel.fromJson(Map<String, dynamic> json) =>
      _$AdModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdModelToJson(this);
}
