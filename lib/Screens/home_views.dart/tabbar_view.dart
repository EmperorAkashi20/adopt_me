part of home_views;

class _SearchTabs extends ConsumerStatefulWidget {
  const _SearchTabs({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchTabsState();
}

class _SearchTabsState extends ConsumerState<_SearchTabs>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Acumin Pro",
              fontSize: 14,
              color: Color(0xFFF6FCFB),
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: "Acumin Pro",
              fontSize: 14,
              color: Color(0xFFF6FCFB),
            ),
            labelColor: Colors.tealAccent,
            unselectedLabelColor: Colors.tealAccent.withOpacity(0.6),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            controller: _tabController,
            tabs: const [
              Tab(
                text: "All",
              ),
              Tab(
                text: "Dogs",
              ),
              Tab(
                text: "Cats",
              ),
              Tab(
                text: "Birds",
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Text('data'),
          Text('data1'),
          Text('data2'),
          Text('data3'),
        ],
      ),
    );
  }
}
