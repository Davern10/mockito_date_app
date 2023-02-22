import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito_dating_app/ui/global_widgets/circular_progress.dart';
import 'package:mockito_dating_app/ui/utils/colors.dart';
import 'package:mockito_dating_app/ui/utils/responsive.dart';

class GalleryTab extends StatefulWidget {
  const GalleryTab({Key? key}) : super(key: key);

  @override
  State<GalleryTab> createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  List<String> ids = [];
  bool loading = false;

  //? INIT
  @override
  void initState() {
    ids = [];
    loading = true;
    _loadImgageIds();
    super.initState();
  }

  //? CHARGE IMAGES API CONNECT
  void _loadImgageIds() async {
    final response = await http.get(
      Uri.parse('https://picsum.photos/v2/list'),
    );
    final json = jsonDecode(response.body);
    List<String> _ids = [];
    for (var image in json) {
      _ids.add(image['id']);
    }
    setState(() {
      loading = false;
      ids = _ids;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final wp = responsive.wp(100);
    final hp = responsive.hp(100);
    final wImage = wp * 0.334;
    if (loading) {
      //? CIRCULAR PROGRESS
      return CircularProgress(hp: hp, wp: wp);
    }
    return Center(
      child: Container(
        color: invColor,
        height: hp,
        width: wp,
        child: Column(
          children: [
            Flexible(
              child: GridView.builder(
                itemCount: ids.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {
                    //? IMAGE LIST PAGE CHARGE
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ImagePage(
                            ids: ids[index],
                            wImage: wp.toInt(),
                          );
                        },
                      ),
                    );
                  },
                  //? IMAGE ID VIEW
                  child: Image.network(
                    'https://picsum.photos/id/${ids[index]}/${wImage.toInt()}/${wImage.toInt()}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({
    Key? key,
    required this.ids,
    required this.wImage,
  }) : super(key: key);

  final String ids;
  final int wImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primColor,
      ),
      body: Container(
        color: invColor,
        child: Center(
          child: Image.network(
            'https://picsum.photos/id/$ids/$wImage/$wImage',
          ),
        ),
      ),
    );
  }
}
