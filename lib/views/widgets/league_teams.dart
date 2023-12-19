import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../consts/app_colors.dart';
import '../../consts/app_sizes.dart';
import '../../controllers/color_controller.dart';
import '../../models/league_teams.dart';

class TeamList extends StatefulWidget {
  const TeamList(this.team, {Key? key}) : super(key: key);
  final Team team;

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  ColorController colorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          BoxShadow(
            color: AppColors.appColor,
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: CachedNetworkImage(
              imageUrl: widget.team.image.toString(),
              width: AppSizes.newSize(9),
              height: AppSizes.newSize(9),
              placeholder: (context, url) => Center(
                  child: SizedBox(
                height: AppSizes.newSize(1.5),
                width: AppSizes.newSize(1.5),
                child: const CircularProgressIndicator(
                  color: Colors.black,
                ),
              )),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/default-team.png'),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              flex: 1,
              child: Container(
                height: AppSizes.newSize(6),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.appColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(7),
                        bottomRight: Radius.circular(7))),
                child: Center(
                  child: Text(
                    widget.team.name.toString(),
                    maxLines: 2,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        fontSize: AppSizes.size13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
