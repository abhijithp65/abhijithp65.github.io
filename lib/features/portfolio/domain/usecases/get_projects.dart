import '../entities/project_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetProjects {
  final PortfolioRepository repository;

  GetProjects(this.repository);

  Future<List<ProjectEntity>> call() {
    return repository.getProjects();
  }
}
