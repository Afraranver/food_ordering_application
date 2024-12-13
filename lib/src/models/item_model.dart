

class Item {
  String id;
  String menuItemId;
  String storeId;
  String title;
  String description;
  String imageUrl;
  PriceInfo priceInfo;
  QuantityInfo quantityInfo;
  SuspensionRules suspensionRules;
  ModifierGroupRules modifierGroupRules;
  RewardGroupRules rewardGroupRules;
  TaxInfo taxInfo;
  List<String> categoryIds;
  MetaData metaData;
  int totalReviews; // Add TotalReviews field

  Item({
    required this.id,
    required this.menuItemId,
    required this.storeId,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.priceInfo,
    required this.quantityInfo,
    required this.suspensionRules,
    required this.modifierGroupRules,
    required this.rewardGroupRules,
    required this.taxInfo,
    required this.categoryIds,
    required this.metaData,
    this.totalReviews = 0, // Default value set to 0
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['ID'],
      menuItemId: json['MenuItemID'],
      storeId: json['StoreID'],
      title: json['Title']['en'],
      description: json['Description']['en'],
      imageUrl: json['ImageURL'],
      priceInfo: PriceInfo.fromJson(json['PriceInfo']),
      quantityInfo: QuantityInfo.fromJson(json['QuantityInfo']),
      suspensionRules: SuspensionRules.fromJson(json['SuspensionRules']),
      modifierGroupRules: ModifierGroupRules.fromJson(json['ModifierGroupRules']),
      rewardGroupRules: RewardGroupRules.fromJson(json['RewardGroupRules']),
      taxInfo: TaxInfo.fromJson(json['TaxInfo']),
      categoryIds: json['CategoryIDs'] != null
          ? List<String>.from(json['CategoryIDs'])
          : [],
      metaData: MetaData.fromJson(json['MetaData']),
      totalReviews: json['TotalReviews'] ?? 0, // Handle missing field with default value
    );
  }
}

class PriceInfo {
  Price price;
  int corePrice;
  int containerDeposit;

  PriceInfo({
    required this.price,
    required this.corePrice,
    required this.containerDeposit,
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) {
    return PriceInfo(
      price: Price.fromJson(json['Price']),
      corePrice: json['CorePrice'],
      containerDeposit: json['ContainerDeposit'],
    );
  }

  toStringAsFixed(int i) {}
}

class Price {
  int deliveryPrice;
  int pickupPrice;
  int tablePrice;

  Price({
    required this.deliveryPrice,
    required this.pickupPrice,
    required this.tablePrice,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      deliveryPrice: json['DeliveryPrice'],
      pickupPrice: json['PickupPrice'],
      tablePrice: json['TablePrice'],
    );
  }
}

class QuantityInfo {
  Quantity quantity;

  QuantityInfo({
    required this.quantity,
  });

  factory QuantityInfo.fromJson(Map<String, dynamic> json) {
    return QuantityInfo(
      quantity: Quantity.fromJson(json['Quantity']),
    );
  }
}

class Quantity {
  int minPermitted;
  int maxPermitted;

  Quantity({
    required this.minPermitted,
    required this.maxPermitted,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      minPermitted: json['MinPermitted'],
      maxPermitted: json['MaxPermitted'],
    );
  }
}

class SuspensionRules {
  Suspension suspension;

  SuspensionRules({
    required this.suspension,
  });

  factory SuspensionRules.fromJson(Map<String, dynamic> json) {
    return SuspensionRules(
      suspension: Suspension.fromJson(json['Suspension']),
    );
  }
}

class Suspension {
  bool isSuspended;
  String reason;

  Suspension({
    required this.isSuspended,
    required this.reason,
  });

  factory Suspension.fromJson(Map<String, dynamic> json) {
    return Suspension(
      isSuspended: json['IsSuspended'],
      reason: json['Reason'],
    );
  }
}

class ModifierGroupRules {
  List<String>? ids;

  ModifierGroupRules({
    this.ids,
  });

  factory ModifierGroupRules.fromJson(Map<String, dynamic> json) {
    return ModifierGroupRules(
      ids: json['IDs'] != null ? List<String>.from(json['IDs']) : null,
    );
  }

  // Handle null case for isNotEmpty
  bool get isNotEmpty => ids != null && ids!.isNotEmpty;
}

class RewardGroupRules {
  Reward reward;

  RewardGroupRules({
    required this.reward,
  });

  factory RewardGroupRules.fromJson(Map<String, dynamic> json) {
    return RewardGroupRules(
      reward: Reward.fromJson(json['Reward']),
    );
  }
}

class Reward {
  String type;
  int defaultValue;
  int multiplierValue;
  int customValue;
  bool isMultiplierRequired;

  Reward({
    required this.type,
    required this.defaultValue,
    required this.multiplierValue,
    required this.customValue,
    required this.isMultiplierRequired,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      type: json['Type'],
      defaultValue: json['DefaultValue'],
      multiplierValue: json['MultiplierValue'],
      customValue: json['CustomValue'],
      isMultiplierRequired: json['IsMutiplierRequired'],
    );
  }
}

class TaxInfo {
  int taxRate;
  int vatRateInPercentage;

  TaxInfo({
    required this.taxRate,
    required this.vatRateInPercentage,
  });

  factory TaxInfo.fromJson(Map<String, dynamic> json) {
    return TaxInfo(
      taxRate: json['Taxrate'],
      vatRateInPercentage: json['VATRateInPercentage'],
    );
  }
}

class NutrientData {
  // Nutrient fields here...
}

class DishInfo {
  // Dish-related fields...
}

class VisibilityInfo {
  // Visibility fields...
}

class ProductInfo {
  // Product fields...
}

class BeverageInfo {
  // Beverage-related fields...
}

class MetaData {
  String productId;
  String productName;
  String unitChartId;
  String unitChartName;

  MetaData({
    required this.productId,
    required this.productName,
    required this.unitChartId,
    required this.unitChartName,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      productId: json['ProductID'],
      productName: json['ProductName'],
      unitChartId: json['UnitChartID'],
      unitChartName: json['UnitChartName'],
    );
  }
}