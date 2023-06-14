part of home_views;

class _HomeTab extends ConsumerWidget {
  const _HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      floatingActionButton: ThemeFab(),
      body: _SearchTabs(),
    );
  }
}
