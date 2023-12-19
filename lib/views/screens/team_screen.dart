// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/team_controller.dart';
import '../../utils/marquee_widget.dart';
import '../widgets/fixtures_widget.dart';
import '../widgets/sabt.dart';
import '../widgets/squad_widget.dart';
import '../widgets/team_transfers.dart';
import '../widgets/teamstats.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen(this.arguments, {Key? key}) : super(key: key);
  final Map arguments;
  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> with TickerProviderStateMixin {
  TabController? _tabController;
  int index = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    //  print(widget.arguments);

    _tabController!.addListener(
      () {
        setState(() {
          index = _tabController!.index;
        });
        if (index == 0) {
          //
        }
        if (index == 1) {
          teamController.loadTeamSquads(widget.arguments['squad']);
        }
        if (index == 2) {
          teamController.loadTeamStats(widget.arguments['stats']);
        }
        if (index == 3) {
          teamController.loadteamTransfer(widget.arguments['transfers']);
        }
      },
    );

    teamController.loadTeamFixtures(widget.arguments['fixtures']);
  }

  TeamController teamController = Get.put(TeamController());
  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppAssets.backgroundImage),
          fit: BoxFit.cover,
        )),
        child: DefaultTabController(
          length: 5,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    elevation: 0,
                    backgroundColor: AppColors.appColor,
                    primary: true,
                    expandedHeight: AppSizes.newSize(20),
                    floating: false,
                    pinned: true,
                    title: SABT(
                      child: SizedBox(
                        height: 20,
                        child: MarqueeWidget(
                          text: widget.arguments['name'],
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          scrollAxis: Axis.horizontal,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.arguments['image'].toString(),
                            height: AppSizes.newSize(15),
                            width: AppSizes.newSize(15),
                            placeholder: (context, url) => Transform.scale(
                              scale: .25,
                              child: const CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          const SizedBox(width: 25),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.arguments['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSizes.size14,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 0.0),
                        //isScrollable: true,
                        onTap: (v) {
                          if (v == 0) {
                            //
                          }
                          if (v == 1) {
                            teamController
                                .loadTeamSquads(widget.arguments['squad']);
                          }
                          if (v == 2) {
                            teamController
                                .loadTeamStats(widget.arguments['stats']);
                          }
                          if (v == 3) {
                            teamController.loadteamTransfer(
                                widget.arguments['transfers']);
                          }
                        },
                        controller: _tabController,
                        labelColor: Theme.of(Get.context!)
                            .textSelectionTheme
                            .selectionColor,
                        unselectedLabelColor: Theme.of(Get.context!)
                            .textSelectionTheme
                            .selectionColor,
                        indicatorColor: Colors.white,
                        labelStyle: TextStyle(
                            color: Theme.of(Get.context!)
                                .textSelectionTheme
                                .selectionColor,
                            fontWeight: FontWeight.w500,
                            fontSize: AppSizes.size14),
                        indicator: UnderlineTabIndicator(
                          borderSide:
                              BorderSide(width: 4.0, color: AppColors.appColor),
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        tabs: [
                          Tab(text: 'Fixtures'.tr),
                          Tab(text: 'Squad'.tr),
                          Tab(text: 'Stats'.tr),
                          Tab(text: 'Transfers'.tr),
                        ],
                      ),
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: Container(
                  color: Colors.transparent,
                  child: Obx(
                    () => TabBarView(controller: _tabController, children: [
                      //FIXTURES////////////////////

                      if (!teamController.isLoading2.value &&
                          teamController.fixtures.value.teamFix!.isEmpty)
                        const Center(
                          child: Text(
                            'No Fixtures',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        !teamController.isLoading2.value &&
                                teamController
                                    .fixtures.value.teamFix!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  teamController.loadTeamFixtures(
                                      widget.arguments['fixtures']);
                                },
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 4, top: 4),
                                    // child: Divider(
                                    //   height: .3,
                                    //   color: !colorController.isLightTheme.value
                                    //       ? Colors.white.withOpacity(0.4)
                                    //       : Colors.black.withOpacity(0.4),
                                    // ),
                                  ),
                                  itemCount: teamController
                                      .fixtures.value.teamFix!.length,
                                  itemBuilder: (context, index) {
                                    return index == 0
                                        ? Column(
                                            children: [
                                              // const NativeAds(),
                                              const SizedBox(height: 10),
                                              FixtureWidget(teamController
                                                  .fixtures
                                                  .value
                                                  .teamFix![index]),
                                            ],
                                          )
                                        : FixtureWidget(teamController
                                            .fixtures.value.teamFix![index]);
                                  },
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                    height: AppSizes.newSize(3),
                                    width: AppSizes.newSize(3),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                              ),

                      //////SQUADS////////////////////
                      if (!teamController.isLoading3.value &&
                          teamController.squad.value.squad == null)
                        const Center(
                          child: Text(
                            'No Squad List',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        !teamController.isLoading3.value &&
                                teamController
                                    .squad.value.squad!.goalkeepers!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  teamController.loadTeamSquads(
                                      widget.arguments['squad']);
                                },
                                child: ListView(
                                  children: [
                                    Center(
                                      child: Text(
                                        "Goalkeepers",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.size14),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    goalkeeperList(teamController
                                        .squad.value.squad!.goalkeepers!),
                                    const SizedBox(height: 10),
                                    Center(
                                      child: Text(
                                        "Players",
                                        style: TextStyle(
                                            color: !colorController
                                                    .isLightTheme.value
                                                ? AppColors.white
                                                : Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.size14),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    playerList(teamController
                                        .squad.value.squad!.outfield!),
                                  ],
                                ),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                      //////STATS/////////////////////////////

                      if (!teamController.isLoading4.value &&
                          teamController.stats.value.stats == null)
                        Center(
                          child: Text(
                            'No Stats List found'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        !teamController.isLoading4.value &&
                                teamController
                                    .stats.value.stats!.topScorers!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  teamController
                                      .loadTeamStats(widget.arguments['stats']);
                                },
                                child: TeamStatWidget(
                                    teamController.stats.value.stats!))
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              )),
                      ////////TRANSFERS////////////////
                      if (!teamController.isLoading5.value &&
                          teamController.tranfers.value.transfers == null)
                        Center(
                          child: Text(
                            'No Transfers found',
                            style: TextStyle(
                              color: !colorController.isLightTheme.value
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        !teamController.isLoading5.value &&
                                teamController.tranfers.value.transfers!
                                    .playersIn!.isNotEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  teamController.loadteamTransfer(
                                      widget.arguments['transfers']);
                                },
                                child: TeamTransferWidgets(
                                    teamController.tranfers.value.transfers!),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              )),

                      // START NEWS/////////////////////////////////
                    ]),
                  ))),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(Get.context!).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
