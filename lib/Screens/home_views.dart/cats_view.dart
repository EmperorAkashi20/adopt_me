part of home_views;

class _CatsView extends ConsumerWidget {
  const _CatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsDataPvd = ref.watch(catsDataProvider);
    Widget child;
    if (catsDataPvd.hasData) {
      child = StreamBuilder(
          stream: catsDataPvd.data,
          builder: (context, snapshot) {
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
          });
    } else if (catsDataPvd.isLoading) {
      child = const Text("Loading");
    } else if (catsDataPvd.hasError) {
      child = Text(catsDataPvd.error);
    } else {
      child = const Text('No data');
    }
    return Scaffold(body: child);
  }
}
