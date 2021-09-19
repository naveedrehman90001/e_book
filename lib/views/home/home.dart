import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_book/controllers/authController.dart';
import 'package:e_book/utils/exports.dart';
import 'package:e_book/views/bookDetail/bookDetailScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser;
  final _firebaseAuth = FirebaseAuth.instance;

  final _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Book'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                try {
                  _authController.logoOutFromGoogle();
                  await _firebaseAuth.signOut().whenComplete(() async {
                    await storeInfo(0);
                    Get.offAll(const LoginScreen());
                  });
                } on FirebaseAuthException catch (e) {
                  Get.snackbar(
                    'Error while creating Account',
                    e.message!,
                    borderRadius: 5,
                  );
                }
              },
              icon: const Icon(
                Icons.logout_outlined,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('books').snapshots(),
          builder: (context, querySnapshot) {
            if (!querySnapshot.hasData) {
              return SizedBox(
                height: Get.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              );
            }
            final books = querySnapshot.data!.docs;
            return Container(
              margin: const EdgeInsets.all(10),
              color: Colors.transparent,
              child: GridView.builder(
                  itemCount: books.length,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: Get.height * 0.2,
                    mainAxisExtent: Get.height * 0.35,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Get.to(
                        BookDetailScreen(
                          bookImage: books[index]["bookImage"],
                          title: books[index]['title'],
                          author: books[index]['author'],
                          description: books[index]['description'],
                          bookUrl: books[index]['bookUrl'],
                          id: books[index].id,
                        ),
                      ),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          height: Get.height * 0.35,
                          // color: Colors.red,
                          child: LayoutBuilder(builder: (context, constrains) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.network(
                                      books[index]['bookImage'],
                                      fit: BoxFit.cover,
                                      height: Get.height * 0.25,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () {
                                          //TODO add to favorite
                                        },
                                        child: const Icon(
                                          Icons.favorite_border_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.005),
                                Text(books[index]['title'],
                                    style: const TextStyle(fontSize: 10)),
                                Text(books[index]['author'],
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 08)),
                              ],
                            );
                          }),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
