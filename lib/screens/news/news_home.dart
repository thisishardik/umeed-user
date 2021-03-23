import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:umeed_user_app/helpers/news_category.dart';
import 'package:umeed_user_app/helpers/news_data.dart';
import 'package:umeed_user_app/components/news_tile.dart';
import 'package:umeed_user_app/screens/dashboard.dart';
import 'package:umeed_user_app/screens/help_screen.dart';
import 'package:umeed_user_app/screens/news/category_news.dart';
import 'package:umeed_user_app/screens/news/news_fetch_api.dart';
import 'package:umeed_user_app/screens/profile_screen.dart';

class NewsHomeScreen extends StatefulWidget {
  @override
  _NewsHomeScreenState createState() => _NewsHomeScreenState();
}

class _NewsHomeScreenState extends State<NewsHomeScreen> {
  bool _loading;
  var newslist;
  int index = 1;
  List<CategoryModel> categories = List<CategoryModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            Text(
              "by",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "UMEED",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Icon(Icons.adb, color: Colors.white),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              PageTransition(
                child: Dashboard(),
                type: PageTransitionType.fade,
              ),
            );
          }
          if (index == 1) {
            print("DUHH!");
          }
          if (index == 2) {
            Navigator.push(
              context,
              PageTransition(
                child: HelpScreen(),
                type: PageTransitionType.fade,
              ),
            );
          }
          if (index == 3) {}
          if (index == 4) {
            Navigator.push(
              context,
              PageTransition(
                child: ProfileScreen(),
                type: PageTransitionType.fade,
              ),
            );
          }
        },
        elevation: 100.0,
        selectedItemColor: Color(0xff0c18fb),
        // selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[600],
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconTheme: IconThemeData(
          size: 26,
        ),
        unselectedIconTheme: IconThemeData(
          size: 23,
        ),
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(
              AntDesign.home,
            ),
          ),
          BottomNavigationBarItem(
            label: "News",
            icon: Icon(
              FontAwesome5.newspaper,
            ),
          ),
          BottomNavigationBarItem(
            label: "Help",
            icon: Icon(
              AntDesign.phone,
            ),
          ),
          BottomNavigationBarItem(
            label: "Share",
            icon: Icon(
              AntDesign.sharealt,
            ),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(
              AntDesign.user,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categoryName,
                              );
                            }),
                      ),

                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryNews(
              newsCategory: categoryName.toLowerCase(),
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black26),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
