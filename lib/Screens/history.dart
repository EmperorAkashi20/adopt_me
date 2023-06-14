import 'package:adopt_me/Providers/history_provider.dart';
import 'package:adopt_me/Widgets/pet_card_history.dart';
import 'package:adopt_me/Widgets/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyPvd = ref.watch(historyProvider);
    Widget child;
    if (historyPvd.hasData) {
      child = StreamBuilder(
          stream: historyPvd.data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              var docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs?.length,
                itemBuilder: (context, index) {
                  return PetCardHistory(
                    docs: docs,
                    index: index,
                  );
                },
              );
            } else {
              return const ShimmerLoader();
            }
          });
    } else if (historyPvd.isLoading) {
      child = const Text("Loading");
    } else if (historyPvd.hasError) {
      child = Text(historyPvd.error);
    } else {
      child = const Text('No data');
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text(
            'Your Adoption History',
          ),
        ),
        body: child);
  }
}
