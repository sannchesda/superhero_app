import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
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
                          background: Hero(
                            tag: superhero.images?.lg ?? UniqueKey(),
                            child: ExtendedImage.network(
                              superhero.images?.lg ?? "",
                              fit: BoxFit.cover,
                              cache: true,
                            ),
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
                          child: Positioned(
                            bottom: 4,
                            right: 0,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                onPressed: () {},
                                splashColor: Colors.red,
                                icon: Icon(Icons.ac_unit),
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
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                ListTile(),
                SizedBox(height: 36),
                SizedBox(height: 8),
                powerStateWidget(),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
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
                "Power stats",
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
              progressValue:
                  superhero.powerstats?.intelligence?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "🧱 Durability",
              progressValue:
                  superhero.powerstats?.intelligence?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "⚡ Power",
              progressValue:
                  superhero.powerstats?.intelligence?.toDouble() ?? 0.0,
            ),
            buildProgressBar(
              title: "👊 Combat",
              progressValue:
                  superhero.powerstats?.intelligence?.toDouble() ?? 0.0,
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
                    color:
                        (progressValue <= 8.99) ? Colors.black : Colors.white,
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