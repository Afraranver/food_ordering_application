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
  DishInfo dishInfo;
  NutrientData nutrientData;
  List<String> allergens;
  int totalReviews;

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
    required this.dishInfo,
    required this.nutrientData,
    required this.allergens,
    this.totalReviews = 0,
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
      modifierGroupRules:
          ModifierGroupRules.fromJson(json['ModifierGroupRules']),
      rewardGroupRules: RewardGroupRules.fromJson(json['RewardGroupRules']),
      taxInfo: TaxInfo.fromJson(json['TaxInfo']),
      categoryIds: json['CategoryIDs'] != null
          ? List<String>.from(json['CategoryIDs'])
          : [],
      metaData: MetaData.fromJson(json['MetaData']),
      dishInfo: DishInfo.fromJson(json['DishInfo']),
      nutrientData: NutrientData.fromJson(json['NutrientData']),
      allergens:
          json['Allergens'] != null ? List<String>.from(json['Allergens']) : [],
      totalReviews: json['TotalReviews'] ?? 0,
    );
  }
}

Item defaultItem = Item(
  id: '',
  menuItemId: '',
  storeId: '',
  title: '',
  description: '',
  imageUrl: '',
  priceInfo: PriceInfo.empty(),
  quantityInfo: QuantityInfo.empty(),
  suspensionRules: SuspensionRules.empty(),
  modifierGroupRules: ModifierGroupRules.empty(),
  rewardGroupRules: RewardGroupRules.empty(),
  taxInfo: TaxInfo.empty(),
  categoryIds: [],
  metaData: MetaData.empty(),
  dishInfo: DishInfo.empty(),
  nutrientData: NutrientData.empty(),
  allergens: [],
  totalReviews: 0,
);

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

  factory PriceInfo.empty() {
    return PriceInfo(price: Price.empty(), corePrice: 0, containerDeposit: 0);
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

  factory Price.empty() {
    return Price(
      deliveryPrice: 0,
      pickupPrice: 0,
      tablePrice: 0,
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

  factory QuantityInfo.empty() {
    return QuantityInfo(quantity: Quantity.empty());
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

  factory Quantity.empty() {
    return Quantity(minPermitted: 0, maxPermitted: 0);
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

  factory SuspensionRules.empty() {
    return SuspensionRules(
      suspension: Suspension.empty(),
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

  factory Suspension.empty() {
    return Suspension(
      isSuspended: false,
      reason: '',
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

  factory ModifierGroupRules.empty() {
    return ModifierGroupRules(
      ids: [], // Default to an empty list
    );
  }
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

  factory RewardGroupRules.empty() {
    return RewardGroupRules(
      reward: Reward.empty(), // Use the empty Reward object
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

  factory Reward.empty() {
    return Reward(
      type: '', // Default to an empty string
      defaultValue: 0, // Default to 0
      multiplierValue: 0, // Default to 0
      customValue: 0, // Default to 0
      isMultiplierRequired: false, // Default to false
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

  factory TaxInfo.empty() {
    return TaxInfo(
      taxRate: 0, // Default to 0
      vatRateInPercentage: 0, // Default to 0
    );
  }
}

class NutrientData {
  Calories calories;
  Kilojules kilojules;
  ServingSize servingSize;

  NutrientData({
    required this.calories,
    required this.kilojules,
    required this.servingSize,
  });

  factory NutrientData.fromJson(Map<String, dynamic> json) {
    return NutrientData(
      calories: Calories.fromJson(json['Calories']),
      kilojules: Kilojules.fromJson(json['Kilojules']),
      servingSize: ServingSize.fromJson(json['ServingSize']),
    );
  }

  // Empty constructor
  factory NutrientData.empty() {
    return NutrientData(
      calories: Calories.empty(),
      kilojules: Kilojules.empty(),
      servingSize: ServingSize.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Calories': calories.toJson(),
      'Kilojules': kilojules.toJson(),
      'ServingSize': servingSize.toJson(),
    };
  }
}

class Calories {
  EnergyInterval energyInterval;
  int displayType;

  Calories({
    required this.energyInterval,
    required this.displayType,
  });

  factory Calories.fromJson(Map<String, dynamic> json) {
    return Calories(
      energyInterval: EnergyInterval.fromJson(json['EnergyInterval']),
      displayType: json['DisplayType'],
    );
  }

  // Empty constructor
  factory Calories.empty() {
    return Calories(
      energyInterval: EnergyInterval.empty(),
      displayType: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EnergyInterval': energyInterval.toJson(),
      'DisplayType': displayType,
    };
  }
}

class Kilojules {
  EnergyInterval energyInterval;
  int displayType;

  Kilojules({
    required this.energyInterval,
    required this.displayType,
  });

  factory Kilojules.fromJson(Map<String, dynamic> json) {
    return Kilojules(
      energyInterval: EnergyInterval.fromJson(json['EnergyInterval']),
      displayType: json['DisplayType'],
    );
  }

  // Empty constructor
  factory Kilojules.empty() {
    return Kilojules(
      energyInterval: EnergyInterval.empty(),
      displayType: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EnergyInterval': energyInterval.toJson(),
      'DisplayType': displayType,
    };
  }
}

class EnergyInterval {
  int lower;
  int upper;

  EnergyInterval({
    required this.lower,
    required this.upper,
  });

  factory EnergyInterval.fromJson(Map<String, dynamic> json) {
    return EnergyInterval(
      lower: json['Lower'],
      upper: json['Upper'],
    );
  }

  // Empty constructor
  factory EnergyInterval.empty() {
    return EnergyInterval(
      lower: 0,
      upper: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Lower': lower,
      'Upper': upper,
    };
  }
}

class ServingSize {
  String measurementType;
  WeightedInterval weightedInterval;
  VolumenInterval volumenInterval;
  CountInterval countInterval;

  ServingSize({
    required this.measurementType,
    required this.weightedInterval,
    required this.volumenInterval,
    required this.countInterval,
  });

  factory ServingSize.fromJson(Map<String, dynamic> json) {
    return ServingSize(
      measurementType: json['MeasurementType'],
      weightedInterval: WeightedInterval.fromJson(json['WeightedInterval']),
      volumenInterval: VolumenInterval.fromJson(json['VolumenInterval']),
      countInterval: CountInterval.fromJson(json['CountInterval']),
    );
  }

  // Empty constructor
  factory ServingSize.empty() {
    return ServingSize(
      measurementType: '',
      weightedInterval: WeightedInterval.empty(),
      volumenInterval: VolumenInterval.empty(),
      countInterval: CountInterval.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MeasurementType': measurementType,
      'WeightedInterval': weightedInterval.toJson(),
      'VolumenInterval': volumenInterval.toJson(),
      'CountInterval': countInterval.toJson(),
    };
  }
}

class WeightedInterval {
  Interval interval;
  Weight weight;

  WeightedInterval({
    required this.interval,
    required this.weight,
  });

  factory WeightedInterval.fromJson(Map<String, dynamic> json) {
    return WeightedInterval(
      interval: Interval.fromJson(json['Interval']),
      weight: Weight.fromJson(json['Weight']),
    );
  }

  // Empty constructor
  factory WeightedInterval.empty() {
    return WeightedInterval(
      interval: Interval.empty(),
      weight: Weight.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Interval': interval.toJson(),
      'Weight': weight.toJson(),
    };
  }
}

class VolumenInterval {
  Interval interval;
  Volume volume;

  VolumenInterval({
    required this.interval,
    required this.volume,
  });

  factory VolumenInterval.fromJson(Map<String, dynamic> json) {
    return VolumenInterval(
      interval: Interval.fromJson(json['Interval']),
      volume: Volume.fromJson(json['Volume']),
    );
  }

  // Empty constructor
  factory VolumenInterval.empty() {
    return VolumenInterval(
      interval: Interval.empty(),
      volume: Volume.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Interval': interval.toJson(),
      'Volume': volume.toJson(),
    };
  }
}

class CountInterval {
  Interval interval;
  Count count;

  CountInterval({
    required this.interval,
    required this.count,
  });

  factory CountInterval.fromJson(Map<String, dynamic> json) {
    return CountInterval(
      interval: Interval.fromJson(json['Interval']),
      count: Count.fromJson(json['Count']),
    );
  }

  // Empty constructor
  factory CountInterval.empty() {
    return CountInterval(
      interval: Interval.empty(),
      count: Count.empty(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Interval': interval.toJson(),
      'Count': count.toJson(),
    };
  }
}

class Interval {
  int lower;
  int upper;

  Interval({
    required this.lower,
    required this.upper,
  });

  factory Interval.fromJson(Map<String, dynamic> json) {
    return Interval(
      lower: json['Lower'],
      upper: json['Upper'],
    );
  }

  // Empty constructor
  factory Interval.empty() {
    return Interval(
      lower: 0,
      upper: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Lower': lower,
      'Upper': upper,
    };
  }
}

class Weight {
  String unitType;

  Weight({
    required this.unitType,
  });

  factory Weight.fromJson(Map<String, dynamic> json) {
    return Weight(
      unitType: json['UnitType'],
    );
  }

  // Empty constructor
  factory Weight.empty() {
    return Weight(unitType: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'UnitType': unitType,
    };
  }
}

class Volume {
  String unitType;

  Volume({
    required this.unitType,
  });

  factory Volume.fromJson(Map<String, dynamic> json) {
    return Volume(
      unitType: json['UnitType'],
    );
  }

  // Empty constructor
  factory Volume.empty() {
    return Volume(unitType: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'UnitType': unitType,
    };
  }
}

class Count {
  String unitType;

  Count({
    required this.unitType,
  });

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      unitType: json['UnitType'],
    );
  }

  // Empty constructor
  factory Count.empty() {
    return Count(unitType: '');
  }

  Map<String, dynamic> toJson() {
    return {
      'UnitType': unitType,
    };
  }
}

class DishInfo {
  Classifications classifications;

  DishInfo({
    required this.classifications,
  });

  // Factory constructor to create DishInfo from a map (useful for JSON deserialization)
  factory DishInfo.fromJson(Map<String, dynamic> json) {
    return DishInfo(
      classifications: Classifications.fromJson(json['Classifications']),
    );
  }

  // Method to get only the Ingredients from the DishInfo object
  List<String> getIngredients() {
    return classifications.ingredients;
  }

  factory DishInfo.empty() {
    return DishInfo(
      classifications: Classifications.empty(), // Use the empty Classifications object
    );
  }
}

class Classifications {
  bool canServeAlone;
  bool isVegetarian;
  int alcoholicItem;
  List<String> dietaryLabelInfo;
  String instructionsForUse;
  List<String> ingredients;
  List<String> additives;
  String preparationType;
  FoolBusinessOperator foolBusinessOperator;
  bool isHighFatSaltSugar;
  bool isHalal;
  int spiceLevel;

  Classifications({
    required this.canServeAlone,
    required this.isVegetarian,
    required this.alcoholicItem,
    required this.dietaryLabelInfo,
    required this.instructionsForUse,
    required this.ingredients,
    required this.additives,
    required this.preparationType,
    required this.foolBusinessOperator,
    required this.isHighFatSaltSugar,
    required this.isHalal,
    required this.spiceLevel,
  });

  // Factory constructor to create Classifications from a map
  factory Classifications.fromJson(Map<String, dynamic> json) {
    return Classifications(
      canServeAlone: json['CanServeAlone'],
      isVegetarian: json['IsVegetarian'],
      alcoholicItem: json['AlcoholicItem'],
      dietaryLabelInfo: List<String>.from(json['DietaryLabelInfo'] ?? []),
      instructionsForUse: json['InstructionsForUse'] ?? '',
      ingredients: List<String>.from(json['Ingredients'] ?? []),
      additives: List<String>.from(json['Additives'] ?? []),
      preparationType: json['PreparationType'] ?? '',
      foolBusinessOperator:
          FoolBusinessOperator.fromJson(json['FoolBusinessOperator']),
      isHighFatSaltSugar: json['IsHighFatSaltSugar'],
      isHalal: json['IsHalal'],
      spiceLevel: json['SpiceLevel'],
    );
  }

  factory Classifications.empty() {
    return Classifications(
      canServeAlone: false,
      isVegetarian: false,
      alcoholicItem: 0,
      dietaryLabelInfo: [],
      instructionsForUse: '',
      ingredients: [],
      additives: [],
      preparationType: '',
      foolBusinessOperator: FoolBusinessOperator.empty(),
      isHighFatSaltSugar: false,
      isHalal: false,
      spiceLevel: 0,
    );
  }

  // Method to convert the Classifications object to a map
  Map<String, dynamic> toJson() {
    return {
      'CanServeAlone': canServeAlone,
      'IsVegetarian': isVegetarian,
      'AlcoholicItem': alcoholicItem,
      'DietaryLabelInfo': dietaryLabelInfo,
      'InstructionsForUse': instructionsForUse,
      'Ingredients': ingredients,
      'Additives': additives,
      'PreparationType': preparationType,
      'FoolBusinessOperator': foolBusinessOperator.toJson(),
      'IsHighFatSaltSugar': isHighFatSaltSugar,
      'IsHalal': isHalal,
      'SpiceLevel': spiceLevel,
    };
  }
}

class FoolBusinessOperator {
  String name;
  String address;

  FoolBusinessOperator({
    required this.name,
    required this.address,
  });

  // Factory constructor to create FoolBusinessOperator from a map
  factory FoolBusinessOperator.fromJson(Map<String, dynamic> json) {
    return FoolBusinessOperator(
      name: json['Name'] ?? '',
      address: json['Address'] ?? '',
    );
  }

  // Method to convert the FoolBusinessOperator object to a map
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Address': address,
    };
  }

  factory FoolBusinessOperator.empty() {
    return FoolBusinessOperator(
      name: '',
      address: '',
    );
  }
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
  String dealProductID;
  bool isDealProduct;
  String productId;
  String productName;
  String unitChartId;
  String unitChartName;

  MetaData({
    required this.dealProductID,
    required this.isDealProduct,
    required this.productId,
    required this.productName,
    required this.unitChartId,
    required this.unitChartName,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      dealProductID: json['DealProductID'] ?? '',
      isDealProduct: json['IsDealProduct'] ?? false,
      productId: json['ProductID'] ?? '',
      productName: json['ProductName'] ?? '',
      unitChartId: json['UnitChartID'] ?? '',
      unitChartName: json['UnitChartName'] ?? '',
    );
  }

  factory MetaData.empty() {
    return MetaData(
      dealProductID: '', // Default to an empty string
      isDealProduct: false, // Default to false
      productId: '', // Default to an empty string
      productName: '', // Default to an empty string
      unitChartId: '', // Default to an empty string
      unitChartName: '', // Default to an empty string
    );
  }
}
