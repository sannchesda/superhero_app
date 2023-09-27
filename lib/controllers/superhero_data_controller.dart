import 'package:get/get.dart';
import 'package:superhero_app/models/superhero.dart';
import 'package:superhero_app/service/superhero_data_service.dart';

class SuperheroDataController extends GetxController {
  List<Superhero>? superheros;

  Future<void> getAllSuperheros({bool isRefresh = false}) async {
    if (isRefresh) {
      superheros = null;
      update();
    }
    final superheroDataService = SuperheroDataService();

    final result = await superheroDataService.getAllSuperhero() ?? [];

    superheros ??= [];
    superheros?.addAll(result);
    update();
  }


}
