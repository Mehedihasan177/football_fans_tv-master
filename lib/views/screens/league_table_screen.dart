import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/views/widgets/teamstats.dart';
import 'package:get/get.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/league_controller.dart';
import '../../utils/marquee_widget.dart';
import '../widgets/league_fixtures_widget.dart';
import '../widgets/league_table_widget.dart';
import '../widgets/league_teams.dart';
import '../widgets/sabt.dart';

class LeagueTableScreen extends StatefulWidget {
  const LeagueTableScreen(this.arguments, {Key? key}) : super(key: key);
  final Map arguments;
  @override
  State<LeagueTableScreen> createState() => _LeagueTableScreenState();
}

class _LeagueTableScreenState extends State<LeagueTableScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  LeagueController leagueController = Get.put(LeagueController());
  ColorController colorController = Get.find();
  int index = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    leagueController.loadLeagueFixtures(widget.arguments['schedule']);
    //  log(widget.arguments['table']);
    _tabController!.addListener(
      () {
        setState(() {
          index = _tabController!.index;
        });
        if (index == 1) {
          leagueController.loadLeagueTeams(widget.arguments['teams']);
        }
        if (index == 2) {
          leagueController.loadLeagueStats(widget.arguments['stats']);
        }
        if (index == 3) {
          leagueController.loadLeagueTable(widget.arguments['table']);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    leagueController.cdispose();
  }

  @override
  Widget build(BuildContext context) {
    var size1 = MediaQuery.of(context).size;
    final double itemHeight = (size1.height - kToolbarHeight - 10) / 4;
    final double itemWidth = size1.width / 2;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image:
                DecorationImage(image: AssetImage(AppAssets.backgroundImage))),
        child: DefaultTabController(
          length: 3,
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
                    child: Container(
                      color: Colors.transparent,
                      height: 20,
                      child: MarqueeWidget(
                        text: widget.arguments['name'],
                        textStyle: TextStyle(
                          fontSize: AppSizes.size16,
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
                    background: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxHeight: 165),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),

                      // decoration:
                      //   BoxDecoration(color: AppColors.gradtop), ////////
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(top: 20),
                            child: CachedNetworkImage(
                              imageUrl: widget.arguments['image'],
                              height: AppSizes.newSize(9),
                              width: AppSizes.newSize(9),
                              placeholder: (context, url) => Transform.scale(
                                scale: .25,
                                child: const CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                              errorWidget: (context, url, error) =>
                                  Image.asset(AppAssets.team),
                            ),
                          ),
                          Container(
                            width: AppSizes.newSize(15),
                            margin: const EdgeInsets.only(top: 8),
                            child: Text(
                              widget.arguments['name'],
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: AppSizes.size14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      onTap: (v) {
                        if (v == 0) {}
                        if (v == 1) {
                          leagueController
                              .loadLeagueTeams(widget.arguments['teams']);
                        }
                        if (v == 2) {
                          leagueController
                              .loadLeagueStats(widget.arguments['stats']);
                        }
                        if (v == 2) {
                          leagueController
                              .loadLeagueStats(widget.arguments['table']);
                        }
                      },
                      isScrollable: true,
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
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.red),
                      ),
                      tabs: [
                        Tab(text: 'SCHEDULE'.tr),
                        Tab(text: 'TEAMS'.tr),
                        Tab(text: 'STATS'.tr),
                        Tab(text: 'TABLE'.tr),
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
                    ////////////////////SCHEDULE?////////////////////////////////////
                    if (!leagueController.isLoading2.value &&
                        leagueController.fixtures.value.leagueFixtures!.isEmpty)
                      Center(
                        child: Text(
                          'No Fixtures'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      !leagueController.isLoading2.value &&
                              leagueController
                                  .fixtures.value.leagueFixtures!.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                leagueController.loadLeagueFixtures(
                                    widget.arguments['schedule']);
                              },
                              child: ListView.separated(
                                separatorBuilder: (context, index) => Container(
                                  padding:
                                      const EdgeInsets.only(bottom: 4, top: 4),
                                ),
                                itemCount: leagueController
                                    .fixtures.value.leagueFixtures!.length,
                                itemBuilder: (context, index) {
                                  return LeagueFixturesWidget(leagueController
                                      .fixtures.value.leagueFixtures![index]);
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
                    ///////////TEAMS///////////////////////
                    if (!leagueController.isLoading6.value &&
                        leagueController.teams.value.team!.isEmpty)
                      Center(
                        child: Text(
                          'No Teams'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      !leagueController.isLoading6.value &&
                              leagueController.teams.value.team!.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                leagueController.isLoading6.value = true;
                                leagueController
                                    .loadLeagueTeams(widget.arguments['teams']);
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                child: GridView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      leagueController.teams.value.team!.length,
                                  itemBuilder: (context, index) {
                                    return TeamList(leagueController
                                        .teams.value.team![index]);
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: (itemWidth / itemHeight),
                                  ),
                                ),
                              ))
                          : Center(
                              child: SizedBox(
                                  height: AppSizes.newSize(3),
                                  width: AppSizes.newSize(3),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            ),

                    ////////////////STATS//////////////////////////
                    if (!leagueController.isLoading4.value &&
                        leagueController.stats.value.stats == null)
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
                      !leagueController.isLoading4.value &&
                              leagueController
                                  .stats.value.stats!.topScorers!.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                leagueController
                                    .loadLeagueStats(widget.arguments['stats']);
                              },
                              child: TeamStatWidget(
                                  leagueController.stats.value.stats!))
                          : Center(
                              child: SizedBox(
                                height: AppSizes.newSize(3),
                                width: AppSizes.newSize(3),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ///////////TABLE/////////////////////////

                    if (!leagueController.isLoading3.value &&
                        leagueController.table.value.team!.isEmpty)
                      Center(
                        child: Text(
                          'No League Table found'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      !leagueController.isLoading3.value &&
                              leagueController.table.value.team!.isNotEmpty
                          ? RefreshIndicator(
                              onRefresh: () async {
                                leagueController
                                    .loadLeagueTable(widget.arguments['table']);
                              },
                              child: LeagueTableWidget(
                                  leagueController.table.value))
                          : Center(
                              child: SizedBox(
                                  height: AppSizes.newSize(3),
                                  width: AppSizes.newSize(3),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            ),
                  ]),
                )),
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBannerAd(),
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
      alignment: Alignment.center,
      color: Theme.of(Get.context!).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
