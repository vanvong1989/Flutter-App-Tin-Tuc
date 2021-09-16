// ignore: import_of_legacy_library_into_null_safe
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ten_news/Screens/home/homepage.dart';
// ignore: unused_import
import 'package:ten_news/backend/rss_to_json.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Map<String, List> newsData = Map<String, List>();
   bool isLoading = true;

  getData() async {
    Future.wait([
      rssToJson('topnews'),
      rssToJson('india'),
      rssToJson('world-news'),
      rssToJson('business'),
      rssToJson('sports'),
      rssToJson('cricket'),
      rssToJson('tech-features'),
      rssToJson('education'),
      rssToJson('music'),
      rssToJson('lifestyle'),
      rssToJson('health-fitness'),
      rssToJson('fashion-trends'),
      rssToJson('art-culture'),
      rssToJson('travel'),
       rssToJson('books'),
      rssToJson('realestate'),
      rssToJson('its-viral'),
    ]).then((value) => {
      newsData['topneews'] = value[0],
      newsData['india'] = value[1],
      newsData['world-news'] = value[2],
      newsData['business'] = value[3],
      newsData['sports'] = value[4],
      newsData['cricket'] = value[5],
      newsData['tech-features'] = value[6],
      newsData['education'] = value[7],
      newsData['music'] = value[8], 
      newsData['lifestyle'] = value[9],
      newsData['fashion-trends'] = value[10],
      newsData['art-culture'] = value[11],
      newsData['travel'] = value[12], 
      newsData['books'] = value[13],
      newsData['realestate'] = value[14],
      newsData['its-viral'] = value[15],
      newsData['health-fitness'] = value[16],
      setState(() {
        isLoading = false;
      })
    });
  }

@override
  void initState() {
    super.initState();
    getData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: SvgPicture.asset('assets/icons/drawer.svg'),
            ),
          ),
        ),
        titleSpacing: 0,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            DrawerHeader(
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                child: Image.asset('assets/ten_news.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "Setting",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "About",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Text(
              "Log Out",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Material(
              borderRadius: BorderRadius.circular(500),
              child: InkWell(
                borderRadius: BorderRadius.circular(500),
                splashColor: Colors.black45,
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: Center(
                    child: Text(
                      "v1.0.1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: isLoading? Center(
           child: CircularProgressIndicator(),
      ): <Widget>[
        HomePage(newsDate: newsData,),
        Container(
          color: Colors.red,
        ),
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.green,
        ),
      ][currentIndex],
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 8,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/search.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              title: Text("Search")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/bookmark.svg',
                width: 21,
                height: 21,
                color: Colors.black54,
              ),
              title: Text("BookMark")),
          BubbleBottomBarItem(
              backgroundColor: Colors.black,
              icon: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/user.png'),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff5c00000),
                      offset: Offset(0, 1),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              title: Text("Profile")),
        ],
      ),
    );
  }
}
