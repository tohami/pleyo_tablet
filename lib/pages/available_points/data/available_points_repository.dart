import '../../../base/base_repositroy.dart';
import 'available_points_api_provider.dart';

abstract class IAvailablePointsRepository {}

class AvailablePointsRepository extends BaseRepository
    implements IAvailablePointsRepository {
  AvailablePointsRepository({required this.provider});
  final IAvailablePointsProvider provider;
}
