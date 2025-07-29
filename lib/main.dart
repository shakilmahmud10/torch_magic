import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:torch_light/torch_light.dart';
import 'package:torch_magic/pages/ColorsPage.dart';
import 'package:torch_magic/pages/DirectionPage.dart';
import 'package:torch_magic/pages/PoliceSignal.dart';
import 'package:torch_magic/pages/TextPage.dart';
import 'package:torch_magic/pages/Wait.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(MyApp());
}


// void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    showInitialNotifications();
  }

  void showInitialNotifications() async{
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'channel_Id_1',
        'channel_Name_1',
        importance: Importance.max,
        priority: Priority.high
    );

    const AndroidNotificationDetails androidDetails2 = AndroidNotificationDetails(
        'channel_Id_2',
        'channel_Name_2',
        importance: Importance.max,
        priority: Priority.high
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidDetails);
    const NotificationDetails notificationDetails2 = NotificationDetails(android: androidDetails2);

    await flutterLocalNotificationsPlugin.show(
        0,
        'Flash Magic',
        'Thanks for using Flash Magic Apps',
        notificationDetails
    );

    await flutterLocalNotificationsPlugin.show(
      1,
      '📢 App Update',
      'New features have been added. Check now!',
      notificationDetails2,
    );

  }




  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashLight(),
    );
  }
}

class FlashLight extends StatefulWidget {
  const FlashLight({super.key});

  @override
  State<FlashLight> createState() => _FlashLightState();
}

class _FlashLightState extends State<FlashLight> {

  bool isTorchOn = false;
  bool isSOSrunning = false;

  Future toggleTorch() async {
    try {
      if (isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        isTorchOn = !isTorchOn;
      });
    } catch (e) {
      print("Torch Error: ${e}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Torch not available: ${e}")),
      );
    }
  }

  Future startSOS() async {
    if (isSOSrunning){
      setState(() {
        isSOSrunning = false;
      });
      await TorchLight.disableTorch();
      return;
    }

    setState(() {
      isSOSrunning = true;
    });


    const int sosCycle = 5;
    for (int i = 0; i < sosCycle; i++) {
      if(!isSOSrunning) break;

      for (int j = 0; j < 3; j++) {
        if(!isSOSrunning) break;

        await TorchLight.enableTorch();
        await Future.delayed(Duration(milliseconds: 300));
        await TorchLight.disableTorch();
        await Future.delayed(Duration(milliseconds: 300));
      }

      if(!isSOSrunning) break;
      await Future.delayed(Duration(seconds: 3));
    }

    try {
      await TorchLight.disableTorch();
    } catch (_) {
      // print("SOS Error on final off: $e");
    }
    setState(() {
      isSOSrunning = false;
    });

    print("Testing Successful");


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flashlight"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 1.5,
              child: ElevatedButton.icon(
                onPressed: toggleTorch,
                style: ElevatedButton.styleFrom(
                  foregroundColor:  isTorchOn ? Colors.grey :Colors.blueAccent,
                  backgroundColor: isTorchOn ? Colors.white54: Colors.white,
                    padding:EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)
                  ),
                  // elevation:
                ),
                icon:Icon(isTorchOn ? Icons.flashlight_on : Icons.flashlight_off),
                label: Text(isTorchOn ? "Turn Off" : "Power on"),
              ),
            ),
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton.icon(
                    onPressed: startSOS,
                    style: ElevatedButton.styleFrom(
                        foregroundColor: isSOSrunning ? Colors.white: Colors.blueAccent,
                        backgroundColor: isSOSrunning ? Colors.red: Colors.white,
                        padding:EdgeInsets.symmetric(horizontal: 32, vertical: 12)
                    ),
                    icon: Icon(isSOSrunning
                        ? Icons.health_and_safety_outlined
                        : Icons.health_and_safety_sharp),
                    label: Text(isSOSrunning ? "Stop SOS" : "SOS")
                ),
                SizedBox(width: 20),

                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>PoliceSignal()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.local_fire_department_rounded),
                    label: Text("Signal"),
                ),
                SizedBox(width: 20),

                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>ColorsPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.color_lens_rounded),
                    label: Text("Color"),
                ),
              ],
            ),            
            SizedBox(height: 5),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>TextPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.phone_android_sharp),
                    label: Text("Text")
                ),
                SizedBox(width: 20),

                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>Wait()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.directions_car_filled),
                    label: Text("Wait")
                ),
                SizedBox(width: 20),


                ElevatedButton.icon(
                    onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) =>DirectionPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blueAccent,
                      backgroundColor: Colors.white,
                    ),
                    icon: Icon(Icons.double_arrow_outlined),
                    label: Text("Direction")
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}