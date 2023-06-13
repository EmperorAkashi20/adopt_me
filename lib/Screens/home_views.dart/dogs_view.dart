part of home_views;

class _DogsView extends ConsumerWidget {
  const _DogsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dogsDataPvd = ref.watch(dogsDataProvider);
    Widget child;
    if (dogsDataPvd.hasData) {
      child = StreamBuilder(
          stream: dogsDataPvd.data,
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
    } else if (dogsDataPvd.isLoading) {
      child = const Text("Loading");
    } else if (dogsDataPvd.hasError) {
      child = Text(dogsDataPvd.error);
    } else {
      child = const Text('No data');
    }
    return Scaffold(body: child);
  }
}
