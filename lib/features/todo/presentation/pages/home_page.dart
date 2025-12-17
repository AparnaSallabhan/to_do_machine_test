import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_machine_test/core/common/widgets/loader.dart';
import 'package:to_do_machine_test/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do_machine_test/features/todo/presentation/pages/add_new_todo_page.dart';
import 'package:to_do_machine_test/features/todo/presentation/pages/todo_detail_page.dart';

class HomePage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const HomePage());
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<TodoBloc>().add(TodoGetAllTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AddNewTodoPage.route());
        },
        shape: CircleBorder(),
        backgroundColor: Color(0xff5F33E1),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),

      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
          // else if (state is TodoUploadSuccess) {
          //   Navigator.pushAndRemoveUntil(
          //     context,
          //     HomePage.route(),
          //     (route) => false,
          //   );
          // }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Loader();
          }

          if (state is TodoDisplaySuccess) {
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Task To Do',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff24252C),
                        ),
                      ),

                      SizedBox(width: 16),

                      CircleAvatar(
                        radius: 9,
                        backgroundColor: Color(0xffEEE9FF),
                        child: Text(
                          '${state.todos.length}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff5F33E1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (context, index) {
                        final todo = state.todos[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, TodoDetailPage.route(todo));
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff000000).withAlpha(30),
                                  offset: Offset(0, 4),
                                  blurRadius: 32,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 34,
                                  width: 34,
                                  decoration: BoxDecoration(
                                    color: Color(0xffFFE4F2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.business_center,
                                    color: Color(0xffF478B8),
                                  ),
                                ),

                                SizedBox(width: 12),
                                Text(
                                  todo.projectName,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff24252C),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: state.todos.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
