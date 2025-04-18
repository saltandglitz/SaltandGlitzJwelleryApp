class GetAddressViewModel {
  final String? message;
  final Address? address;

  GetAddressViewModel({
    this.message,
    this.address,
  });

  GetAddressViewModel.fromJson(Map<String, dynamic> json)
      : message = json['message'] as String?,
        address = (json['address'] as Map<String,dynamic>?) != null ? Address.fromJson(json['address'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'message' : message,
    'address' : address?.toJson()
  };
}

class Address {
  final String? id;
  final String? userId;
  final List<Addresses>? addresses;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  Address({
    this.id,
    this.userId,
    this.addresses,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Address.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        userId = json['userId'] as String?,
        addresses = (json['addresses'] as List?)?.map((dynamic e) => Addresses.fromJson(e as Map<String,dynamic>)).toList(),
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'userId' : userId,
    'addresses' : addresses?.map((e) => e.toJson()).toList(),
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v
  };
}

class Addresses {
  final String? street;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final String? type;
  final bool? isDefault;

  Addresses({
    this.street,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.type,
    this.isDefault,
  });

  Addresses.fromJson(Map<String, dynamic> json)
      : street = json['street'] as String?,
        city = json['city'] as String?,
        state = json['state'] as String?,
        postalCode = json['postalCode'] as String?,
        country = json['country'] as String?,
        type = json['type'] as String?,
        isDefault = json['isDefault'] as bool?;

  Map<String, dynamic> toJson() => {
    'street' : street,
    'city' : city,
    'state' : state,
    'postalCode' : postalCode,
    'country' : country,
    'type' : type,
    'isDefault' : isDefault
  };
}