library home_views;

import 'package:adopt_me/Screens/history.dart';
import 'package:adopt_me/Screens/search.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../Providers/add_pet_provider.dart';
import '../../Providers/birds_data_provider.dart';
import '../../Providers/cats_data_provider.dart';
import '../../Providers/dogs_data_provider.dart';
import '../../Providers/home_provider.dart';
import '../../Widgets/pet_card.dart';
import '../../Widgets/shimmer.dart';
import '../../Widgets/theme_fab.dart';

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
      SearchView(),
      HistoryView(),
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
      body: Center(
        child: widgetOptions.elementAt(homePvd.currentTabIndex),
      ),
    );
  }
}
