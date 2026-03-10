import '../entities/project_entity.dart';

abstract class PortfolioRepository {
  Future<List<ProjectEntity>> getProjects();
}
