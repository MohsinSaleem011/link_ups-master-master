// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdModel _$AdModelFromJson(Map<String, dynamic> json) => AdModel(
      createdAt: json['createdAt'] as int,
      image: json['image'] as String?,
      country: json['country'] as String?,
      endDate: json['endDate'] as int,
      www: json['www'] as String,
      name: json['name'] as String,
      video: json['video'] as String?,
      startDate: json['startDate'] as int,
      updatedAt: json['updatedAt'] as int,
      status: json['status'] as int,
    );

Map<String, dynamic> _$AdModelToJson(AdModel instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'image': instance.image,
      'country': instance.country,
      'endDate': instance.endDate,
      'www': instance.www,
      'name': instance.name,
      'video': instance.video,
      'startDate': instance.startDate,
      'updatedAt': instance.updatedAt,
      'status': instance.status,
    };
