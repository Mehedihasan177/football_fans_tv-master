import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/consts/app_assets.dart';
import '/controllers/auth_controller.dart';
import '/controllers/color_controller.dart';
import '/services/ads_service.dart';
import '/services/app_open_service.dart';
import '/views/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import 'home_screen.dart';
import 'live_list_screen.dart';
import 'more_screen.dart';
import 'news_screen.dart';
import 'standings_screen.dart';

class ParentScreen extends StatefulWidget {
  const ParentScreen(this.index, {Key? key}) : super(key: key);
  final int index;
  @override
  State<ParentScreen> createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  int _selectedIndex = 0;
  AuthController authController = Get.find();
  ColorController colorController = Get.put(ColorController());
  late AppLifecycleReactor _appLifecycleReactor;
  static List<Widget> _widgetOptions = <Widget>[];
  // Widget? _child;

  @override
  void initState() {
    super.initState();

    _selectedIndex = widget.index;
    _widgetOptions = <Widget>[
      // if (settingController.appPublishingControl.value == true)
      const LiveListScreen(),
      const StandingsScreen(),
      const HomepageScreen(),
      const NewsScreen(),
      const MoreScreen(),
    ];

    AdsService.createInterstitialAd(
      () {},
    );
    Future.delayed(
      1.seconds,
      () {
        AppOpenService appOpenService = AppOpenService()..loadAd(false);
        _appLifecycleReactor =
            AppLifecycleReactor(appOpenAdManager: appOpenService);
        _appLifecycleReactor.listenToAppStateChanges();
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.league.withOpacity(0.5),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.transparent.withOpacity(0.9), BlendMode.dstATop),
          image: const AssetImage(AppAssets.backgroundImage),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        //  drawer: drawer(),
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: AppSizes.newSize(7),
          elevation: 0,
          backgroundColor: Colors.transparent,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
          centerTitle: true,
          title: Image.asset(
            AppAssets.textlogo,
            height: 40,
          ),
          actions: _selectedIndex == 4
              ? [
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Obx(
                      () => authController.isSignIn.value
                          ? InkWell(
                              onTap: () {
                                authController.signOut();
                              },
                              child: Center(
                                child: Text(
                                  "SIGN OUT".tr,
                                  style: TextStyle(
                                    fontSize: AppSizes.size12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withOpacity(.85),
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.to(() => const LoginScreen());
                              },
                              child: Center(
                                child: Text(
                                  "SIGN IN".tr,
                                  style: TextStyle(
                                    fontSize: AppSizes.size12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white.withOpacity(.85),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ]
              : [],
        ),
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: SizedBox(
          //color: AppColors.background,

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BannerAds(),
              // const CustomBannerAd(),
              FluidNavBar(
                icons: [
                  FluidNavBarIcon(
                      svgPath: AppAssets.live,
                      backgroundColor: Colors.transparent,
                      extras: {"label": "home"},
                      title: "LIVE"
                      //  title: 'Home',
                      ),
                  FluidNavBarIcon(
                    svgPath: AppAssets.trophy,
                    backgroundColor: Colors.transparent,
                    extras: {"label": "bookmark"},
                    title: 'LEAGUE',
                  ),
                  FluidNavBarIcon(
                    svgPath: AppAssets.home,
                    backgroundColor: Colors.transparent,
                    extras: {"label": "partner"},
                    title: 'HOME',
                  ),
                  FluidNavBarIcon(
                    svgPath: AppAssets.news,
                    backgroundColor: Colors.transparent,
                    extras: {"label": "conference"},
                    //titleColor: Colors.white,
                    title: 'NEWS',
                  ),
                  FluidNavBarIcon(
                    svgPath: AppAssets.more,
                    backgroundColor: Colors.transparent,
                    extras: {"label": "conference"},
                    //titleColor: Colors.white,
                    title: 'MORE',
                    //  titleSelectedColor: Colors.yellow,
                    //selectedForegroundColor: Colors.white,
                  ),
                ],
                onChange: _onItemTapped,
                style: FluidNavBarStyle(
                  iconUnselectedForegroundColor: Colors.grey,
                  iconSelectedForegroundColor: AppColors.bottomNavBlueColor,
                  // titleSelectedColor: Colors.red,
                  // titleColor: Colors.red,
                  barBackgroundColor: HexColor('#000922'),
                ),
                scaleFactor: 1.2,
                animationFactor: .2,
                defaultIndex: _selectedIndex,
                itemBuilder: (icon, item) => Semantics(
                  container: true,
                  excludeSemantics: true,
                  explicitChildNodes: true,
                  label: 'jkjsdj',
                  child: item,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
