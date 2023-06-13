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
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromWidth(double.infinity),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0XFFEAEAEA),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      color: const Color(0XFFEEBD3E),
                      border: Border.all(color: Colors.black, width: 0),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Acumin Pro",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: "Acumin Pro",
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    controller: _tabController,
                    tabs: const [
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
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // _AllView(),
          _DogsView(),
          _CatsView(),
          _BirdsView(),
        ],
      ),
    );
  }
}
