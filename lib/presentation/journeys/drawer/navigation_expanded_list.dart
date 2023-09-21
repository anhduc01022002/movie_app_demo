import 'package:flutter/material.dart';
import 'package:movie_app/presentation/journeys/drawer/navigation_list_item.dart';
class NavigationExpandedList extends StatelessWidget {
  final String title;
  final Function(int) onPressed;
  final List<String> children;
  const NavigationExpandedList({
    Key? key,
    required this.title,
    required this.onPressed,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            blurRadius: 2,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          for(int i=0; i<children.length;i++)
            NavigationSubListItem(
                title: children[i],
                onPressed: (index) => onPressed(i),
                index: i,
            ),
        ],
      ),
    );
  }
}
