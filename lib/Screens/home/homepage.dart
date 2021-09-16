import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ten_news/model/categories_model.dart';
import 'package:ten_news/reusable/custom_cards.dart';
import 'package:ten_news/utlis.dart';

class HomePage extends StatefulWidget {
  final Map<String, List> newsDate;

  const HomePage({Key? key, required this.newsDate}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late TabController _tabController;
  int currentIndex = 0;

  _smoothScrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(microseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: categories.length, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
  }

  changePage(int indext) {
    setState(() {
      currentIndex = indext;
    });
  }



  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 25),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Top News Updates",
                    style: TextStyle(
                      fontFamily: "Times",
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                alignment: Alignment.topCenter,
                child: TabBar(
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: Colors.black45,
                  unselectedLabelStyle: TextStyle(
                    fontFamily: "Avenir",
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: List.generate(categories.length,
                      (index) => Text(categories[index].name)),
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: TabBarView(
            controller: _tabController,
            children: List.generate(
              categories.length,
              (index) {
                var key = categories[index]
                    .imageUrl
                    .toString()
                    .split('/')[3]
                    .split('.')[0]
                    .replaceAll("_", "_");
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, i) {
                    String time = widget.newsDate[key]?[i]['pubDate']['_cdate'];
                    DateTime timeIst = DateTime.parse(time.split('')[3] + "-" + getMonthNumberFromName(month: 
                    time.split('')[2] + "-" + time.split(" ")[1] + " " + time.split(" ")[4]));
                    timeIst = timeIst.add(Duration(hours: 5)).add(Duration(minutes: 30));
                    return HomePageCard(
                     title: widget.newsDate[key]?[i]['title']['_cdata'],
                     subtitle: widget.newsDate[key]?[i]['description']['_cdate'],
                     imageUrl: widget.newsDate[key]?[i][r'media$content']['url'],
                     time: timeIst.day.toString() + " " + getMonthNumberInWords(month: timeIst.month) + 
                     " " + timeIst.toString().split(" ")[1].substring(0,5),
                    );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 25),
                );
              },
            ),
          ),
        ));
  }
}
