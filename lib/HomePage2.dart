import '/DocInfoPage.dart';
import '/colorScheme.dart';
import 'package:flutter/material.dart';
import 'LoginNew.dart';
import 'Start.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'SignUp.dart';

class HomePage2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'avenir',
      ),
      home: MyFirstPage(),
      routes: {
        '/DocInfoPage' : (context)=>DocInfoPage(),
        '/SignUp' : (context)=>SignUp(),
        '/LoginNew' : (context)=>LoginNew(),
      },
    );
  }



}
class MyFirstPage extends StatefulWidget {


  @override
  _MyFirstPageState createState() => _MyFirstPageState();
}



class _MyFirstPageState extends State<MyFirstPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed("start");
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  signOut() async {
    _auth.signOut();

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }

  navigateToSignUp() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: pathPainter(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Icon(
                    Icons.menu,
                    color: Colors.black,
                    size: 30,
                  ),
                  actions: <Widget>[
                    Container(
                      height: 75,
                        width: 75,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [getStartedColorStart, getStartedColorEnd],
                          stops: [0,1]
                        )
                      ),
                      child: InkWell(
                        child: Center(
                          child: Text("SignOut", style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        onTap: ToLogin,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 14, right: 10, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Available hair styles.", style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        margin: EdgeInsets.only(top: 10),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            categoryContainer("Angular-Fringe.jpeg", "Angular-Fringe"),
                            categoryContainer("Brushed-Up-Fringe-Hairstyles-For-Men.jpeg", "BrushedUp Fringe"),
                            categoryContainer("Curly-Fringe-For-Men.jpeg", "Curly Fringe"),
                            categoryContainer("French-Crop-with-Taper-Fade.jpeg", "French Crop"),
                            categoryContainer("Fringe-Haircuts-Men.jpeg", "Fringe English Latest"),
                            categoryContainer("High-Bald-Fade-with-Fringe.jpeg", "High Bald Fade"),
                            categoryContainer("Side-Swept-Bangs-Men.jpeg", "Side Swept"),
                            categoryContainer("Textured-Fringe.jpeg", "Textured Fringe"),
                          ],
                        ),
                      ),
                      Text("Select a barber", style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),),
                      SizedBox(height: 20,),
                      Container(
                        height: 400,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              createDocWidget("barber1.jpeg", "Susan Thomas"),
                              createDocWidget("barber2.jpeg", "Paul Barbara"),
                              createDocWidget("barber3.jpeg", "Steve Williams"),
                              createDocWidget("barber4.jpeg", "Don Serge"),
                              createDocWidget("barber5.jpeg", "John Stark"),
                              createDocWidget("barber6.jpeg", "William Harvey"),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
  Container categoryContainer(String imgName, String title)
  {
    return Container(
      width: 130,
      child: SingleChildScrollView(
        child: Column(
            children: <Widget>[
              Image.asset('assets/images/category/$imgName'),
              Text(
                "$title", style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 17
              ),
              )
            ],
          ),
      ),
    );
  }
  Container createDocWidget(String imgName, String docName)
  {
    return Container(
      child: InkWell(
        child: Container(

          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            color: docContentBgColor,
          ),
          child: Container(
            padding: EdgeInsets.all(7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/docprofile/$imgName'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(" $docName", style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),
                    SizedBox(height: 5,),
                    Container(
                      width: 250,
                      height: 50,
                      child: Text("A brief about the barber to be added here. This is more like an introduction about the barber", style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        onTap: openDocInfo,
      ),
    );
  }
  void openDocInfo()
  {
    Navigator.pushNamed(context, '/DocInfoPage');
  }

  void ToSignUp() {
    Navigator.pushNamed(context, '/SignUp');
  }
  void ToLogin() {
    signOut();
    Navigator.pushNamed(context, '/LoginNew');
  }
}

class pathPainter extends CustomPainter
{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = path2Color;

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width*0.3, 0);
    path.quadraticBezierTo(size.width*0.5, size.height*0.03, size.width*0.42, size.height*0.17);
    path.quadraticBezierTo(size.width*0.35, size.height*0.32, 0, size.height*0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}
