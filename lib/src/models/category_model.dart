

class Category {
  String id;
  String menuCategoryID;
  String menuID;
  String storeID;
  String title;
  String? subTitle;
  List<MenuEntity> menuEntities;
  DateTime createdDate;
  DateTime modifiedDate;
  String createdBy;
  String modifiedBy;

  Category({
    required this.id,
    required this.menuCategoryID,
    required this.menuID,
    required this.storeID,
    required this.title,
    this.subTitle,
    required this.menuEntities,
    required this.createdDate,
    required this.modifiedDate,
    required this.createdBy,
    required this.modifiedBy,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'],
      menuCategoryID: json['MenuCategoryID'],
      menuID: json['MenuID'],
      storeID: json['StoreID'],
      title: json['Title']['en'],
      subTitle: json['SubTitle']['en'],
      menuEntities: (json['MenuEntities'] as List<dynamic>)
          .map((entity) => MenuEntity.fromJson(entity))
          .toList(),
      createdDate: DateTime.parse(json['CreatedDate']),
      modifiedDate: DateTime.parse(json['ModifiedDate']),
      createdBy: json['CreatedBy'],
      modifiedBy: json['ModifiedBy'],
    );
  }
}

class MenuEntity {
  String id;
  String type;

  MenuEntity({
    required this.id,
    required this.type,
  });

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      id: json['ID'],
      type: json['Type'],
    );
  }
}