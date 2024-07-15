import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_list_model.g.dart';

@JsonSerializable()
class CategoryModel {
  final List<String> categories;

  CategoryModel({required this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);
}
