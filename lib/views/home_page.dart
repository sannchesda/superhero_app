import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superhero_app/components/custom_shimmer.dart';
import 'package:superhero_app/components/scroll_wrapper.dart';
import 'package:superhero_app/controllers/superhero_data_controller.dart';
import 'package:superhero_app/models/superhero.dart';
import 'package:superhero_app/utils/constant.dart';
import 'package:superhero_app/views/superhero_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    this.authenticate = true,
  }) : super(key: key);
  final bool authenticate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final superheroDataController = Get.put(SuperheroDataController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      superheroDataController.getAllSuperheros(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Superheros"),
      ),
      body: ScrollWrapper(
        onRefresh: onRefresh,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: GetBuilder<SuperheroDataController>(
            builder: (controller) {
              final superheros = controller.superheros;
              if (superheros == null) {
                return loadingWidget;
              }
              if (superheros.isEmpty) {
                return emptyWidget;
              }

              return listSuperheroWidget(superheros);
            },
          ),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    await superheroDataController.getAllSuperheros(isRefresh: true);
  }

  Widget get emptyWidget {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [Text("No Data")],
    );
  }

  Widget get loadingWidget {
    return Column(
      children: [
        ...List.generate(3, (index) {
          return ListTile(
            title: SizedBox(
              height: 50,
              child: ShimmerWidget(),
            ),
          );
        })
      ],
    );
  }

  Widget listSuperheroWidget(List<Superhero> superheroes) {
    return Column(
      children: [
        SizedBox(height: 8),
        ...List.generate(10, (index) {
          final superhero = superheroes[index];
          return Card(
            // color: AppColors.babyBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppStaticValue.cardBorderRadius,
              ),
            ),
            elevation: 2,
            child: InkWell(
              onTap: () {
                Get.to(() => SuperheroDetailPage(superhero: superhero));
              },
              child: ListTile(
                minLeadingWidth: 0,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                leading: SizedBox(
                  width: 48,
                  height: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppStaticValue.cardBorderRadius,
                    ),
                    child: Hero(
                      tag: superhero.images?.lg ?? UniqueKey(),
                      child: ExtendedImage.network(
                        superhero.images?.sm ?? "",
                        fit: BoxFit.cover,
                        cache: true,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  superhero.name ?? "",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }),
        SizedBox(height: 8),
      ],
    );
  }
}
