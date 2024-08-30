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
      backgroundColor: const Color(0xffF4F9FD),
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search groups...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<GroupBloc>().add(GetGroupsEvent());
                },
              ),
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

          if (groups.isEmpty) {
            return const Center(
              child: Text('No groups found.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return InkWell(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
                                            builder: (context) => UpdateGroup(
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
                                                    groupModel: groups[index]),
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
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue.shade700,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.group,
                                color: Colors.white, size: 28),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Group Name: ${groups[index].name}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                            color: Colors.white38, thickness: 1, height: 20),
                        Row(
                          children: [
                            const Icon(Icons.person,
                                color: Colors.white, size: 24),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Main Teacher: ${groups[index].mainTeacher.name}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(Icons.person_outline,
                                color: Colors.white, size: 24),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Assistant Teacher: ${groups[index].assistantTeacher.name}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              label: const Text('View Timetables'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue.shade700,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Add logic to add a timetable
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddTimetableScreen(
                                                groupId: groups[index].id)));
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Timetable'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.blue.shade700,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
