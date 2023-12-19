import 'dart:math';
import 'package:flutter/material.dart';
import '/consts/app_colors.dart';
import '/consts/app_sizes.dart';

List<Widget> getPosition() {
  final random = Random();

  List positions = [
    Positioned(
      bottom: 60,
      left: 0,
      child: Container(
        width: AppSizes.newSize(15),
        height: 3,
        color: AppColors.selective,
      ),
    ),
    Positioned(
      bottom: 60,
      left: 0,
      child: Container(
        width: AppSizes.newSize(15),
        height: 3,
        color: Colors.red,
      ),
    ),
    // Positioned(
    //   bottom: 40,
    //   left: 20,
    //   child: Container(
    //     width: 40,
    //     height: 3,
    //     color: HexColor('#C61D22'),
    //   ),
    // ),
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
    const Positioned(
      bottom: 0,
      left: 0,
      child: DottedWidget(Colors.red),
    ),
    Positioned(
      bottom: 0,
      left: 0,
      child: DottedWidget(AppColors.selective),
    ),
    // Positioned(
    //   bottom: 20,
    //   left: 20,
    //   child: DottedWidget(
    //     HexColor('#C61D22'),
    //   ),
    // ),
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

  int index = random.nextInt(positions.length);
  return [positions[index], positions2[index]];
}

class DottedWidget extends StatelessWidget {
  const DottedWidget(
    this.color, {
    Key? key,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.newSize(8),
      height: 3,
      color: color,
    );
  }
}

//  Row(
//       children: List.generate(
//         5,
//         (index) => Container(
//           decoration: BoxDecoration(
//             // borderRadius: BorderRadius.circular(100),
//             color: color.withGreen(255),
//           ),
//           margin: EdgeInsets.only(right: 0),
//           width: 4,
//           height: 4,
//         ),
//       ),
//     );
class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintGreen = Paint()..color = Colors.black.withOpacity(0.2);

    final pathGreen = Path();
    pathGreen.moveTo(0, size.height);
    pathGreen.lineTo(size.width + 20, size.height);
    pathGreen.lineTo(0, -10);
    pathGreen.close();
    canvas.drawPath(pathGreen, paintGreen);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
