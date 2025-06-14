import 'package:event_user/features/registration/domain/entity/registration_entity.dart';

class RegistrationEntityModel extends RegistrationEntity {
  RegistrationEntityModel({
    required super.eventId,
    required super.eventName,
    required super.location,
    required super.name,
    required super.description,
    required super.email,
    required super.phone,
    required super.eventDate,

  });

  factory RegistrationEntityModel.fromJson(Map<String, dynamic> json) =>
      RegistrationEntityModel(
        eventId: json['event_id'].toString(),
        eventName: json['event_name'].toString(),
        location: json['location'].toString(),
        name: json['name'].toString(),
        description: json['description'].toString(),
        email: json['email'].toString(),
        phone: json['phone'].toString(),
        eventDate: json['date'].toString()
      );
}

// {
//       "event_id": 3,
//       "event_name": "vedan effect",
//       "location": "Malappuram, townhall",
//       "description": "in association with KARUP records",
//       "name": "akshay",
//       "email": "akshay@gmail.com",
//       "phone": "9946742592"
//     }
