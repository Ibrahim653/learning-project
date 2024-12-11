import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_details_model.g.dart';

@JsonSerializable()
class ProductDetailsModel {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final List<String> images;
  final String thumbnail;

  ProductDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.images,
    required this.thumbnail,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);
}
