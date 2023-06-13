library home_views;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Providers/add_pet_provider.dart';
import '../../Providers/birds_data_provider.dart';
import '../../Providers/cats_data_provider.dart';
import '../../Providers/dogs_data_provider.dart';
import '../../Providers/home_provider.dart';
import '../../Widgets/pet_card.dart';

part 'tabbar_view.dart';

part 'home_view.dart';

part 'add_pet_sheet.dart';

part 'dogs_view.dart';

part 'cats_view.dart';

part 'birds_view.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const List<Widget> widgetOptions = <Widget>[
      _HomeTab(),
      Text(
        'Index 1: Business',
      ),
      Text(
        'Index 2: School',
      ),
    ];
    final homePvd = ref.watch(homeProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0XFFEEBD3E),
        currentIndex: homePvd.currentTabIndex,
        onTap: (value) => homePvd.onItemTapped(value),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(homePvd.currentTabIndex),
      ),
    );
  }
}
