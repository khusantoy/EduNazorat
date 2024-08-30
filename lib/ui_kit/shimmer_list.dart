import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ShimmerListType { card, tile }

class ShimmerList extends StatelessWidget {
  final int count;
  final ShimmerListType type;
  const ShimmerList({
    super.key,
    required this.count,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: count,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (ctx, index) {
        if (type == ShimmerListType.tile) {
          return const ListTile(
            leading: ShimmerItem(
              child: CircleAvatar(),
            ),
            title: ShimmerItem(
              child: Text("Firstname Lastname"),
            ),
            subtitle: ShimmerItem(
              child: Text("Phone number"),
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue.shade700,
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.group, color: Colors.white, size: 28),
                    SizedBox(width: 10),
                    Expanded(
                      child: ShimmerItem(
                        child: Text(
                          "Group Name: Group Name",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.white38, thickness: 1, height: 20),
                const Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: ShimmerItem(
                        child: Text(
                          "Main Teacher: Teacher Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Icon(Icons.person_outline, color: Colors.white, size: 24),
                    SizedBox(width: 10),
                    Expanded(
                      child: ShimmerItem(
                        child: Text(
                          "Assistant Teacher: Assistant Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
                    ShimmerItem(
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
                    ),
                    ShimmerItem(
                      child: ElevatedButton.icon(
                        onPressed: () {},
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
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class ShimmerItem extends StatelessWidget {
  final Widget child;
  const ShimmerItem({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade50,
      child: child.runtimeType == Text
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: child,
                ),
              ],
            )
          : child,
    );
  }
}
