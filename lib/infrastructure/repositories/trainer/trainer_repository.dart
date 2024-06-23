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
          image: data['image'],
          followers: data['followers'],
          userFollow: data['userFollow'],
          location: data['location'],
        );
      },
    );
    return result;
  }

  @override
  Future<Result<List<Trainer>>> getTrainers(GetTrainersDto dto) async {
    var queryParameters = {
      'page': dto.page.toString(),
      'perPage': '15',
      if (dto.filter != null) 'filter': dto.filter.toString(),
    };

    var queryString = Uri(queryParameters: queryParameters).query;

    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'trainer/many?$queryString',
      httpMethod: 'GET',
      mapperCallBack: (data) {
        List<Trainer> trainers = [];
        for (var trainer in data) {
          trainers.add(Trainer(
            id: trainer['id'],
            name: trainer['name'],
            image: trainer['image'],
            followers: trainer['followers'],
            userFollow: trainer['userFollow'],
            location: trainer['location'],
          ));
        }
        return trainers;
      },
    );
    return result;
  }
  
  @override
  Future<Result<void>> followTrainer(String id) async {
    final result = await _httpConnectionManager.makeRequest(
      urlPath: 'trainer/toggle/follow/$id',
      httpMethod: 'POST',
      mapperCallBack: (_) => {}
    );
    return result;
  }
}
