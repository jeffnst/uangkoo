import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uangkoo/models/database.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isExpense = true;
  int type = 2;
  final AppDatabase database = AppDatabase();
  TextEditingController categoryNameController = TextEditingController();
  Future insert(String name, int type) async {
    DateTime now = DateTime.now();
    final row = await database.into(database.categories).insertReturning(
        CategoriesCompanion.insert(
            name: name, type: type, createdAt: now, updatedAt: now));
    //print(row.toString());
  }

  Future<List<Category>> getAllCategory(int type) async {
    return await database.getAllCategoryRepo(type);
  }

  Future update(int categoryId, String newName) async {
    return await database.updateCategoryRepo(categoryId, newName);
  }

  void openDialog(Category? category) {
    if (category != null) {
      categoryNameController.text = category.name;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Center(
                child: Column(children: [
                  Text((isExpense) ? "Add Expense" : "Add Income",
                      style: TextStyle(
                          color: (isExpense) ? Colors.red : Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  TextFormField(
                    controller: categoryNameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: "name"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (category == null) {
                        insert(categoryNameController.text, isExpense ? 2 : 1);
                      } else {
                        update(category.id, categoryNameController.text);
                      }

                      Navigator.of(context, rootNavigator: true).pop('dialog');
                      setState(() {});
                      categoryNameController.clear();
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      "save",
                      style: GoogleFonts.montserrat(
                          fontSize: 16, color: Colors.white),
                    ),
                  )
                ]),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                value: isExpense,
                onChanged: (bool value) {
                  setState(() {
                    isExpense = value;
                    type = value ? 2 : 1;
                  });
                },
                inactiveThumbColor: Colors.green,
                inactiveTrackColor: Colors.green[200],
                activeColor: Colors.red,
              ),
              IconButton(
                  onPressed: () {
                    openDialog(null);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
        ),
        FutureBuilder<List<Category>>(
            future: getAllCategory(type),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Card(
                              elevation: 10,
                              child: ListTile(
                                leading: (isExpense)
                                    ? const Icon(
                                        Icons.upload,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.download,
                                        color: Colors.green,
                                      ),
                                title: Text(snapshot.data![index].name),
                                trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          database.deleteCategoryRepo(
                                              snapshot.data![index].id);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          openDialog(snapshot.data![index]);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          );
                        });
                    //Text("Ada Data : ${snapshot.data!.length}");
                  } else {
                    return const Center(
                      child: Text("Has No Data"),
                    );
                  }
                } else {
                  return const Center(
                    child: Text("Has No Data"),
                  );
                }
              }
            }),
      ],
    ));
  }
}
