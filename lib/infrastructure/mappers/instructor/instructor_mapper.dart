import 'package:gymnastic_center/domain/instructor/instructor.dart';

class InstructorMapper {
  static Instructor fromJson(Map<String, dynamic> json) => Instructor(
        id: json["id"],
        name: json["name"],
        lastName: json["lastName"],
        birthDate: DateTime.parse(json["birthDate"]),
        email: json["email"],
        gender: (json["gender"] == "male") ? Gender.male : Gender.female,
      );

  static Map<String, dynamic> toJson(Instructor instructor) => {
        "id": instructor.id,
        "name": instructor.name,
        "lastName": instructor.lastName,
        "birthDate": instructor.birthDate.toIso8601String(),
        "email": instructor.email,
        "gender": instructor.gender,
      };

  static List<Instructor> fromJsonToList(dynamic jsonList) {
    return jsonList.map<Instructor>((json) => fromJson(json)).toList();
  }
}
