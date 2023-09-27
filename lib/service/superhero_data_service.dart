import 'package:http/http.dart' as http;
import 'package:superhero_app/models/superhero.dart';
import 'package:superhero_app/network/base_api_call.dart';
import 'package:superhero_app/utils/api_route.dart';

class SuperheroDataService {
  Future<List<Superhero>?> getAllSuperhero() async {
    const url = ApiRoute.getAll;

    final response = await callingApiMethod(
      url: url,
      method: Method.GET,
    );

    if (response is http.Response) {
      return superheroFromJson(response.body);
    }
    return null;
  }
}
