// To parse this JSON data, do
//
//     final gasModel = gasModelFromJson(jsonString);

import 'dart:convert';

GasModel gasModelFromJson(String str) => GasModel.fromJson(json.decode(str));

String gasModelToJson(GasModel data) => json.encode(data.toJson());

class GasModel {
    List<GasContent>? content;
    Pageable? pageable;
    int? totalPages;
    int? totalElements;
    bool? last;
    int? size;
    int? number;
    Sort? sort;
    bool? first;
    int? numberOfElements;
    bool? empty;

    GasModel({
        this.content,
        this.pageable,
        this.totalPages,
        this.totalElements,
        this.last,
        this.size,
        this.number,
        this.sort,
        this.first,
        this.numberOfElements,
        this.empty,
    });

    factory GasModel.fromJson(Map<String, dynamic> json) => GasModel(
        content: json["content"] == null ? [] : List<GasContent>.from(json["content"]!.map((x) => GasContent.fromJson(x))),
        pageable: json["pageable"] == null ? null : Pageable.fromJson(json["pageable"]),
        totalPages: json["totalPages"],
        totalElements: json["totalElements"],
        last: json["last"],
        size: json["size"],
        number: json["number"],
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        first: json["first"],
        numberOfElements: json["numberOfElements"],
        empty: json["empty"],
    );

    Map<String, dynamic> toJson() => {
        "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
        "pageable": pageable?.toJson(),
        "totalPages": totalPages,
        "totalElements": totalElements,
        "last": last,
        "size": size,
        "number": number,
        "sort": sort?.toJson(),
        "first": first,
        "numberOfElements": numberOfElements,
        "empty": empty,
    };
}

class GasContent {
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

    GasContent({
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

    factory GasContent.fromJson(Map<String, dynamic> json) => GasContent(
        id: json["id"],
        estacion: json["estacion"],
        marca: json["marca"],
        departamento: json["departamento"]!,
        municipio: json["municipio"]!,
        precio: json["precio"] == null ? null : Precio.fromJson(json["precio"]),
        tienda: json["tienda"],
        direccion: json["direccion"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        fechaCreacion: json["fechaCreacion"] == null ? null : DateTime.parse(json["fechaCreacion"]),
        fechaActualizacion: json["fechaActualizacion"] == null ? null : DateTime.parse(json["fechaActualizacion"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "estacion": estacion,
        "marca": marca,
        "departamento": [departamento],
        "municipio": [municipio],
        "precio": precio?.toJson(),
        "tienda": tienda,
        "direccion": direccion,
        "latitude": latitude,
        "longitude": longitude,
        "location": location?.toJson(),
        "fechaCreacion": fechaCreacion?.toIso8601String(),
        "fechaActualizacion": fechaActualizacion?.toIso8601String(),
    };
}

class Location {
    double? x;
    double? y;
    String? type;
    List<double>? coordinates;

    Location({
        this.x,
        this.y,
        this.type,
        this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        x: json["x"]?.toDouble(),
        y: json["y"]?.toDouble(),
        type: json["type"]!,
        coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
        "type": type,
        "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}

class Pageable {
    Sort? sort;
    int? offset;
    int? pageNumber;
    int? pageSize;
    bool? paged;
    bool? unpaged;

    Pageable({
        this.sort,
        this.offset,
        this.pageNumber,
        this.pageSize,
        this.paged,
        this.unpaged,
    });

    factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
        sort: json["sort"] == null ? null : Sort.fromJson(json["sort"]),
        offset: json["offset"],
        pageNumber: json["pageNumber"],
        pageSize: json["pageSize"],
        paged: json["paged"],
        unpaged: json["unpaged"],
    );

    Map<String, dynamic> toJson() => {
        "sort": sort?.toJson(),
        "offset": offset,
        "pageNumber": pageNumber,
        "pageSize": pageSize,
        "paged": paged,
        "unpaged": unpaged,
    };
}

class Sort {
    bool? empty;
    bool? sorted;
    bool? unsorted;

    Sort({
        this.empty,
        this.sorted,
        this.unsorted,
    });

    factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        empty: json["empty"],
        sorted: json["sorted"],
        unsorted: json["unsorted"],
    );

    Map<String, dynamic> toJson() => {
        "empty": empty,
        "sorted": sorted,
        "unsorted": unsorted,
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