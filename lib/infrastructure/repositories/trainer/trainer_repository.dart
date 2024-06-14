import 'package:gymnastic_center/core/result.dart';
import 'package:gymnastic_center/domain/trainer/trainer.dart';
import 'package:gymnastic_center/domain/trainer/trainer_repository.dart';
import 'package:gymnastic_center/infrastructure/data-sources/http/http_manager.dart';

class TrainerRepository implements ITrainerRepository {
  final IHttpManager _httpConnectionManager;

  TrainerRepository(this._httpConnectionManager);

  @override
  Future<Result<Trainer>> getTrainerById(String id) async {
    final result = await _httpConnectionManager.makeRequest(
      httpMethod: 'GET',
      urlPath: 'trainer/one/$id',
      mapperCallBack: (data) {
        return Trainer(
          id: data['id'],
          name: data['name'],
          followers: data['followers'],
          userFollow: data['userFollow'],
          location: data['location'],
        );
      },
    );
    return result;
  }

  @override
  Future<Result<List<Trainer>>> getTrainers() {
    // TODO: implement getTrainers
    throw UnimplementedError();
  }
}
