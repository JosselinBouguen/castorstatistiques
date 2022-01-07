import 'package:castorstatistics/carte_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:castorstatistics/detail_page.dart';
import 'package:castorstatistics/widgets/discover_card.dart';
import 'package:castorstatistics/widgets/discover_small_card.dart';
import 'package:castorstatistics/charts_page.dart';


class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(

              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 36.h,
                bottom: 36.h
              ),
              child: Row(
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CASTOR STATISTICS",
                      style: TextStyle(
                          color: Colors.greenAccent.shade100,
                          fontSize: 32.w,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lato')),


                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Statistiques générales",
                    style: TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 20.w),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 176.w,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 28.w),
                  DiscoverCard(
                    tag: "general",
                    onTap: test,
                    title: "Statistiques générales",
                    subtitle: "Résumé global du site web",
                    gradientStartColor: Color(0xfffc865b),
                    gradientEndColor: Color(0xff56262),
                  ),
                  SizedBox(width: 20.w),
                  DiscoverCard(
                    onTap: Cartepage,
                    title: "Carte des Services",
                    subtitle: "Représentation de tout les services présents sur le site",
                    gradientStartColor: Color(0xff86ba52),
                    gradientEndColor: Color(0xff66b6cc),
                  ),
                ],
              ),
            ),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: Text(
                "Statistiques par catégories",
                style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.w),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 28.w),
              child: GridView(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 19.w, mainAxisExtent:  125.w, mainAxisSpacing: 19.w),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  DiscoverSmallCard(
                    onTap: test,
                    title: "Transports",
                    gradientStartColor: Color(0xff13DEA0),
                    gradientEndColor: Color(0xff06B782),

                  ),
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "Courses",
                    gradientStartColor: Color(0xffFC67A7),
                    gradientEndColor: Color(0xffF6815B),

                  ),
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "Formations",
                    gradientStartColor: Color(0xffFFD541),
                    gradientEndColor: Color(0xffF0B31A),
                  ),
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "Loisirs",

                  ),
                  DiscoverSmallCard(
                    onTap: (){},
                    title: "Tâches ménagères",
                    gradientStartColor: Color(0xffcfa2f2),
                    gradientEndColor: Color(0xa742f5),
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }


  void onSeeAllTapped() {
  }

  void StatGenerales() {
    Get.to(()=> DetailPage(), transition: Transition.rightToLeft);
  }
  void test() {
    print("test");
    Get.to(()=> ChartsPage(), transition: Transition.rightToLeft);
    print("123");
  }
  void Cartepage() {
    Get.to(()=> CartePage(), transition: Transition.rightToLeft);
  }

  void onSearchIconTapped() {
  }
}
