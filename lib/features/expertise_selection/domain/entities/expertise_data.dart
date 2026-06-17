import '../../../../features/language_selection/domain/entities/language.dart';
import 'bible_version.dart';

class ExpertiseData {
  final List<Language> preferredLanguages;
  final List<BibleVersion> preferredVersions;
  final String education;
  final int age;

  ExpertiseData({
    required this.preferredLanguages,
    required this.preferredVersions,
    required this.education,
    required this.age,
  });
}
