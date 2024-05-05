enum Gender { male, female }

class Instructor {
    final String id;
    final String name;
    final String lastName;
    final DateTime birthDate;
    final String email;
    final Gender gender;

    Instructor({
        required this.id,
        required this.name,
        required this.lastName,
        required this.birthDate,
        required this.email,
        required this.gender,
    });
}