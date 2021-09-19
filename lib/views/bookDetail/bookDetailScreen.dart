import 'package:dio/dio.dart';
import 'package:e_book/models/favoriteModel.dart';
import 'package:e_book/utils/colors.dart';
import 'package:e_book/utils/exports.dart';
import 'package:path_provider/path_provider.dart';

import '../../main.dart';

class BookDetailScreen extends StatefulWidget {
  final String? bookImage, title, author, description, id, bookUrl;

  BookDetailScreen({
    Key? key,
    this.bookImage,
    this.title,
    this.author,
    this.description,
    this.id,
    this.bookUrl,
  }) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool isDownloading = false;
  String? bytesDownload;
  late FavoriteModel favoriteModel;
  double _percentage = 0;
  var percentage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: kDefaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: Get.height * 0.3,
                      width: Get.width * 0.4,
                      // color: Colors.orange,
                      child: Image.network(
                        widget.bookImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // SizedBox(width: Get.width * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            TextButton(
                                onPressed: () {
                                  //TODO Implement book reading functionality
                                },
                                child: Text('Read')),
                            TextButton(
                                onPressed: () async {
                                  //TODO Implement book download functionality
                                  setState(() {
                                    isDownloading = !isDownloading;
                                  });
                                  var dir =
                                      await getApplicationDocumentsDirectory();
                                  Dio dio = Dio();
                                  dio.download(widget.bookUrl!,
                                      '${dir.path} ${widget.bookUrl}',
                                      onReceiveProgress:
                                          (actualBytes, totalBytes) {
                                    percentage = actualBytes / totalBytes * 100;
                                    _percentage = percentage / 100;
                                    setState(() {
                                      bytesDownload = '${percentage.floor()} %';
                                    });
                                  });
                                  // Get.defaultDialog(
                                  //     title: widget.title!,
                                  //     // middleText: "Hello world!",
                                  //     backgroundColor: AppColors.kPrimaryColor,
                                  //     titleStyle:
                                  //         TextStyle(color: Colors.white),
                                  //     // middleTextStyle:
                                  //     //     TextStyle(color: Colors.white),
                                  //     textCancel: "Cancel",
                                  //     cancelTextColor: Colors.white,
                                  //     // confirmTextColor: Colors.white,
                                  //     buttonColor: Colors.red,
                                  //     barrierDismissible: false,
                                  //     radius: 10,
                                  //     content: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.end,
                                  //       children: [
                                  //         LinearProgressIndicator(
                                  //           value: _percentage,
                                  //           // backgroundColor: Colors.grey,
                                  //           // color: Colors.red,
                                  //         ),
                                  //         Text(bytesDownload!),
                                  //       ],
                                  //     ));
                                },
                                child: !isDownloading
                                    ? Text('Download')
                                    : percentage == 100
                                        ? Text('go to d')
                                        : Column(
                                            children: <Widget>[
                                              SizedBox(
                                                height: 40,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      child:
                                                          new CircularProgressIndicator(
                                                        value: _percentage,
                                                        color: AppColors
                                                            .kPrimaryColor,
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 0,
                                                        left: 0,
                                                        right: 0,
                                                        top: 15,
                                                        child: Text(
                                                          bytesDownload ?? '0%',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 10,

                                                            // color: AppColors.kPrimaryColor,
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share_outlined)),
                            ValueListenableBuilder<Box<String>>(
                              valueListenable:
                                  Hive.box<String>(favoriteId).listenable(),
                              builder: (context, box, _) {
                                var favoriteList =
                                    box.values.toList().cast<String>();
                                // List favoriteList = List.from(box.values);
                                return IconButton(
                                    onPressed: () {
                                      //TODO add to favorite box
                                      // Hive.box(favorite).put(key, value);
                                      // favoriteList.contains(widget.id)
                                      //     ? box.delete(key)
                                      //     //
                                      //     : {
                                      //         box.put(key, widget.id!),
                                      //         favoriteModel = FavoriteModel(),
                                      //         favoriteModel.author = widget.author,
                                      //         favoriteModel.title = widget.title,
                                      //         favoriteModel.id = widget.id,
                                      //         favoriteModel.bookImage =
                                      //             widget.bookImage,
                                      //       };
                                    },
                                    icon: Icon(
                                      favoriteList.contains(widget.id)
                                          ? Icons.favorite
                                          : Icons.favorite_border_outlined,
                                    ));
                              },
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.mic_outlined)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: Get.height * 0.03),
                Text(
                  widget.title ?? '',
                  style: kTitleTextStyle,
                ),
                SizedBox(height: Get.height * 0.01),
                Text(
                  widget.description ?? '',
                  style: kSubTitleTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
