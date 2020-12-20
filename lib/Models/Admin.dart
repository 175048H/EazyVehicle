class Orders {
  int id;
  String orderNo;
  int vehicle;
  int goodsType;
  String pickupAddress;
  String dropAddress;
  String dateTime;
  int estimatedWeight;
  int totalPrice;
  int userId;
  String status;

  Orders(
      {this.id,
      this.orderNo,
      this.vehicle,
      this.goodsType,
      this.pickupAddress,
      this.dropAddress,
      this.dateTime,
      this.estimatedWeight,
      this.totalPrice,
      this.status,
      this.userId});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['orderNo'] = orderNo;
    map['vehicle'] = vehicle;
    map['goodsType'] = goodsType;
    map['pickupAddress'] = pickupAddress;
    map['dropAddress'] = dropAddress;
    map['dateTime'] = dateTime;
    map['estimatedWeight'] = estimatedWeight;
    map['totalPrice'] = totalPrice;
    map['status'] = status;
    map['userId'] = userId;

    return map;
  }

  Orders.fromjson(dynamic o) {
    this.id = o['id'];
    this.orderNo = o['orderNo'];
    this.vehicle = o['vehicle'];
    this.goodsType = o['goodsType'];
    this.pickupAddress = o['pickupAddress'];
    this.dropAddress = o['dropAddress'];
    this.dateTime = o['dateTime'];
    this.estimatedWeight = o['estimatedWeight'];
    this.totalPrice = o['totalPrice'];
    this.status = o['status'];
    this.userId = o['userId'];
  }
}

class OrdersDto {
  int id;
  String orderNo;
  String vehicleName;
  int vehicle;
  String goodsTypeName;
  String pickupAddress;
  String dropAddress;
  // DateTime dateTime;
  int estimatedWeight;
  int totalPrice;
  String userName;
  int userId;
  String status;
  String email;

  OrdersDto(
      {this.id,
      this.orderNo,
      this.vehicleName,
      this.vehicle,
      this.goodsTypeName,
      this.pickupAddress,
      this.dropAddress,
      // this.dateTime,
      this.estimatedWeight,
      this.totalPrice,
      this.status,
      this.userId,
      this.userName,
      this.email});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['orderNo'] = orderNo;
    map['vehicleName'] = vehicleName;
    map['vehicle'] = vehicle;
    map['goodsTypeName'] = goodsTypeName;
    map['pickupAddress'] = pickupAddress;
    map['dropAddress'] = dropAddress;
    // map['dateTime'] = dateTime;
    map['estimatedWeight'] = estimatedWeight;
    map['totalPrice'] = totalPrice;
    map['status'] = status;
    map['userId'] = userId;
    map['userName'] = userName;
    map['email'] = email;

    return map;
  }

  OrdersDto.fromjson(dynamic o) {
    this.id = o['id'];
    this.orderNo = o['orderNo'];
    this.vehicle = o['vehicle'];
    this.vehicleName = o['vehicleName'];
    this.goodsTypeName = o['goodsTypeName'];
    this.pickupAddress = o['pickupAddress'];
    this.dropAddress = o['dropAddress'];
    // this.dateTime = o['dateTime'];
    this.estimatedWeight = o['estimatedWeight'];
    this.totalPrice = o['totalPrice'];
    this.status = o['status'];
    this.userId = o['userId'];
    this.userName = o['userName'];
    this.email = o['email'];
  }
}

class Vehicles {
  int id;
  String vehicleName;
  int basePrice;
  String vehicleNo;

  Vehicles({
    this.id,
    this.vehicleName,
    this.basePrice,
    this.vehicleNo,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['vehicleName'] = vehicleName;
    map['basePrice'] = basePrice;
    map['vehicleNo'] = vehicleNo;

    return map;
  }

  Vehicles.fromjson(dynamic o) {
    this.id = o['id'];
    this.vehicleName = o['vehicleName'];
    this.basePrice = o['basePrice'];
    this.vehicleNo = o['vehicleNo'];
  }
}

class Goods {
  int id;
  String goodName;

  Goods({
    this.id,
    this.goodName,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['goodName'] = goodName;

    return map;
  }

  Goods.fromjson(dynamic o) {
    this.id = o['id'];
    this.goodName = o['goodName'];
  }
}
