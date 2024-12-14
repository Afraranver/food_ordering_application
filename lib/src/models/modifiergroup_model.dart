class ModifierGroup {
  final String id;
  final String modifierGroupID;
  final Title title;
  final Description description;
  final String storeID;
  final String displayType;
  final List<ModifierOption> modifierOptions;
  final QuantityConstraintsRules quantityConstraintsRules;
  final DateTime createdDate;
  final DateTime modifiedDate;
  final dynamic metaData;

  ModifierGroup({
    required this.id,
    required this.modifierGroupID,
    required this.title,
    required this.description,
    required this.storeID,
    required this.displayType,
    required this.modifierOptions,
    required this.quantityConstraintsRules,
    required this.createdDate,
    required this.modifiedDate,
    this.metaData,
  });

  factory ModifierGroup.fromJson(Map<String, dynamic> json) {
    return ModifierGroup(
      id: json['ID'],
      modifierGroupID: json['ModifierGroupID'],
      title: Title.fromJson(json['Title']),
      description: Description.fromJson(json['Description']),
      storeID: json['StoreID'],
      displayType: json['DisplayType'],
      modifierOptions: (json['ModifierOptions'] as List)
          .map((option) => ModifierOption.fromJson(option))
          .toList(),
      quantityConstraintsRules:
          QuantityConstraintsRules.fromJson(json['QuantityConstraintsRules']),
      createdDate: DateTime.parse(json['CreatedDate']),
      modifiedDate: DateTime.parse(json['ModifiedDate']),
      metaData: json['MetaData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'ModifierGroupID': modifierGroupID,
      'Title': title.toJson(),
      'Description': description.toJson(),
      'StoreID': storeID,
      'DisplayType': displayType,
      'ModifierOptions':
          modifierOptions.map((option) => option.toJson()).toList(),
      'QuantityConstraintsRules': quantityConstraintsRules.toJson(),
      'CreatedDate': createdDate.toIso8601String(),
      'ModifiedDate': modifiedDate.toIso8601String(),
      'MetaData': metaData,
    };
  }

  factory ModifierGroup.empty() {
    return ModifierGroup(
      id: '',
      modifierGroupID: '',
      title: Title.empty(), // Assuming you have an empty method for Title
      description: Description
          .empty(), // Assuming you have an empty method for Description
      storeID: '',
      displayType: '',
      modifierOptions: [],
      quantityConstraintsRules: QuantityConstraintsRules
          .empty(), // Assuming you have an empty method for QuantityConstraintsRules
      createdDate: DateTime.now(),
      modifiedDate: DateTime.now(),
      metaData: null,
    );
  }
}

class Title {
  final String en;

  Title({required this.en});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(en: json['en']);
  }

  Map<String, dynamic> toJson() {
    return {'en': en};
  }

  factory Title.empty() {
    return Title(en: '');
  }
}

class Description {
  final String en;

  Description({required this.en});

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(en: json['en']);
  }

  Map<String, dynamic> toJson() {
    return {'en': en};
  }

  factory Description.empty() {
    return Description(en: '');
  }
}

class ModifierOption {
  final String id;
  final String type;

  ModifierOption({required this.id, required this.type});

  factory ModifierOption.fromJson(Map<String, dynamic> json) {
    return ModifierOption(
      id: json['Id'],
      type: json['Type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Type': type,
    };
  }

  factory ModifierOption.empty() {
    return ModifierOption(
      id: '', // Default empty value for id
      type: '', // Default empty value for type
    );
  }
}

class QuantityConstraintsRules {
  final Quantity quantity;
  final dynamic overrides;

  QuantityConstraintsRules({required this.quantity, this.overrides});

  factory QuantityConstraintsRules.fromJson(Map<String, dynamic> json) {
    return QuantityConstraintsRules(
      quantity: Quantity.fromJson(json['Quantity']),
      overrides: json['Overrides'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Quantity': quantity.toJson(),
      'Overrides': overrides,
    };
  }

  factory QuantityConstraintsRules.empty() {
    return QuantityConstraintsRules(
      quantity: Quantity.empty(), // Using the empty constructor of Quantity
      overrides: null, // Default value for overrides is null
    );
  }
}

class Quantity {
  final int minPermitted;
  final int maxPermitted;
  final bool isMinPermittedOptional;
  final int chargeAbove;
  final int refundUnder;
  final int minPermittedUnique;
  final int maxPermittedUnique;

  Quantity({
    required this.minPermitted,
    required this.maxPermitted,
    required this.isMinPermittedOptional,
    required this.chargeAbove,
    required this.refundUnder,
    required this.minPermittedUnique,
    required this.maxPermittedUnique,
  });

  factory Quantity.fromJson(Map<String, dynamic> json) {
    return Quantity(
      minPermitted: json['MinPermitted'],
      maxPermitted: json['MaxPermitted'],
      isMinPermittedOptional: json['IsMinPermittedOptional'],
      chargeAbove: json['ChargeAbove'],
      refundUnder: json['RefundUnder'],
      minPermittedUnique: json['MinPermittedUnique'],
      maxPermittedUnique: json['MaxPermittedUnique'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MinPermitted': minPermitted,
      'MaxPermitted': maxPermitted,
      'IsMinPermittedOptional': isMinPermittedOptional,
      'ChargeAbove': chargeAbove,
      'RefundUnder': refundUnder,
      'MinPermittedUnique': minPermittedUnique,
      'MaxPermittedUnique': maxPermittedUnique,
    };
  }

  factory Quantity.empty() {
    return Quantity(
      minPermitted: 0,
      maxPermitted: 0,
      isMinPermittedOptional: false,
      chargeAbove: 0,
      refundUnder: 0,
      minPermittedUnique: 0,
      maxPermittedUnique: 0,
    );
  }
}
