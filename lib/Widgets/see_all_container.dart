import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Model_data/tatto_model_data.dart';

class SeeAllContainer extends StatefulWidget {
  final image;
  Function fnc;

  SeeAllContainer({Key? key, required this.image, required this.fnc})
      : super(key: key);

  @override
  State<SeeAllContainer> createState() => _SeeAllContainerState();
}

class _SeeAllContainerState extends State<SeeAllContainer> {
  var chk;
  bool isLoading = false;

  ArtistData? artistData;
  TattoModelData? tattoData;
  List<TattoModelData> tattolist = [];

  Future getImges() async {
    setState(() {
      isLoading = true;
    });

    QuerySnapshot rest =
        await FirebaseFirestore.instance.collection('ArtistData').get();

    QuerySnapshot res =
        await FirebaseFirestore.instance.collection('TattoosData').get();

    if (res.docs.isNotEmpty) {
      setState(() {
        tattoData = TattoModelData.fromMap(
            res.docs.first.data() as Map<String, dynamic>);
      });
    }
    artistData =
        ArtistData.fromMap(rest.docs.first.data() as Map<String, dynamic>);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getImges();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getImges();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return isLoading
        ? Container()
        : InkWell(
            onTap: () {
              widget.fnc();
            },
            child: Stack(
              children: [
                Container(
                  height: screenHight / 3,
                  width: screenWidth / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    image: DecorationImage(
                        image: NetworkImage(widget.image), fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          );
  }
}
