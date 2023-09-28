import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:superhero_app/models/superhero.dart';
import 'package:superhero_app/utils/color.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SuperheroDetailPage extends StatefulWidget {
  const SuperheroDetailPage({
    super.key,
    required this.superhero,
  });

  final Superhero superhero;

  @override
  State<SuperheroDetailPage> createState() => _SuperheroDetailPageState();
}

class _SuperheroDetailPageState extends State<SuperheroDetailPage> {
  late Superhero superhero = widget.superhero;
  double top = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                expandedHeight: 256,
                floating: false,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    top = constraints.biggest.height;
                    return Stack(
                      children: [
                        FlexibleSpaceBar(
                          title: Text(
                            superhero.name ?? "",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          collapseMode: CollapseMode.parallax,
                          centerTitle: false,
                          titlePadding: EdgeInsetsDirectional.only(
                            start: 68,
                            bottom: 16,
                          ),
                          background: ExtendedImage.network(
                            superhero.images?.lg ?? "",
                            fit: BoxFit.cover,
                            cache: true,
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 100),
                          opacity: (top).floorToDouble() ==
                                  (MediaQuery.of(context).padding.top +
                                          kToolbarHeight)
                                      .floorToDouble()
                              ? 1.0
                              : 0.0,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              width: 48,
                              height: 48,
                              margin: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: ExtendedNetworkImageProvider(
                                    superhero.images?.sm ?? "",
                                    cache: true,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 600),
              child: Column(
                children: [
                  ListTile(),
                  SizedBox(height: 36),
                  SizedBox(height: 8),
                  powerStateWidget(),
                  appearanceWidget(),
                  biographyWidget(),
                  workWidget(),
                  connectionsWidget(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget connectionsWidget() {
    return Card(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "⛓️ Connections",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            connectionsListItem(
              title: "Group Affiliation",
              trailingText: superhero.connections?.groupAffiliation ?? "",
            ),
            connectionsListItem(
              title: "Relatives",
              trailingText: superhero.connections?.relatives ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget connectionsListItem({String title = "", String trailingText = ""}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            trailingText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget workWidget() {
    return Card(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "💼 Work",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            workListItem(
              title: "Occupation",
              trailingText: superhero.work?.occupation ?? "",
            ),
            workListItem(
              title: "Base",
              trailingText: superhero.work?.base ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget workListItem({String title = "", String trailingText = ""}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            trailingText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget biographyWidget() {
    return Card(
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                "🧑‍ Biography",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            biographyListItem(
              title: "Fullname",
              trailingText: superhero.biography?.fullName ?? "",
            ),
            biographyListItem(
              title: "Alter Egos",
              trailingText: superhero.biography?.alterEgos ?? "",
            ),
            biographyListItem(
              title: "Alias",
              trailingText: superhero.biography?.aliasesString ?? "",
            ),
            biographyListItem(
              title: "Place birth",
              trailingText: superhero.biography?.placeOfBirth ?? "",
            ),
            biographyListItem(
              title: "First Appearance",
              trailingText: superhero.biography?.firstAppearance ?? "",
            ),
            biographyListItem(
              title: "Publisher",
              trailingText: superhero.biography?.publisher ?? "",
            ),
            biographyListItem(
              title: "Alignment",
              trailingText: superhero.biography?.alignment ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget biographyListItem({String title = "", String trailingText = ""}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            trailingText,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }

  Widget appearanceWidget() {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "👁 Appearance",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            appearanceListItem(
              title: "Gender",
              trailingText: (superhero.appearance?.gender == "Female")
                  ? "Female"
                  : "Male",
            ),
            appearanceListItem(
              title: "Race",
              trailingText: superhero.appearance?.race ?? "",
            ),
            appearanceListItem(
              title: "Gender",
              trailingText: superhero.appearance?.heightString ?? "",
            ),
            appearanceListItem(
              title: "Weight",
              trailingText: superhero.appearance?.weightString ?? "",
            ),
            appearanceListItem(
              title: "Eye Color",
              trailingText: superhero.appearance?.eyeColor ?? "",
            ),
            appearanceListItem(
              title: "Hair Color",
              trailingText: superhero.appearance?.hairColor ?? "",
            ),
          ],
        ),
      ),
    );
  }

  Widget appearanceListItem({String title = "", String trailingText = ""}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            trailingText,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  Widget powerStateWidget() {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "✊ Power stats",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
            ),
            buildProgressBar(
              title: "🧠 Intelligence",
              progressValue:
                  superhero.powerstats?.intelligence?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "💪 Strength",
              progressValue: superhero.powerstats?.strength?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "💨 Speed",
              progressValue: superhero.powerstats?.speed?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "🧱 Durability",
              progressValue:
                  superhero.powerstats?.durability?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "⚡ Power",
              progressValue: superhero.powerstats?.power?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "👊 Combat",
              progressValue: superhero.powerstats?.combat?.toDouble() ?? 0.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProgressBar({
    required String title,
    required double progressValue,
  }) {
    final widgetHeight = 28.0;

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: SizedBox(
                  height: 28,
                  child: SfLinearGauge(
                    showTicks: false,
                    showLabels: false,
                    animateAxis: true,
                    axisTrackStyle: LinearAxisTrackStyle(
                      thickness: widgetHeight,
                      edgeStyle: LinearEdgeStyle.bothCurve,
                      color: AppColors.babyBlue,
                    ),
                    barPointers: <LinearBarPointer>[
                      LinearBarPointer(
                        value: progressValue,
                        thickness: widgetHeight,
                        edgeStyle: LinearEdgeStyle.bothCurve,
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 28,
                padding: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.centerLeft,
                child: Text(
                  '${progressValue.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
