import 'package:flutter/material.dart';
import 'package:gerenciador_loja/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(
                  color: Colors.white54,
                ),
              ),
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Clientes"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text("Produtos"),
            ),
          ],
          onTap: (page) {
            _pageController.animateToPage(
              page,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          },
        ),
      ),
      body: SafeArea(
        child: PageView(
//        physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (activePage) {
            setState(() {
              _page = activePage;
            });
          },
          children: <Widget>[
            UsersTab(),
            Container(color: Colors.yellow),
            Container(color: Colors.green),
          ],
        ),
      ),
    );
  }
}
