part of home_views;

class _HomeTab extends ConsumerWidget {
  const _HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const _SearchWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (context) => const _AddPetSheet(),
          );
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      body: const _SearchTabs(),
    );
  }
}

class _SearchWidget extends ConsumerWidget {
  const _SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 36,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0XFFD1F0EC),
          ),
        ),
        child: TextFormField(
          autocorrect: false,
          autofocus: true,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(
              bottom: 5,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Colors.white.withOpacity(0.8),
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
