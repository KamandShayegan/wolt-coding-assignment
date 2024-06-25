import 'package:wolt/models/item_model.dart';

class SectionModel {
  final List<ItemModel> items;

  SectionModel({required this.items});

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itemList = json['items'] ?? [];
    final List<ItemModel> items =
        itemList.map((itemJson) => ItemModel.fromJson(itemJson)).toList();
    return SectionModel(items: items);
  }
}
