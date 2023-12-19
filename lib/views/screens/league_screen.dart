import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import 'package:get/get.dart';

import '../../consts/app_assets.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../controllers/league_controller.dart';
import '../../utils/marquee_widget.dart';
import '../widgets/league_fixtures_widget.dart';
import '../widgets/league_table_widget.dart';
import '../widgets/league_transfer.dart';
import '../widgets/sabt.dart';
import '../widgets/teamstats.dart';

class LeagueScreen extends StatefulWidget {
  const LeagueScreen(this.arguments, {Key? key}) : super(key: key);
  final Map arguments;
  @override
  State<LeagueScreen> createState() => _LeagueScreenState();
}

class _LeagueScreenState extends State<LeagueScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    //log(widget.arguments['table']);
    _tabController!.addListener(
      () {
        setState(() {
          index = _tabController!.index;
        });
        if (index == 1) {
          leagueController.loadLeagueTable(widget.arguments['table']);
        }
        if (index == 2) {
          leagueController.loadLeagueStats(widget.arguments['stats']);
        }

        if (index == 3) {
          leagueController.loadLeagueTransfer(widget.arguments['transfers']);
        }
      },
    );

    leagueController.loadLeagueFixtures(widget.arguments['fixtures']);
  }

  @override
  void dispose() {
    super.dispose();
    leagueController.cdispose();
  }

  LeagueController leagueController = Get.put(LeagueController());
  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(AppAssets.backgroundImage),
          fit: BoxFit.cover,
        )),
        child: DefaultTabController(
          length: 4,
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
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      constraints: const BoxConstraints(maxHeight: 165),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: const BoxDecoration(
                          // color: Colors.red
                          ),
                      // decoration:
                      //   BoxDecoration(color: AppColors.gradtop), ////////
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: AppSizes.newSize(15),
                            width: AppSizes.newSize(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            padding: const EdgeInsets.all(15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                imageUrl: widget.arguments['image'].toString(),
                                height: AppSizes.newSize(11),
                                width: AppSizes.newSize(11),
                                placeholder: (context, url) => Transform.scale(
                                  scale: .25,
                                  child: const CircularProgressIndicator(
                                      color: Colors.white),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
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
                      isScrollable: false,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      onTap: (v) {
                        if (v == 0) {}
                        if (v == 1) {
                          leagueController
                              .loadLeagueTable(widget.arguments['table']);
                        }
                        if (v == 2) {
                          leagueController
                              .loadLeagueStats(widget.arguments['stats']);
                        }

                        if (v == 3) {
                          leagueController.loadLeagueTransfer(
                              widget.arguments['transfers']);
                        }
                        if (v == 4) {
                          leagueController
                              .loadMainNews(widget.arguments['name']);
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
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(width: 4.0, color: Colors.red),
                      ),
                      tabs: [
                        Tab(text: 'Fixtures'.tr),
                        Tab(text: 'Table'.tr),
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
                  /////////////FIXTURES START///////////////////////////
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
                                  widget.arguments['fixtures']);
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
                            child:
                                LeagueTableWidget(leagueController.table.value))
                        : Center(
                            child: SizedBox(
                                height: AppSizes.newSize(3),
                                width: AppSizes.newSize(3),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                )),
                          ),
                  ///////////////////STATS////////////////////////////////
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
                          )),

                  //////////////////////TRANSFERS////////////////////////////////////
                  (!leagueController.isLoading5.value)
                      ? (leagueController.transfer.value.transfers?.length ??
                                  0) >
                              0
                          ? RefreshIndicator(
                              onRefresh: () async {
                                leagueController
                                    .loadLeagueStats(widget.arguments['stats']);
                              },
                              child: LeagueTransferWidget(
                                  leagueController.transfer.value.transfers!))
                          : Center(
                              child: Text(
                                'No Transfer found'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                      : const Center(
                          child: CircularProgressIndicator(
                          color: Colors.white,
                        )),
                ]),
              ),
            ),
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
      color: Theme.of(Get.context!).primaryColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
