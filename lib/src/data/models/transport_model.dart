import 'package:json_annotation/json_annotation.dart';

part 'transport_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Transport {
  @JsonKey(name: 'route_title')
  String routeTitle;
  List<TransportVehicles> vehicles;

  Transport({this.routeTitle, this.vehicles});

  factory Transport.fromJson(Map<String, dynamic> json) =>
      _$TransportFromJson(json);

  Map<String, dynamic> toJson() => _$TransportToJson(this);
}

@JsonSerializable()
class TransportVehicles {
  String vehicleNo;
  String assigned;
  String id;

  TransportVehicles({this.id, this.vehicleNo, this.assigned});

  factory TransportVehicles.fromJson(Map<String, dynamic> json) =>
      _$TransportVehiclesFromJson(json);

  Map<String, dynamic> toJson() => _$TransportVehiclesToJson(this);
}

@JsonSerializable()
class Vehicle {
  @JsonKey(name: 'vehicle_no')
  String vehicleNo;
  @JsonKey(name: 'vehicle_model')
  String vehicleModel;
  @JsonKey(name: 'manufacture_year')
  String manufacturerYear;
  @JsonKey(name: 'driver_name')
  String driverName;
  @JsonKey(name: 'driver_licence')
  String driverLicense;
  @JsonKey(name: 'driver_contact')
  String driverContact;

  Vehicle({
    this.vehicleNo,
    this.driverContact,
    this.driverName,
    this.driverLicense,
    this.manufacturerYear,
    this.vehicleModel,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) =>
      _$VehicleFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleToJson(this);
}
