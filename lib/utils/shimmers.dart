import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nimu_shimmer/nimu_shimmer.dart';

import '../consts/app_sizes.dart';

homeShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            const SizedBox(height: 10),
            Positioned(
                left: 50,
                top: 30,
                child: NimuShimmer(
                  mainColor: Colors.grey.withOpacity(0.8),
                  secondaryColor: Colors.white.withOpacity(0.4),
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: AppSizes.newSize(12),
                      height: AppSizes.newSize(2.2),
                      color: Colors.white,
                    ),
                  ),
                )),
            Positioned(
                left: 50,
                top: 30,
                child: NimuShimmer(
                  mainColor: Colors.grey.withOpacity(0.8),
                  secondaryColor: Colors.white.withOpacity(0.4),
                  child: Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        shimmerCircle(),
                        shimmerCircle(),
                        shimmerCircle(),
                        shimmerCircle(),
                      ],
                    ),
                  ),
                )),
            Positioned(
                child: NimuShimmer(
              mainColor: Colors.grey.withOpacity(0.7),
              secondaryColor: Colors.white.withOpacity(0.5),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                margin: const EdgeInsets.symmetric(horizontal: 4)
                    .copyWith(top: 30, left: 30),
                width: Get.width * .95,
                height: AppSizes.newSize(15),
              ),
            ))
          ],
        ),
        const SizedBox(height: 10),
        NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: AppSizes.newSize(13),
                  height: AppSizes.newSize(2.5),
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    shimmerCircle(),
                    shimmerCircle(),
                    shimmerCircle(),
                    shimmerCircle(),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  width: AppSizes.newSize(13),
                  height: AppSizes.newSize(2.5),
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [shimmerContainer2(), shimmerContainer3()],
                ),
                const SizedBox(height: 20),
                Container(
                  width: AppSizes.newSize(13),
                  height: AppSizes.newSize(2.5),
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                shimmerContainer(),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

shimmerCircle() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Colors.white,
    ),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: AppSizes.newSize(7),
    height: AppSizes.newSize(7),
  );
}

shimmerContainer() {
  return Container(
    // margin: const EdgeInsets.symmetric(horizontal: 4),
    width: Get.width * 0.1,
    height: AppSizes.newSize(2),
    color: Colors.white,
  );
}

shimmerContainer2() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: Get.width * .7,
    height: AppSizes.newSize(16),
    color: Colors.white,
  );
}

shimmerContainer3() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: Get.width * .2,
    height: AppSizes.newSize(16),
    color: Colors.white,
  );
}

shimmerContainer4() {
  return Container(
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: AppSizes.newSize(15),
    height: AppSizes.newSize(10),
  );
}

shimmerContainer5() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: AppSizes.newSize(6),
    height: AppSizes.newSize(6),
    color: Colors.white,
  );
}

shimmerheader() {
  return NimuShimmer(
      mainColor: Colors.grey.withOpacity(0.8),
      secondaryColor: Colors.white.withOpacity(0.4),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: Get.width * .4,
        height: AppSizes.newSize(3),
        color: Colors.white,
      ));
}

highlightShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        highlightContainer(),
        const SizedBox(height: 10),
        highlightContainer(),
        const SizedBox(height: 10),
      ],
    ),
  );
}

highlightContainer() {
  return Stack(
    children: [
      Positioned(
          left: 50,
          top: 40,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: AppSizes.newSize(8),
                  height: AppSizes.newSize(8),
                ),
                const SizedBox(height: 15),
                Container(
                  width: AppSizes.newSize(8),
                  height: AppSizes.newSize(4),
                  color: Colors.white,
                ),
              ],
            ),
          )),
      Positioned(
          right: 50,
          top: 40,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: AppSizes.newSize(8),
                  height: AppSizes.newSize(8),
                ),
                const SizedBox(height: 15),
                Container(
                  width: AppSizes.newSize(8),
                  height: AppSizes.newSize(4),
                  color: Colors.white,
                ),
              ],
            ),
          )),
      Positioned(
          bottom: 50,
          left: 100,
          right: 100,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 4).copyWith(top: 5),
                width: AppSizes.newSize(5),
                height: AppSizes.newSize(5),
              ),
            ),
          )),
      Positioned(
          child: NimuShimmer(
        mainColor: Colors.grey.withOpacity(0.7),
        secondaryColor: Colors.white.withOpacity(0.5),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: Get.width * .95,
          height: AppSizes.newSize(22),
          color: Colors.white,
        ),
      ))
    ],
  );
}

matchShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        matchContainer(),
        const SizedBox(height: 10),
        matchContainer(),
        const SizedBox(height: 10),
      ],
    ),
  );
}

matchShimmer2() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        customShimmerColumn(),
        customShimmerColumn(),
        customShimmerColumn(),
        customShimmerColumn(),
        customShimmerColumn(),
      ],
    ),
  );
}

matchShimmer21() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      customShimmerColumn(),
      customShimmerColumn(),
      customShimmerColumn(),
      customShimmerColumn(),
      customShimmerColumn(),
    ],
  );
}

customShimmerColumn() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.only(right: 2),
        child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: shimmerCircle()),
      ),
    ],
  );
}

matchContainer() {
  return Stack(
    children: [
      Positioned(
          top: 15,
          left: 30,
          right: 30,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Center(
              child: Container(
                width: AppSizes.newSize(18),
                height: AppSizes.newSize(2.5),
                color: Colors.white,
              ),
            ),
          )),
      Positioned(
          bottom: 10,
          left: 30,
          right: 30,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: AppSizes.newSize(9),
                height: AppSizes.newSize(2.1),
              ),
            ),
          )),
      Positioned(
          left: 20,
          top: 55,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Row(
              children: [
                Container(
                  width: AppSizes.newSize(12),
                  height: AppSizes.newSize(1.8),
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: AppSizes.newSize(5),
                  height: AppSizes.newSize(5),
                ),
              ],
            ),
          )),
      Positioned(
          right: 20,
          top: 55,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: AppSizes.newSize(5),
                  height: AppSizes.newSize(5),
                ),
                const SizedBox(width: 5),
                Container(
                  width: AppSizes.newSize(12),
                  height: AppSizes.newSize(1.8),
                  color: Colors.white,
                ),
              ],
            ),
          )),
      Positioned(
          child: NimuShimmer(
        mainColor: Colors.grey.withOpacity(0.7),
        secondaryColor: Colors.white.withOpacity(0.5),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: Get.width * .95,
          height: AppSizes.newSize(17),
          color: Colors.white,
        ),
      ))
    ],
  );
}

newsShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        newsContainer(),
        const SizedBox(height: 10),
        newsContainer(),
        const SizedBox(height: 10),
      ],
    ),
  );
}

newsContainer() {
  return Stack(
    children: [
      Positioned(
          top: 0,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.6),
            secondaryColor: Colors.white.withOpacity(0.3),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                width: Get.width * .92,
                height: AppSizes.newSize(23),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
              ),
            ),
          )),
      Positioned(
          bottom: 10,
          left: 20,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: AppSizes.newSize(30),
                  height: AppSizes.newSize(1.8),
                  color: Colors.white,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: AppSizes.newSize(30),
                  height: AppSizes.newSize(1.8),
                  color: Colors.white,
                ),
              ],
            ),
          )),
      Positioned(
          bottom: 10,
          right: 20,
          child: NimuShimmer(
            mainColor: Colors.grey.withOpacity(0.8),
            secondaryColor: Colors.white.withOpacity(0.4),
            child: Container(
              width: AppSizes.newSize(4),
              height: AppSizes.newSize(4),
              color: Colors.white,
            ),
          )),
      Positioned(
          child: NimuShimmer(
        mainColor: Colors.grey.withOpacity(0.7),
        secondaryColor: Colors.white.withOpacity(0.5),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: Get.width * .95,
          height: AppSizes.newSize(32),
        ),
      ))
    ],
  );
}

newsDetailsShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: Get.width * .9,
                      height: AppSizes.newSize(2.5),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: Get.width * .9,
                      height: AppSizes.newSize(2.5),
                      color: Colors.white,
                    ),
                    const SizedBox(height: 14),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: AppSizes.newSize(15),
                      height: AppSizes.newSize(2.5),
                      color: Colors.white,
                    ),
                    Container(
                      width: AppSizes.newSize(10),
                      height: AppSizes.newSize(2.5),
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                shimmerContainer(),
                const SizedBox(height: 14),
                const SizedBox(height: 30),
                newsColumn(),
                newsColumn(),
                newsColumn(),
                newsColumn(),
                newsColumn(),
                newsColumn(),
                newsColumn(),
              ],
            ),
          ),
        ))
      ],
    ),
  );
}

newsColumn() {
  return Column(
    children: [
      Container(
          width: Get.width * .9,
          height: AppSizes.newSize(2),
          color: Colors.white),
      const SizedBox(height: 4),
      Container(
          width: Get.width * .9,
          height: AppSizes.newSize(2),
          color: Colors.white),
      const SizedBox(height: 14),
    ],
  );
}

standingsShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
              separatorBuilder: ((context, index) => const SizedBox(height: 5)),
              itemCount: 8,
              itemBuilder: ((context, index) {
                return NimuShimmer(
                  mainColor: Colors.grey.withOpacity(0.7),
                  secondaryColor: Colors.white.withOpacity(0.5),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.only(
                        top: 0, bottom: 5, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: AppSizes.newSize(16),
                          height: AppSizes.newSize(16),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.white,
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: AppSizes.newSize(16),
                          height: AppSizes.newSize(16),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        )
      ],
    ),
  );
}

livelistShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                shimmerContainerlivelist(),
                shimmerContainerlivelist(),
                shimmerContainerlivelist(),
                shimmerContainerlivelist(),
                shimmerContainerlivelist(),
                SizedBox(
                  height: AppSizes.newSize(30),
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

shimmerContainerlivelist() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    child: Stack(
      children: [
        Positioned(
            child: NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.8),
          secondaryColor: Colors.white.withOpacity(0.4),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              width: AppSizes.newSize(12),
              height: AppSizes.newSize(1.8),
              color: Colors.white,
            ),
          ),
        )),
        Positioned(
            left: 20,
            top: 30,
            child: NimuShimmer(
              mainColor: Colors.grey.withOpacity(0.8),
              secondaryColor: Colors.white.withOpacity(0.4),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: AppSizes.newSize(5),
                    height: AppSizes.newSize(5),
                  ),
                  Container(
                    width: AppSizes.newSize(8),
                    height: AppSizes.newSize(1.8),
                    color: Colors.white,
                  ),
                ],
              ),
            )),
        Positioned(
            right: 20,
            top: 30,
            child: NimuShimmer(
              mainColor: Colors.grey.withOpacity(0.8),
              secondaryColor: Colors.white.withOpacity(0.4),
              child: Row(
                children: [
                  Container(
                    width: AppSizes.newSize(8),
                    height: AppSizes.newSize(1.8),
                    color: Colors.white,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: AppSizes.newSize(5),
                    height: AppSizes.newSize(5),
                  ),
                ],
              ),
            )),
        Positioned(
            child: NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: Get.width * .95,
            height: AppSizes.newSize(10),
            color: Colors.white,
          ),
        ))
      ],
    ),
  );
}

liveMatchshimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ).copyWith(bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: Get.width * .2,
                  height: AppSizes.newSize(3),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      width: Get.width * .7,
                      height: AppSizes.newSize(19),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: Get.width * .12,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20))),
                      height: AppSizes.newSize(19),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

predictionShimmer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NimuShimmer(
          mainColor: Colors.grey.withOpacity(0.7),
          secondaryColor: Colors.white.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ).copyWith(bottom: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  width: Get.width * .2,
                  height: AppSizes.newSize(3),
                ),
                shimmerContainer()
              ],
            ),
          ),
        )
      ],
    ),
  );
}
