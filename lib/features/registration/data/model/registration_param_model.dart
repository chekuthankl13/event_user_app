import 'package:event_user/features/registration/domain/entity/registration_param.dart';

class RegistrationParamModel extends RegistrationParam {
  RegistrationParamModel({
    required super.name,
    required super.email,
    required super.phone,
    required super.eventId,
  });

  factory RegistrationParamModel.fromEntity(RegistrationParam data) =>
      RegistrationParamModel(
        name: data.name,
        email: data.email,
        phone: data.phone,
        eventId: data.eventId,
      );

  Map<String, String> toJson() => {
    "name": name,
    "email": email,
    "phone": phone,
    "event_id": eventId,
  };
}
