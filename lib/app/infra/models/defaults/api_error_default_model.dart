import 'api_error_model.dart';
import 'api_response_model.dart';
import 'default_response_model.dart';

class ApiErrorDefaultModel<T> extends ApiResponseModel<T> {
  final String message;
  final DefaultResponseModel response;

  ApiErrorDefaultModel({
    required this.message,
    required this.response,
  }) : super(
          isSuccess: false,
          error: ApiErrorModel(
            title: message,
            content: response.error?.message ?? 'Erro desconhecido... ',
          ),
        );
}
