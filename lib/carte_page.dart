import 'package:castorstatistics/discover_page.dart';
import 'package:castorstatistics/widgets/Service_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';



class CartePage extends StatefulWidget {
  const CartePage({
    Key? key,
  }) : super(key: key);
  _CartePageState createState() => _CartePageState();
}

class _CartePageState extends State<CartePage> {
  final PopupController _popupController = PopupController();
  List<Service> services = [];
  late List<Marker> markers;
  List<Service> myList = [];
  late int pointIndex;
  final List points = [
    LatLng(48.379321, -4.492822),
    LatLng(48.378174, -4.484746),
  ];

  @override
  void initState() {
    Future<List<Service>> _getServices() async {
      Uri url = Uri.parse('http://10.0.2.2/API_Carte.php');
      var diaData = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
      );
      var jsonData = jsonDecode(diaData.body);
      for (var serv in jsonData) {
        Service service = Service(
            serv["ville"],
            double.parse(serv["latitude"]),
            double.parse(serv["longitude"]),
            int.parse(serv["id"]),
            serv["texte"]);
        services.add(service);
      }
      return services;
    }

    void sortirServ() async {
      markers = [];
      myList = await _getServices();
      setState(() {
        myList.forEach((element) {
          markers.add(Marker(
            anchorPos: AnchorPos.align(AnchorAlign.center),
            height: 30,
            width: 30,
            point: LatLng(element.Latitude, element.Longitude),
            builder: (ctx) => Icon(Icons.pin_drop),
          ));
        });
      });
    }

    @override
    void initState() {
      super.initState();
      initState();
    }

    pointIndex = 0;
    sortirServ();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
      backgroundColor: Color(0xff121421),
        title: Text("Carte",
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 40.w,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato')),
        automaticallyImplyLeading: true,
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => retour(),
        )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          initState();
        },
      ),
      body: FlutterMap(
        options: MapOptions(
          center: points[0],
          zoom: 5,
          plugins: [
            MarkerClusterPlugin(),
          ],

        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            disableClusteringAtZoom: 6,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.greenAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            popupOptions: PopupOptions(
                popupSnap: PopupSnap.markerTop,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                  width: 200,
                  height: 100,
                  color: Colors.greenAccent[600],
                  child: GestureDetector(
                    onTap: () => debugPrint("Popup tap!"),
                    child: Text(
                      "",
                    ),
                  ),
                )),
            builder: (context, markers) {
              return FloatingActionButton(
                backgroundColor:Colors.greenAccent.shade400 ,
                child: Text((((markers.length)/2).toInt().toString()),
                    style: TextStyle(
                    color: Color(0xff121421))),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }


  void retour() {
    Get.to(()=> DiscoverPage(), transition: Transition.rightToLeft);
  }
}
