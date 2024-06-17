import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gymnastic_center/application/blocs/select_data_source/select_data_source_bloc.dart';

class Environment {
  static late SelectDataSourceBloc dataSourceBloc;

  static initEnvironment(SelectDataSourceBloc bloc) async {
    await dotenv.load(fileName: ".env");
    dataSourceBloc = bloc;
  }

  static String getApiUrl() {
    switch (dataSourceBloc.state.dataSourceIndex) {
      case 0:
        return dotenv.env['API_URL'] ?? 'API_URL is not configured';
      case 1:
        return dotenv.env['LAMBDA_API_URL'] ??
            'LAMBDA_API_URL is not configured';
      case 2:
        return dotenv.env['ALFA_API_URL'] ?? 'ALFA_API_URL is not configured';
      case 3:
        return dotenv.env['DELTA_API_URL'] ?? 'DELTA_API_URL is not configured';
      default:
        return 'API_URL is not configured';
    }
  }
}
