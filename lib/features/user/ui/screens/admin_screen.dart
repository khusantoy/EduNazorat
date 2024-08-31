import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/features.dart';
import 'package:millima/ui_kit/shimmer_list.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GroupModel> filteredGroups = [];

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: const Text("Admin Oynasi"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              left: 15,
              right: 15,
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Guruhlarni izlash',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                context.read<GroupBloc>().add(GetGroupsEvent());
              },
            ),
          ),
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
        if (state is GroupLoadingState) {
          return const ShimmerList(
            count: 4,
            type: ShimmerListType.card,
          );
        }
        if (state is GroupErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is GroupLoadedState) {
          final groups = _searchController.text.isEmpty
              ? state.groups
              : state.groups
                  .where((group) => group.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .toList();

          return groups.isEmpty
              ? const Center(
                  child: Text("Guruhlar topilmadi"),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  actionsPadding: const EdgeInsets.all(8),
                                  title: Text(groups[index].name),
                                  actions: [
                                    Row(
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateGroup(
                                                          group: groups[index]),
                                                ));
                                          },
                                          label: const Text("Edit Group"),
                                          icon: const Icon(Icons.edit_document),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddStudentToGroupScreen(
                                                          groupModel:
                                                              groups[index]),
                                                ));
                                          },
                                          label: const Text("Add Students"),
                                          icon: const Icon(Icons.person_add),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              });
                        },
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GroupInformationScreen(
                                  groupModel: groups[index],
                                ),
                              ));
                        },
                        child: Card(
                          color: Colors.blue.shade100,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.group),
                                    const SizedBox(width: 10),
                                    Text(
                                      groups[index].name,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    const Icon(Icons.person),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Asosiy ustoz: ${groups[index].mainTeacher.name}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        "Yordamchi Ustoz: ${groups[index].assistantTeacher.name}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        20), // Add spacing between the details and the buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GetGroupTimetablesScreen(
                                              groupId: groups[index].id,
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.schedule),
                                      label: const Text('Dars jadvali'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        // Add logic to add a timetable
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddTimetableScreen(
                                                        groupId:
                                                            groups[index].id)));
                                      },
                                      icon: const Icon(Icons.add),
                                      label:
                                          const Text("Dars jadvali qo'shish"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        foregroundColor: Colors.blue.shade700,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                );
        }
        return const Center(
          child: Text("Grouplar topilmadi!"),
        );
      }),
    );
  }
}
