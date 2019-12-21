import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_stream_player/audio_stream_player.dart';
import 'package:volume/volume.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rathumkarafm/my_flutter_app_icons.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //Creating audio player object.
  AudioStreamPlayer audioPlayer;
  final String url = 'http://radio.rathumakara.com:8000/rathumakara.mp3';

  void initAudioPlayer(){
    audioPlayer = AudioStreamPlayer();
  }

  //Creating AudioManager object
  AudioManager audioManager;
  int maxVol = 0;

  bool _isPaused = true;
  int volume = 0;
  Icon icon = Icon(Icons.play_arrow);

  @override
  void initState(){
    super.initState();
    audioManager = AudioManager.STREAM_MUSIC;
    lookForInternet();
    initAudioPlayer();
    initPlatformState();
    updateVolumes();
  }

  @override
  void dispose(){
    super.dispose();
    stop();
  }

  void lookForInternet() async {
    try{
      final result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        //Connection is available
        //Do nothing
      }
    } on SocketException catch(_){
      //No connection is available
      //showing an alert dialog
      _connectionNotAvailable(context);
    }
  }

  Future<void> initPlatformState() async{
    //volume part
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
  }

  updateVolumes() async{
    //get max volume
    maxVol = await Volume.getMaxVol;
    //get current volume
    volume = await Volume.getVol;
  }

  //Setting the volume
  setVolume(int vol) async{
    await Volume.setVol(vol);
  }

  //Player Stop
  Future<void> stop() async{
    await audioPlayer.stop();
  }
  //Playing method.
  Future<void> play() async {
    //Checking weather the internet connection is available or  not...
    try{
      final result = await InternetAddress.lookup('google.com');
      if(result.isNotEmpty && result[0].rawAddress.isNotEmpty){
        //Connection is available
        await audioPlayer.play(url);
        updateVolumes();
      }
    } on SocketException catch(_){
      //No connection is available
      //showing an alert dialog
      _connectionNotAvailable(context);
      stop();
      setState(() {
        _isPaused = true;
        icon = Icon(Icons.play_arrow);
      });
    }

  }

  //error alert dialog
  void _connectionNotAvailable(BuildContext context) {
    var alertDialog = AlertDialog(
      //backgroundColor: Color.fromRGBO(100, 100, 100, 1),
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0,
      title: Text(
        'Error!',
        textAlign: TextAlign.left,
        textScaleFactor: 1,
        style: TextStyle(color: Colors.white,fontSize: 22),
      ),
      content: Text(
        'No Internet Connection Found.',
        textAlign: TextAlign.left,
        textScaleFactor: 1,
        style: TextStyle(color: Colors.white,fontSize: 12),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      actions: <Widget>[
        FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.grey,
            onPressed: (){
              Navigator.pop(context);
              setState(() {
                icon = Icon(Icons.play_arrow);
                _isPaused = true;
              });
            },
            child: Text('Ok',style: TextStyle(color: Colors.white,fontSize: 13),)
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double tScale = 0.65+(MediaQuery.of(context).textScaleFactor)/4.5;

    void _info(BuildContext context) {

      //Launch URL method
      _launchURL(String url) async {
        if(await canLaunch(url)){
          await launch(url);
        }else{
          //Error
        }
      }

      final double _iconSize = 25;

      var alertDialog = AlertDialog(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 10,
        content: Container(
          width: width*0.9,
          height: height*0.5,
          margin: EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/icon.png',width: width*0.4,height: width*0.4,),
              Text("1.0\n",
                style: TextStyle(fontSize: width*0.045, color:Colors.white),
                textAlign: TextAlign.center,
                textScaleFactor: tScale,
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.language,color: Colors.white,size: _iconSize,),
                    onTap: () {
                      _launchURL('https://rathumakara.com');
                    },
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    child: Icon(Icons.email, color: Colors.white,size: _iconSize,),
                    onTap: (){
                      _launchURL('mailto:info@rathumakara.com');
                    },
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    child: Icon(Icons.phone, color: Colors.white,size: _iconSize,),
                    onTap: (){
                      _launchURL('tel:+94719361944');
                    }
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    child: Icon(SMIcons.twitter,color: Colors.white, size: _iconSize-3,),
                    onTap: (){
                      _launchURL('https://twitter.com/RathuMakaraFM_');
                    },
                  ),
                  SizedBox(width: 7,),
                  InkWell(
                    child: Icon(SMIcons.instagram, color: Colors.white,size: _iconSize-5,),
                    onTap: (){
                      _launchURL('https://instagram.com/rathumakarafm');
                    },
                  ),
                  SizedBox(width: 7,),
                  InkWell(
                    child: Icon(SMIcons.facebook, color: Colors.white,size: _iconSize-5,),
                    onTap: (){
                      _launchURL('https://facebook.com/rathumakarafm');
                    },
                  ),
                ],
              ),
              Expanded(child: Container(),flex: 1,),
              Text(
                'Developed by Sadisha Nimsara',
                textScaleFactor: tScale,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: width*0.04,color: Colors.white),
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialog;
          });
    }

    return Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        appBar:AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          title: Text("Rathumakara FM",style: TextStyle(color: Colors.white,fontSize: width*0.1),textAlign: TextAlign.center,textScaleFactor: tScale,),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              tooltip: 'Info',
              highlightColor: Colors.transparent,
              iconSize: 2,
              icon: Icon(CupertinoIcons.info,color: Colors.white,size: 25),
              onPressed: (){
                //Showing info.
                _info(context);
              },
            )
          ],
        ),
        body: Container(
          width: width,
          height: height*0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 10,),
              Container(
                  width: width*0.5,
                  height: width*0.5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(17),color: Colors.transparent,),
                  child: Image.asset('images/icon.png'),
              ),
              Text(
                'NOW PLAYING',
                textAlign: TextAlign.center,
                textScaleFactor: tScale,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: width*0.043,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(width: 10,),
                  Icon(CupertinoIcons.volume_up,color: Colors.white),
                  Expanded(
                    child: Slider(
                      value: volume/1.0,
                      activeColor: Theme.of(context).primaryColor,
                      //label: 'Volume: '+'${((volume/15)*100).toInt()}',

                      min: 0.0,
                      max: maxVol/1.0,
                      onChanged: (double val){
                        setState(() {
                          volume = val.toInt();
                          setVolume(val.toInt());
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  border: Border.all(color: Colors.white, width: 0.7,)
                ),
                child: IconButton(
                    tooltip: _isPaused ? 'Play' : 'Pause',
                    icon: icon,
                    iconSize: 55,
                    color: Colors.white,
                    onPressed: (){
                      if(_isPaused){
                        setState(() {
                          //setting _isPaused to false and change the icon
                          _isPaused = false;
                          icon = Icon(Icons.pause);
                        });
                        play();
                      }else{
                        setState(() {
                          //setting _isPaused to true and change the icon
                          _isPaused = true;
                          icon = Icon(Icons.play_arrow);
                        });
                        stop();
                      }
                    }
                ),
              ),
              Expanded(flex: 1,child: Container(),),
              Divider(
                height: 0,
                thickness: 0.5,
                color: Colors.white,
              ),
              SizedBox(height: 15,),
              Text("The First Open Mic Online Radio Channel In Sri Lanka.\nrathumakara.com",
                style: TextStyle(fontSize: width*0.043, color:Colors.white),
                textAlign: TextAlign.center,
                textScaleFactor: tScale,
              ),
              SizedBox(height: 15)
            ],
          ),
        )
    );
  }
}