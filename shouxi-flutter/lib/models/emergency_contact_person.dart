class EmergencyContactPerson {
  int id;
  String userId;
  String contactPersonName;
  String contactPersonEmail;
  String createdAt;

  EmergencyContactPerson({
    required this.id,
    required this.userId,
    required this.contactPersonName,
    required this.contactPersonEmail,
    required this.createdAt,
  });

  factory EmergencyContactPerson.fromJson(Map<String, dynamic> json) => EmergencyContactPerson(
    id: json['id'],
    userId: json['user_id'],
    contactPersonName: json['contact_person_name'],
    contactPersonEmail: json['contact_person_email'],
    createdAt: json['created_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'contact_person_name': contactPersonName,
    'contact_person_email': contactPersonEmail,
    'created_at': createdAt,
  };
}
