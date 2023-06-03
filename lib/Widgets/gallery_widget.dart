import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/see_al_screen_gallery.dart';
import 'package:tatto_app/Bottom_navigaion/Pages/see_all_screen_home.dart';
import 'package:tatto_app/Model_data/artist_data.dart';
import 'package:tatto_app/Widgets/gallery_screen_container.dart';

import '../Bottom_navigaion/Pages/appointment_pages/appointment_one.dart';
import '../Model_data/tatto_model_data.dart';

class GalleryWidget extends StatefulWidget {
  GalleryWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ArtistData data;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  List<TattoModelData> currentAristTatto = [];
  bool isLoading = false;

  Future getArtistTatto() async {
    setState(() {
      isLoading = true;
    });
    for (var i in widget.data.tatto!) {
      QuerySnapshot res = await FirebaseFirestore.instance
          .collection('TattoosData')
          .where('id', isEqualTo: i)
          .get();
      if (res.docs.isNotEmpty) {
        TattoModelData tattodata = TattoModelData.fromMap(
            res.docs.first.data() as Map<String, dynamic>);
        currentAristTatto.add(tattodata);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getArtistTatto();
  }

  @override
  Widget build(BuildContext context) {
    var screenHight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "${widget.data.name}",
                style: GoogleFonts.oswald(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeeAllScreenGallery(
                        data: widget.data, tattoData: currentAristTatto[0],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: screenHight / 18,
                  width: screenWidth / 3.4,
                  color: Color(0xffE44245),
                  child: Center(
                    child: Text(
                      'See All',
                      style: GoogleFonts.oswald(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        GridView.builder(
            physics: ScrollPhysics(),
            itemCount: currentAristTatto.isEmpty
                ? 0
                : currentAristTatto.length > 4
                    ? 4
                    : currentAristTatto.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (BuildContext ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 13),
                child: Hero(
                  tag: 'Artist Data two',
                  child: Gallery_Screen_Container(
                    tattoData: currentAristTatto[index],
                    data: widget.data,
                  ),
                ),
              );
            }),
        SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppointmentOne(),
              ),
            );
          },
          child: Container(
            height: screenHight / 14,
            width: screenWidth / 1.2,
            color: Color(0xffE44245),
            child: Center(
              child: Text(
                'Schedule A meeting',
                style: GoogleFonts.oswald(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
