import 'package:gymnastic_center/application/models/category.dart';

class CategoryMapper {
   static Category fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        icon: json["icon"],
    );

    static Map<String, dynamic> toJson(Category category) => {
        "id": category.id,
        "name": category.name,
        "icon": category.icon,
    };

    static List<Category> fromJsonToList(dynamic jsonList) {
      return jsonList.map<Category>((json) => fromJson(json)).toList();
  }
}
