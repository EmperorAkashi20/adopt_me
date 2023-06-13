// part of home_views;

// class _AllView extends ConsumerWidget {
//   const _AllView({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final allDataPvd = ref.watch(allDataProvider);
//     Widget child;
//     if (allDataPvd.hasData) {
//       child = Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 30),
//             if (allDataPvd.dogsData != null)
//               Expanded(
//                 child: StreamBuilder(
//                     stream: allDataPvd.dogsData,
//                     builder: (context, snapshot) {
//                       var docs = snapshot.data?.docs;
//                       return ListView.builder(
//                         shrinkWrap: true,
//                         scrollDirection: Axis.horizontal,
//                         itemCount: docs?.length,
//                         itemBuilder: (context, index) {
//                           return _PetCard(
//                             docs: docs,
//                             index: index,
//                           );
//                         },
//                       );
//                     }),
//               ),
//             if (allDataPvd.catsData != null)
//               Expanded(
//                 child: StreamBuilder(
//                     stream: allDataPvd.catsData,
//                     builder: (context, snapshot) {
//                       var docs = snapshot.data?.docs;
//                       return ListView.builder(
//                         itemCount: docs?.length,
//                         itemBuilder: (context, index) {
//                           return _PetCard(
//                             docs: docs,
//                             index: index,
//                           );
//                         },
//                       );
//                     }),
//               ),
//             const SizedBox(height: 20),
//             if (allDataPvd.birdsData != null)
//               Expanded(
//                 child: StreamBuilder(
//                     stream: allDataPvd.birdsData,
//                     builder: (context, snapshot) {
//                       var docs = snapshot.data?.docs;
//                       return ListView.builder(
//                         itemCount: docs?.length,
//                         itemBuilder: (context, index) {
//                           return _PetCard(
//                             docs: docs,
//                             index: index,
//                           );
//                         },
//                       );
//                     }),
//               ),
//           ],
//         ),
//       );
//     } else if (allDataPvd.isLoading) {
//       child = const Text("Loading");
//     } else if (allDataPvd.hasError) {
//       child = const Text("Something went wrong");
//     } else {
//       child = const Text('No data');
//     }
//     return Scaffold(body: child);
//   }
// }

// class _PetCard extends StatelessWidget {
//   const _PetCard({
//     Key? key,
//     required this.docs,
//     required this.index,
//   }) : super(key: key);

//   final List<QueryDocumentSnapshot<Map<String, dynamic>>>? docs;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) =>
//                   DetailsScreen(data: docs!.elementAt(index).data())));
//         },
//         child: Hero(
//           tag: docs?.elementAt(index).data()["name"],
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 width: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(docs
//                                 ?.elementAt(index)
//                                 .data()["image"] !=
//                             null
//                         ? Uri.parse(docs?.elementAt(index).data()["image"])
//                             .toString()
//                         : "https://img.freepik.com/premium-vector/cute-little-dog-cartoon-isolated-white_143596-3.jpg?w=2000"),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
