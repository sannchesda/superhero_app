import 'dart:developer';

import 'package:get/get.dart';
import 'package:superhero_app/models/superhero.dart';
import 'package:superhero_app/service/superhero_data_service.dart';

class SuperheroDataController extends GetxController {
  List<Superhero>? superheros;
  List<Superhero>? filterSuperheros;

  void search(String keyword) {
    if (superheros == null) {
      return;
    }
    filterSuperheros = [];

    try {
      for (int i = 0; i < superheros!.length; i++) {
        String name = superheros![i].name ?? "";
        if (name.toLowerCase().contains(keyword.toLowerCase())) {
          filterSuperheros?.add(superheros![i]);
        }
      }
    } catch (e) {
      log("$e");
    }
    update();
  }

  void clearSearch() {
    filterSuperheros = null;
    update();
  }

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
