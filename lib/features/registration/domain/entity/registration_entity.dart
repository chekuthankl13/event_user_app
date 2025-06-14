abstract class RegistrationEntity {
  final String eventId;
  final String eventName;
  final String location;
  final String name;
  final String description;
  final String email;
  final String phone;
  final String eventDate;

  RegistrationEntity({
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.location,
    required this.name,
    required this.description,
    required this.email,
    required this.phone,
  });
}
