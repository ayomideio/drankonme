import 'package:dranksonme/constants/index.dart';
import 'package:dranksonme/navigation/homescreen.dart';
import 'package:flutter/material.dart';

class TaskBar extends StatefulWidget {
  @override
  _TaskBarState createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      
      Scaffold(
        // appBar: AppBar(
        //   title: Text('Bottom App Bar Example'),
        // ),
        body: HomeScreen()
        ,
        bottomNavigationBar: 
        ClipRRect(
           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          child:  BottomAppBar(
          color: ColorStyles.primaryButtonColor, // Background color of the bottom app bar
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0,Icons.home, 'assets/vectors/home.png',
               'Home'),
              _buildNavItem(1, Icons.search,'assets/vectors/home.png', 'Search'),
              _buildNavItem(2, Icons.person,'assets/vectors/home.png', 'Profile'),
            ],
          ),
        ),
       )
       
        
     
    );
  }

Widget _buildNavItem(int index,IconData  icon, String? image, String label) {
  Color color = _currentIndex == index ? Colors.white : Colors.grey; // Color for selected and unselected items
  return Expanded(
    child: InkWell(
      onTap: () => _onTabTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Padding(padding: EdgeInsets.only(top: 20),
          
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              label=='Home'?
              Image.asset(image.toString(),color: color,
              height: 25,):
            Icon(icon, color: color),
          SizedBox(width: 4), // Adding some space between icon and text
          Text(
            label,
            style: TextStyle(color: color),
          ),
          ],),),
          
        ],
      ),
    ),
  );
}

}
// class TaskBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Bottom App Bar Example'),
//         ),
//         body: Center(
//           child: Text('Content goes here'),
//         ),
//         bottomNavigationBar: BottomAppBar(
//           shape: CircularNotchedRectangle(),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.home),
//                 onPressed: () {
//                   // Handle home button press
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.search),
//                 onPressed: () {
//                   // Handle search button press
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.person),
//                 onPressed: () {
//                   // Handle profile button press
//                 },
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.add),
//           onPressed: () {
//             // Handle FAB press
//           },
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
// }