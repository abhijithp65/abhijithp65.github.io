import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/github_datasource.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final GithubDatasource datasource;

  PortfolioRepositoryImpl(this.datasource);

  @override
  Future<List<ProjectEntity>> getProjects() {
    return datasource.fetchRepositories();
  }
}
