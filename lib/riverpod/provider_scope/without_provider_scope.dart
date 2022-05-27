import 'package:flutter/material.dart';

class WithoutProviderScopePage extends StatelessWidget {
  const WithoutProviderScopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          // const修飾子がないので、ListViewがリビルドされると全てのItemTileもリビルドされる
          return ItemTile(index: index);
        },
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  const ItemTile({Key? key, required this.index}) : super(key: key);

// TodoListPageのListViewから受け取る index
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('$index番目のitem'));
  }
}
