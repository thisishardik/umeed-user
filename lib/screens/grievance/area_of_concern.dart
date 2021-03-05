import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:umeed_user_app/providers/dashboard_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AreaOfConcernScreen extends StatefulWidget {
  @override
  _AreaOfConcernScreenState createState() => _AreaOfConcernScreenState();
}

class _AreaOfConcernScreenState extends State<AreaOfConcernScreen> {
  List<String> areas_of_concern = new List<String>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    areas_of_concern =
        Provider.of<DashboardProvider>(context, listen: false).areas_of_concern;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const curveHeight = 28.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        shape: const MyShapeBorder(curveHeight),
        centerTitle: true,
        title: Text('Area of Concern'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.0),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 16, right: 16),
              itemCount: areas_of_concern.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.teal,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/splash.jpg',
                            width: 42,
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            areas_of_concern[index],
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            areas_of_concern[index],
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Text(
                            areas_of_concern[index],
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
    );
  }
}

class MyShapeBorder extends ContinuousRectangleBorder {
  const MyShapeBorder(this.curveHeight);
  final double curveHeight;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + curveHeight * 2,
      rect.size.width,
      rect.size.height,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}