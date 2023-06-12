part of home_views;

class _AddPetSheet extends ConsumerWidget {
  const _AddPetSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addPetPvd = ref.watch(addPetProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [
          CloseButton(
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 52,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      hint: const Text("Select One"),
                      value: addPetPvd.dropdownValue,
                      onChanged: (value) {
                        addPetPvd.setDropdownValue(value!);
                        addPetPvd.btnController.reset();
                      },
                      items: addPetPvd.list
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: addPetPvd.breedController,
                  onChanged: (value) {
                    addPetPvd.btnController.reset();
                  },
                  decoration: InputDecoration(
                    hintText: 'Breed ex: Labrador',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: addPetPvd.nameController,
                  onChanged: (value) {
                    addPetPvd.btnController.reset();
                  },
                  decoration: InputDecoration(
                    hintText: 'Name ex: Tom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: addPetPvd.ageController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    addPetPvd.btnController.reset();
                  },
                  decoration: InputDecoration(
                    hintText: 'Age ex: 2,3',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: addPetPvd.imageUrlController,
                  onChanged: (value) {
                    addPetPvd.btnController.reset();
                  },
                  decoration: InputDecoration(
                    hintText: 'Image URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedLoadingButton(
                borderRadius: 10,
                controller: addPetPvd.btnController,
                onPressed: () async {
                  addPetPvd.addPet();
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
