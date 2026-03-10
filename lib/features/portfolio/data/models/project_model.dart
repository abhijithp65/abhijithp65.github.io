import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  ProjectModel({
    required super.name,
    required super.description,
    required super.githubUrl,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      githubUrl: json["html_url"] ?? "",
    );
  }
}
