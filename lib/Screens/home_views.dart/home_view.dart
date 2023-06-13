part of home_views;

class _HomeTab extends ConsumerWidget {
  const _HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: const _SearchWidget(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Color(0XFFEEBD3E),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  Icons.filter_alt,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
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
      height: 46,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: const Color(0XFFEAEAEA),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
          autocorrect: false,
          autofocus: true,
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
