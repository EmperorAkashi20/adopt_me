part of home_views;

class _BirdsView extends ConsumerWidget {
  const _BirdsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final birdsDataPvd = ref.watch(birdsDataProvider);
    Widget child;
    if (birdsDataPvd.hasData) {
      child = StreamBuilder(
          stream: birdsDataPvd.data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              var docs = snapshot.data?.docs;
              return ListView.builder(
                itemCount: docs?.length,
                itemBuilder: (context, index) {
                  return PetCard(
                    docs: docs,
                    index: index,
                  );
                },
              );
            } else {
              return const ShimmerLoader();
            }
          });
    } else if (birdsDataPvd.isLoading) {
      child = const Text("Loading");
    } else if (birdsDataPvd.hasError) {
      child = Text(birdsDataPvd.error);
    } else {
      child = const Text('No data');
    }
    return Scaffold(body: child);
  }
}
