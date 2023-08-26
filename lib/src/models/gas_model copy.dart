// To parse this JSON data, do
//
//     final gasModel = gasModelFromJson(jsonString);

import 'dart:convert';

List<GasModel> gasModelFromJson(String str) => List<GasModel>.from(json.decode(str).map((x) => GasModel.fromJson(x)));

String gasModelToJson(List<GasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GasModel {
    String? id;
    String? estacion;
    String? marca;
    String? departamento;
    String? municipio;
    Precio? precio;
    bool? tienda;
    String? direccion;
    double? latitude;
    double? longitude;
    Location? location;
    DateTime? fechaCreacion;
    DateTime? fechaActualizacion;

    GasModel({
        this.id,
        this.estacion,
        this.marca,
        this.departamento,
        this.municipio,
        this.precio,
        this.tienda,
        this.direccion,
        this.latitude,
        this.longitude,
        this.location,
        this.fechaCreacion,
        this.fechaActualizacion,
    });

    factory GasModel.fromJson(Map<String, dynamic> json) => GasModel(
        id: json["id"],
        estacion: json["estacion"],
        marca: json["marca"],
        departamento: json["departamento"],
        municipio: json["municipio"],
        precio: json["precio"] == null ? null : Precio.fromJson(json["precio"]),
        tienda: json["tienda"],
        direccion: json["direccion"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        location: Location.fromJson(json["location"]),
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estacion": estacion,
        "marca": marcaValues.reverse[marca],
        "departamento": departamentoValues.reverse[departamento],
        "municipio": municipio,
        "precio": precio?.toJson(),
        "tienda": tienda,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "location": location!.toJson(),
        "fechaCreacion": fechaCreacion!.toIso8601String(),
        "fechaActualizacion": fechaActualizacion!.toIso8601String(),
    };
}

enum Departamento {
    AHUACHAPN,
    CHALATENANGO,
    LA_LIBERTAD,
    SANTA_ANA,
    SAN_SALVADOR,
    SONSONATE
}

final departamentoValues = EnumValues({
    "AHUACHAPÁN": Departamento.AHUACHAPN,
    "CHALATENANGO": Departamento.CHALATENANGO,
    "LA LIBERTAD": Departamento.LA_LIBERTAD,
    "SANTA ANA": Departamento.SANTA_ANA,
    "SAN SALVADOR": Departamento.SAN_SALVADOR,
    "SONSONATE": Departamento.SONSONATE
});

class Location {
    double x;
    double y;
    Type type;
    List<double> coordinates;

    Location({
        required this.x,
        required this.y,
        required this.type,
        required this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        type: typeValues.map[json["type"]]!,
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "type": typeValues.reverse[type],
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}

enum Type {
    POINT
}

final typeValues = EnumValues({
    "Point": Type.POINT
});

enum Marca {
    BANDERA_BLANCA,
    DLC,
    PUMA,
    TEXACO,
    UNO
}

final marcaValues = EnumValues({
    "BANDERA BLANCA": Marca.BANDERA_BLANCA,
    "DLC": Marca.DLC,
    "PUMA": Marca.PUMA,
    "TEXACO": Marca.TEXACO,
    "UNO": Marca.UNO
});

class Precio {
    String id;
    dynamic estacion;
    DateTime fecha;
    double? especialSc;
    double? regularSc;
    dynamic dieselSc;
    double? ionDieselSc;
    double? dieselLsSc;
    double? especialAuto;
    double? regularAuto;
    dynamic dieselAuto;
    double? ionDieselAuto;
    double? dieselLsAuto;
    String gasolineraId;
    DateTime fechaCreacion;
    DateTime fechaActualizacion;

    Precio({
        required this.id,
        this.estacion,
        required this.fecha,
        this.especialSc,
        this.regularSc,
        this.dieselSc,
        this.ionDieselSc,
        this.dieselLsSc,
        this.especialAuto,
        this.regularAuto,
        this.dieselAuto,
        this.ionDieselAuto,
        this.dieselLsAuto,
        required this.gasolineraId,
        required this.fechaCreacion,
        required this.fechaActualizacion,
    });

    factory Precio.fromJson(Map<String, dynamic> json) => Precio(
        id: json["id"],
        estacion: json["estacion"],
        fecha: DateTime.parse(json["fecha"]),
        especialSc: json["especialSc"]?.toDouble(),
        regularSc: json["regularSc"]?.toDouble(),
        dieselSc: json["dieselSc"],
        ionDieselSc: json["ionDieselSc"]?.toDouble(),
        dieselLsSc: json["dieselLSSc"]?.toDouble(),
        especialAuto: json["especialAuto"]?.toDouble(),
        regularAuto: json["regularAuto"]?.toDouble(),
        dieselAuto: json["dieselAuto"],
        ionDieselAuto: json["ionDieselAuto"]?.toDouble(),
        dieselLsAuto: json["dieselLSAuto"]?.toDouble(),
        gasolineraId: json["gasolineraId"],
        fechaCreacion: DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estacion": estacion,
        "fecha": fecha.toIso8601String(),
        "especialSc": especialSc,
        "regularSc": regularSc,
        "dieselSc": dieselSc,
        "ionDieselSc": ionDieselSc,
        "dieselLSSc": dieselLsSc,
        "especialAuto": especialAuto,
        "regularAuto": regularAuto,
        "dieselAuto": dieselAuto,
        "ionDieselAuto": ionDieselAuto,
        "dieselLSAuto": dieselLsAuto,
        "gasolineraId": gasolineraId,
        "fechaCreacion": fechaCreacion.toIso8601String(),
        "fechaActualizacion": fechaActualizacion.toIso8601String(),
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
