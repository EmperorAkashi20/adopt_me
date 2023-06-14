import 'package:adopt_me/Providers/search_provider.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPvd = ref.watch(searchProvider);
    Widget child;
    if (searchPvd.hasData &&
        searchPvd.searchController.text.trim().isNotEmpty) {
      child = Consumer(builder: (context, ref, child) {
        return const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            ),
            _DogsSearchData(),
          ],
        );
      });
    } else if (searchPvd.isLoading) {
      child = const Center(child: CircularProgressIndicator());
    } else if (searchPvd.hasError) {
      child = Text(searchPvd.error);
    } else {
      child = const Center(child: Text('No Recent Searches'));
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const _SearchWidget(),
      ),
      body: child,
    );
  }
}

class _DogsSearchData extends ConsumerWidget {
  const _DogsSearchData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPvd = ref.watch(searchProvider);
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(
          leading: CircleAvatar(
              radius: 30,
              backgroundImage:
                  NetworkImage(searchPvd.data1?.elementAt(index)['image'])),
          title: Text(searchPvd.data1?.elementAt(index)['name']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(searchPvd.data1?.elementAt(index)['breed'])
            ],
          ),
        ),
        childCount: searchPvd.data1?.length,
      ),
    );
  }
}

class _SearchWidget extends ConsumerWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchPvd = ref.watch(searchProvider);
    final textEditingCtrl = ref.read(searchProvider).searchController;
    final searchFocusNode = ref.read(searchProvider).searchFocusNode;
    return SizedBox(
      height: 46,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0XFFEAEAEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          controller: textEditingCtrl,
          autocorrect: false,
          autofocus: true,
          focusNode: searchFocusNode,
          cursorColor: Colors.black,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            EasyDebounce.debounce(
              'search-debouncer',
              const Duration(milliseconds: 500),
              () {
                searchPvd.getSearchData(value);
              },
            );
          },
        ),
      ),
    );
  }
}
