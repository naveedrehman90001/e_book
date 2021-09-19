import 'package:e_book/utils/exports.dart';

import '../../main.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Books'),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(favorite).listenable(),
        builder: (context, box, _) {
          return Container();
        },
      ),

      // ListView.builder(
      //   itemCount: 4,
      //   itemBuilder: (context, index) {
      //     return Column(
      //       children: [
      //         SizedBox(height: Get.height * 0.01),
      //         Container(
      //           height: Get.height * 0.18,
      //           margin: kDefaultPadding,
      //           decoration: BoxDecoration(
      //             boxShadow: [
      //               BoxShadow(
      //                 color: Colors.grey.withOpacity(0.2),
      //               ),
      //             ],
      //           ),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Container(
      //                 height: Get.height * 0.18,
      //                 width: Get.height * 0.18,
      //                 color: Colors.red,
      //                 child: const Text('Book Image'),
      //               ),
      //               SizedBox(width: Get.width * 0.03),
      //               Expanded(
      //                 child: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: const [
      //                     Text('Title'),
      //                     Text('Author Name'),
      //                   ],
      //                 ),
      //               ),
      //               IconButton(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.favorite, color: Colors.red)),
      //             ],
      //           ),
      //         ),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
