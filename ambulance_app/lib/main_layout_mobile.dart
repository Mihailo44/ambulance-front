// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class ScaffoldWithBottom extends StatelessWidget{
//   const ScaffoldWithBottom({required this.navigationShell,super.key});

//   final StatefulNavigationShell navigationShell;
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
        
//         title: const Text(
//           "Zovi Hitnu",
//           style: TextStyle(
//             fontSize: 23.0,
//             fontWeight: FontWeight.w500,
//           ),
//         ),

//         actions: [
//          IconButton(
//             onPressed: (){}, 
//             icon: const Icon(Icons.menu),),
//         ],

//       ),
//       body: navigationShell, // Displays the current tab's content
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: navigationShell.currentIndex,
//           onTap: (index) {
//             // Switch tabs when the user taps on a BottomNavigationBar item
//             navigationShell.goBranch(index);
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'Feed',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.shop),
//               label: 'Shop',
//             ),
//           ],
//         ),
//     );
//   }
// }