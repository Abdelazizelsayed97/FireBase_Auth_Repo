// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_network_input_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NetworkLoginInputModel _$NetworkLoginInputModelFromJson(
        Map<String, dynamic> json) =>
    NetworkLoginInputModel(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$NetworkLoginInputModelToJson(
        NetworkLoginInputModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
