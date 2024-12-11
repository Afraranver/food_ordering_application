
// Root Data
class MenuResponse {
  final bool status;
  final Result result;

  MenuResponse({required this.status, required this.result});

  factory MenuResponse.fromJson(Map<String, dynamic> json) {
    return MenuResponse(
      status: json['Status'],
      result: Result.fromJson(json['Result']),
    );
  }
}

class Result {
  final List<Menu> menus;
  final List<Category> categories;
  final List<MenuItem> items;

  Result({
    required this.menus,
    required this.categories,
    required this.items,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      menus: (json['Menu'] as List).map((e) => Menu.fromJson(e)).toList(),
      categories:
          (json['Categories'] as List).map((e) => Category.fromJson(e)).toList(),
      items: (json['Items'] as List).map((e) => MenuItem.fromJson(e)).toList(),
    );
  }
}

// Menu Model
class Menu {
  final String id;
  final String menuID;
  final String verticalID;
  final String storeID;
  final Map<String, String> title;
  final Map<String, String>? subTitle;
  final Map<String, String>? description;
  final Map<String, Availability> menuAvailability;
  final List<String> menuCategoryIDs;

  Menu({
    required this.id,
    required this.menuID,
    required this.verticalID,
    required this.storeID,
    required this.title,
    this.subTitle,
    this.description,
    required this.menuAvailability,
    required this.menuCategoryIDs,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['ID'],
      menuID: json['MenuID'],
      verticalID: json['VerticalID'],
      storeID: json['StoreID'],
      title: Map<String, String>.from(json['Title']),
      subTitle: json['SubTitle'] != null
          ? Map<String, String>.from(json['SubTitle'])
          : null,
      description: json['Description'] != null
          ? Map<String, String>.from(json['Description'])
          : null,
      menuAvailability: (json['MenuAvailability'] as Map<String, dynamic>)
          .map((key, value) =>
              MapEntry(key, Availability.fromJson(value))),
      menuCategoryIDs: List<String>.from(json['MenuCategoryIDs']),
    );
  }
}

// Availability Model
class Availability {
  final String startTime;
  final String endTime;

  Availability({
    required this.startTime,
    required this.endTime,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      startTime: json['StartTime'],
      endTime: json['EndTime'],
    );
  }
}

// Category Model
class Category {
  final String id;
  final String menuCategoryID;
  final String menuID;
  final String storeID;
  final Map<String, String> title;
  final List<MenuEntity> menuEntities;

  Category({
    required this.id,
    required this.menuCategoryID,
    required this.menuID,
    required this.storeID,
    required this.title,
    required this.menuEntities,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['ID'],
      menuCategoryID: json['MenuCategoryID'],
      menuID: json['MenuID'],
      storeID: json['StoreID'],
      title: Map<String, String>.from(json['Title']),
      menuEntities: (json['MenuEntities'] as List)
          .map((e) => MenuEntity.fromJson(e))
          .toList(),
    );
  }
}

// MenuEntity Model
class MenuEntity {
  final String id;
  final String type;

  MenuEntity({required this.id, required this.type});

  factory MenuEntity.fromJson(Map<String, dynamic> json) {
    return MenuEntity(
      id: json['ID'],
      type: json['Type'],
    );
  }
}

// MenuItem Model
class MenuItem {
  final String id;
  final String menuItemID;
  final String storeID;
  final Map<String, String> title;
  final Map<String, String>? description;
  final String? imageURL;

  MenuItem({
    required this.id,
    required this.menuItemID,
    required this.storeID,
    required this.title,
    this.description,
    this.imageURL,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['ID'],
      menuItemID: json['MenuItemID'],
      storeID: json['StoreID'],
      title: Map<String, String>.from(json['Title']),
      description: json['Description'] != null
          ? Map<String, String>.from(json['Description'])
          : null,
      imageURL: json['ImageURL'],
    );
  }
}
