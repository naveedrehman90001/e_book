import 'package:e_book/utils/exports.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List screens = [
    HomeScreen(),
    FavoriteScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.kPrimaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            tooltip: 'Home',
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            tooltip: 'Favorite',
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            tooltip: 'Search',
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            tooltip: 'Profile',
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
