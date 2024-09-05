import 'package:gestorloja/interfaces/interfaces.dart';
import 'package:gestorloja/model/cep.model.dart';

class CepStore {
  final ICepRepository repository;
  const CepStore({
    required this.repository,
  });

  Future<List<CepModel>> getCep() async {
    final result = await repository.getCep();
    return result;
  }
}
