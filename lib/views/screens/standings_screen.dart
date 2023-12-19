import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/standings_controller.dart';
import '../../models/standings.dart';
import '../../utils/shimmers.dart';
import '../../utils/widgets.dart';
import 'league_table_screen.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({Key? key}) : super(key: key);

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> {
  ColorController colorController = Get.put(ColorController());
  StandingsController standingsController = Get.put(StandingsController());
  TextEditingController controller = TextEditingController();
  refresh() async {
    controller.clear();
    standingsController.isLoading.value = true;
    standingsController.loadLeagues();
  }

  @override
  void initState() {
    super.initState();
    standingsController.loadLeagues();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => refresh(),
        child: SafeArea(
          child: Obx(() => Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: !standingsController.isLoading.value
                    ? (standingsController.leaguenames.value.league?.length ??
                                0) >
                            0
                        ? GlobalGridView(
                            standingsController.leaguenames.value,
                          )
                        : const SizedBox()
                    : standingsShimmer(),
              )),
        ));
  }
}

class GlobalGridView extends StatefulWidget {
  final LeagueModel value;

  const GlobalGridView(this.value, {Key? key}) : super(key: key);

  @override
  State<GlobalGridView> createState() => _GlobalGridViewState();
}

class _GlobalGridViewState extends State<GlobalGridView> {
  final Random _random = Random();
  List<List<Color>> gradientColors = [];
  List<Color> colorFirst = [
    HexColor('#0C1D63'),
    HexColor('#143CDA'),
  ];
  List<Color> colorSecond = [
    HexColor('#5F090C'),
    HexColor('#C61D22'),
  ];
  List<Color> colorThird = [
    HexColor('#012509'),
    HexColor('#015825'),
  ];
  List<Color> colorFourth = [
    HexColor('#080941'),
    HexColor('#111471'),
  ];
  List<Color> colorFifth = [
    HexColor('#420429'),
    HexColor('#721752'),
  ];
  List<Color> colorSixth = [
    HexColor('#4D0E16'),
    HexColor('#841C1B'),
  ];
  List<Color> colorSeven = [
    HexColor('#2B0439'),
    HexColor('#3C2956'),
  ];
  List<Color> colorEight = [
    HexColor('#090C41'),
    HexColor('#232C67'),
  ];
  @override
  void initState() {
    super.initState();
    gradientColors.addAll({
      colorFirst,
      colorSecond,
      colorThird,
      colorFourth,
      colorFifth,
      colorSixth,
      colorSeven,
      colorEight
    });
  }

  List<Widget> getPostion() {
    List positions = [
      Positioned(
        bottom: 10,
        left: 20,
        child: Container(
          width: 40,
          height: 3,
          color: HexColor('#143CDA'),
        ),
      ),
      Positioned(
        top: 20,
        left: 20,
        child: Container(
          width: 40,
          height: 3,
          color: HexColor('#C61D22'),
        ),
      ),
      // Positioned(
      //   bottom: 20,
      //   left: 20,
      //   child: Container(
      //     width: 40,
      //     height: 3,
      //     color: HexColor('#015825'),
      //   ),
      // ),
      // Positioned(
      //   bottom: 20,
      //   left: 20,
      //   child: Container(
      //     width: 40,
      //     height: 3,
      //     color: HexColor('#111471'),
      //   ),
      // ),
    ];
    List positions2 = [
      Positioned(
        top: 20,
        right: 20,
        child: DottedWidget(HexColor('#143CDA')),
      ),
      Positioned(
        bottom: 10,
        right: 20,
        child: DottedWidget(
          HexColor('#C61D22'),
        ),
      ),
      // Positioned(
      //   bottom: 20,
      //   left: 20,
      //   child: DottedWidget(HexColor('#015825'),),
      // ),
      // Positioned(
      //   top: 20,
      //   right: 20,
      //   child: DottedWidget(HexColor('#111471'),),
      // ),
    ];

    int index = _random.nextInt(positions.length);
    return [positions[index], positions2[index]];
  }

  @override
  Widget build(BuildContext context) {
    var size1 = MediaQuery.of(context).size;
    final double itemHeight = (size1.height - kToolbarHeight - 10) / 4;
    final double itemWidth = size1.width / 2;
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 23,
          crossAxisSpacing: 23,
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemCount: widget.value.league?.length,
        itemBuilder: (BuildContext ctx, index) {
          var data = widget.value.league![index];
          return InkWell(
            onTap: () {
              var arguments = {
                'name': data.name,
                'image': data.image,
                'schedule': data.schedule,
                'stats': data.stats,
                'teams': data.teams,
                'table': data.teams!.replaceAll("teams", "table")
              };
              dev.log(data.image ?? "");

              Get.to(() => LeagueTableScreen(arguments));
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: gradientColors[
                              _random.nextInt(gradientColors.length)],
                          stops: const [0.55, 0.55]),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          bottomLeft: Radius.circular(17),
                          bottomRight: Radius.circular(17))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [],
                    ),
                  ),
                ),
                ...getPostion(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    cachedNetworkImageMaker(data.image, 7, 7, 7, 7, 7, 7),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.name.toString().toUpperCase(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 0.2,
                        color: Colors.white,
                        fontSize: AppSizes.size12,
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DottedWidget extends StatelessWidget {
  const DottedWidget(
    this.color, {
    Key? key,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
        (index) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color.withGreen(255),
          ),
          margin: const EdgeInsets.only(right: 2),
          width: 4,
          height: 4,
        ),
      ),
    );
  }
}
