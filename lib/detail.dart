import 'dart:async';
import 'dart:math';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:url_launcher/url_launcher.dart';


String image;


class Detail extends StatefulWidget {

final String imagetype,url;

  @override
  _DetailPageState createState() => new _DetailPageState();

  Detail({this.imagetype,this.url}) {
    timeDilation = 1.0;
  }
}

class _DetailPageState extends State<Detail> {
  String text;
//url launcher method
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
  Widget displayText() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: new Text(text,
          softWrap: true,
          style: TextStyle(
            
            fontFamily: 'Josefin Sans',
            fontSize: 20.0,
            fontWeight: FontWeight.w200,
          )),
    );
  }

  Widget _raisedButton(String url) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: new RaisedButton(
        elevation: 10.0,
        color:const Color(0xFF6400df),
        splashColor: Colors.orange,
        shape: BeveledRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0)),
        onPressed: () {
          _launchInBrowser(url);
        },
        child: new Text(
          "See  your  Data",
          style: new TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.imagetype == 'google') {
      if (widget.url=='https://adssettings.google.com/authenticated') {
         text ='\nGoogle creates a profile of yourself based on the sites you visit, guessing your age, gender and interests and then use this data to serve you more relevant ads. Use this BUTTON to know how Google sees you on the internet.\n\n';
      }else if(widget.url=='https://accounts.google.com/signin/v2/sl/pwd?passive=1209600&osid=1&continue=https%3A%2F%2Fpasswords.google.com%2F&followup=https%3A%2F%2Fpasswords.google.com%2F&rart=ANgoxcelNBvce7ZncVKLmXw_Cu7CeJym7IOL2-YNuSHHNG02UmGEkygyw_95MWCFPzUIrtl9db9iIOhQ2iOQbiwME46B-qEJpg&authuser=0&flowName=GlifWebSignIn&flowEntry=ServiceLogin'){
        text='\nGoogle stores a list of usernames and passwords that you have typed in Google Chrome or Android for logging into various websites. They even have a website too where you can view all these passwords in plain text.\n\nNote:- You have to login to your google account see this data.';
      }else if(widget.url=='https://www.google.com/maps/timeline?pb'){
       text='\nYour Android phone or the Google Maps app on your iPhone is silently reporting your location and velocity (are you moving and if yes, how fast are you moving) back to Google servers. You can find the entire location history on the Google Maps website and you also have the option to export this data as KML files that can be viewed inside Google Earth or even Google Drive. If you want to know where have you been earlier, you can see each and every details.\nClick on the button below\n\n';
      }else if(widget.url=='https://myactivity.google.com/myactivity'){
        text='\nGoogle record every search term that you’ve ever typed into their search boxes. They keep a log of every Google ad that you have clicked on various websites,Want to see what google logs about you\n\n';
      }else if(widget.url=='https://myactivity.google.com/myactivity?restrict=vaa'){
      text='\nIf you are a Google Now user, you can see data of all your audio search queries.\n\nOK Google\n\n';
      }else if(widget.url=='https://www.youtube.com/feed/history'){
        text='\nYouTube record every search term that you’ve ever typed or spoken into their search boxes. And log of every youtube video you have ever watched. See your youtube history.\n\n';
      }else if(widget.url=='https://myaccount.google.com/device-activity'){
        text='\nWorried that someone else is using your Google account or it could be hacked? Open the activity report to see a log of every device that has recently connected into your Google account. You’ll also get to know the I.P. Addresses and the approximate geographic location. Unfortunately, you can’t remotely log out of a Google session.\n\nNote:- You have to login to that account to see the information.\n\n';
      }else if(widget.url=='https://takeout.google.com/settings/takeout'){
        text='\nDo you want to see your data that google has? you can download it in your mobile/computer, just go to the link and create an archive of the data.\n\n';
      }
      image = 'assets/image/google.jpg';
    } else if (widget.imagetype == 'fb') {
      if (widget.url=='https://www.facebook.com/settings?tab=your_facebook_information') {
        text='\nCheck what have you done so far in facebook, you can see what posts you like/comment and you are tagged in. \n\nNote:- To know this, Click on the button, then in "Your facebook information" section, click on Activity log. \n\n';
      }else if(widget.url=='https://www.facebook.com/your_information/'){
        text='\nCheck out what facebook knows about you, you can see your personal messages here, even your comments, posts,picture and videos, Your liked posts, your friends and unfriended people list.\n\nNote:- You have to login through your browser to see your data.\n\n ';
      }else if(widget.url=='https://www.facebook.com/dyi/?x=AdkU_sowbKQxwuhG&referrer=yfi_settings'){
        text='\nThe good news is, you can download your private data and can delete your account anytime, To download your data click on the button and create a downloadable file. You can select what you want to download, like your friends list, your messages/posts etc.\n\n';
      }
     
      image = 'assets/image/facebook.png';
    } else if (widget.imagetype == 'insta') {
      text = "\nAre you in the instagram, check out your data, it contains your posts, likes, comments etc.\n\nNote:- You have to login in the instagram through your browser to see your data.\n\n";
      image = 'assets/image/instagram.jpeg';
    } else if (widget.imagetype == 'twitter') {
      text = "\nTwitter is one of the most popular social networking sites, and if you want to know what twitter knows about you then just click on the button below and download the whole data about you.\n\nNote:- You have to login to your twitter account to see this information.\n\n";
      image = 'assets/image/twitter.jpg';
    }else if(widget.imagetype=='lost'){
      image='assets/image/mob.jpeg';
     text='\nCan’t locate your mobile phone? You can use the Google Device Manager to find your phone provided it is switched on and connected to the Internet. You can ring the device, see the location or even erase the phone content remotely. You can even find the IMEI Number of the lost phone from your Google Account.\n\n';
    }else if(widget.imagetype=='click'){
      image='assets/image/click.jpeg';
      text='\nYou must be wondering how website track us, let\'s see a live demo provide by an awesome website.\n\nNote:- Make sure you enable desktop site: checkbox into your chrome browser, cause it is not optimised for mobile, and They don\'t keep any kind of our data.\n\n';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = new Size(MediaQuery.of(context).size.width, 200.0);
    return new Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          new Stack(
            children: <Widget>[
              new DetailBody(
                  size: size, xOffset: 0, yOffset: 0, color: Colors.red),
              new Opacity(
                opacity: 0.9,
                child: new DetailBody(
                  size: size,
                  xOffset: 50,
                  yOffset: 10,
                ),
              ),
            ],
          ),
          displayText(),
          _raisedButton(widget.url),
        ],
      ),
    );
  }
}

class DetailBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  DetailBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _DetailBodyState();
  }
}

class _DetailBodyState extends State<DetailBody> with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
            i.toDouble() + widget.xOffset,
            sin((animationController.value * 360 - i) %
                        360 *
                        Vector.degrees2Radians) *
                    20 +
                50 +
                widget.yOffset));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
              child: widget.color == null
                  ? Image.asset(
                      image,
                      width: widget.size.width,
                      height: widget.size.height,
                      fit: BoxFit.cover,
                    )
                  : new Container(
                      width: widget.size.width,
                      height: widget.size.height,
                      color: widget.color,
                    ),
              clipper: new WaveClipper(animationController.value, animList1),
            ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
