//import 'package:flutter/material.dart';
//import 'package:front_v1/Theme/app_theme.dart';
//import 'package:flutter/material.dart';
//
//
//class categoryListView extends StatefulWidget {
//  const categoryListView(
//      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
//      : super(key: key);
//
//  final AnimationController mainScreenAnimationController;
//  final Animation<dynamic> mainScreenAnimation;
//  @override
//  _AreaListViewState createState() => _AreaListViewState();
//}
//
//class _AreaListViewState extends State<categoryListView>
//    with TickerProviderStateMixin {
//  AnimationController animationController;
//  List<String> areaListData = <String>[
//    'assets/fitness_app/area1.png',
//    'assets/fitness_app/area2.png',
//    'assets/fitness_app/area3.png',
//    'assets/fitness_app/area1.png',
//  ];
//
//  @override
//  void initState() {
//    animationController = AnimationController(
//        duration: const Duration(milliseconds: 2000), vsync: this);
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    animationController.dispose();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      animation: widget.mainScreenAnimationController,
//      builder: (BuildContext context, Widget child) {
//        return FadeTransition(
//          opacity: widget.mainScreenAnimation,
//          child: Transform(
//            transform: Matrix4.translationValues(
//                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
//            child: AspectRatio(
//              aspectRatio: 1.0,
//              child: Padding(
//                padding: const EdgeInsets.only(left: 8.0, right: 8),
//                child: GridView(
//                  padding: const EdgeInsets.only(
//                      left: 16, right: 16, top: 16, bottom: 16),
//                  physics: const BouncingScrollPhysics(),
//                  scrollDirection: Axis.vertical,
//                  children: List<Widget>.generate(
//                    areaListData.length,
//                        (int index) {
//                      final int count = areaListData.length;
//                      final Animation<double> animation =
//                      Tween<double>(begin: 0.0, end: 1.0).animate(
//                        CurvedAnimation(
//                          parent: animationController,
//                          curve: Interval((1 / count) * index, 1.0,
//                              curve: Curves.fastOutSlowIn),
//                        ),
//                      );
//                      animationController.forward();
//                      return AreaView(
//                        imagepath: areaListData[index],
//                        animation: animation,
//                        animationController: animationController,
//                      );
//                    },
//                  ),
//                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2,
//                    mainAxisSpacing: 24.0,
//                    crossAxisSpacing: 24.0,
//                    childAspectRatio: 1.0,
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
//
//class AreaView extends StatelessWidget {
//  const AreaView({
//    Key key,
//    this.imagepath,
//    this.animationController,
//    this.animation,
//  }) : super(key: key);
//
//  final String imagepath;
//  final AnimationController animationController;
//  final Animation<dynamic> animation;
//
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedBuilder(
//      animation: animationController,
//      builder: (BuildContext context, Widget child) {
//        return FadeTransition(
//          opacity: animation,
//          child: Transform(
//            transform: Matrix4.translationValues(
//                0.0, 50 * (1.0 - animation.value), 0.0),
//            child: Container(
//              decoration: BoxDecoration(
//                color: AppTheme.white,
//                borderRadius: const BorderRadius.only(
//                    topLeft: Radius.circular(8.0),
//                    bottomLeft: Radius.circular(8.0),
//                    bottomRight: Radius.circular(8.0),
//                    topRight: Radius.circular(8.0)),
//                boxShadow: <BoxShadow>[
//                  BoxShadow(
//                      color: AppTheme.grey.withOpacity(0.4),
//                      offset: const Offset(1.1, 1.1),
//                      blurRadius: 10.0),
//                ],
//              ),
//              child: Material(
//                color: Colors.transparent,
//                child: InkWell(
//                  focusColor: Colors.transparent,
//                  highlightColor: Colors.transparent,
//                  hoverColor: Colors.transparent,
//                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//                  splashColor: AppTheme.nearlyDarkBlue.withOpacity(0.2),
//                  onTap: () {},
//                  child: Column(
//                    children: <Widget>[
//                      Padding(
//                        padding:
//                        const EdgeInsets.only(top: 16, left: 16, right: 16),
//                        child: Image.asset(imagepath),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//}


import 'package:flutter/material.dart';


import 'package:front_v1/Pages/Dashboard/meals_list_data.dart';
import 'package:front_v1/Theme/app_theme.dart';
import 'package:front_v1/main.dart';

class categoryListView extends StatefulWidget {
  const categoryListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<dynamic> mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<categoryListView>
    with TickerProviderStateMixin {
  AnimationController animationController;


  List<MealsListData> mealsListData = MealsListData.tabIconsList;





  @override
  void initState() {

    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
            child: Container(
              height: 100,
              width: 100,

              child: ListView.builder(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 20, left: 20),
                itemCount: mealsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                  mealsListData.length > 10 ? 10 : mealsListData.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: animationController,
                          curve: Interval((1 / count) * index, 1.0,
                              curve: Curves.fastOutSlowIn)));
                  animationController.forward();

                  return MealsView(
                    mealsListData: mealsListData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {
  const MealsView(
      {Key key, this.mealsListData, this.animationController, this.animation})
      : super(key: key);

  final MealsListData mealsListData;
  final AnimationController animationController;
  final Animation<dynamic> animation;




  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: SizedBox(
              width: 100,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, left: 8, right: 8, bottom: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: HexColor("#FFFFFF")
                                  .withOpacity(0.6),
                              offset: const Offset(1.1, 4.0),
                              blurRadius: 8.0),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor("#FFFFFF"),
                            HexColor("#FFFFFF"),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                        ),





                      ),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        children: <Widget>[
//                          Image.asset(mealsListData.iconPath),
//                        ],
//
//                    ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0,right: 5.0,top: 8.0,bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          elevation: 5.0,
                          padding: EdgeInsets.all(15.0),
//                          child: Image.asset("images/Device/all.jpg"),
                          child: Image.asset(mealsListData.iconPath),

                        ),
//
//                        MaterialButton(
//                          elevation: 5.0,
//                          padding: EdgeInsets.all(15.0),
//                          child: Image.asset(mealsListData.iconPath),
//
//                        ),
//
//
//                        MaterialButton(
//                          elevation: 5.0,
//                          padding: EdgeInsets.all(15.0),
//                          child: Image.asset(mealsListData.iconPath),
//
//                        ),


//                        Image.asset(mealsListData.iconPath),

                      ],

                    ),
                  ),
                  SizedBox(height: 20.0),




                  SizedBox(height: 20.0),

                ],
              ),

            ),

          ),
        );
      },
    );
  }
}
