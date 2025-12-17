import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:to_do_machine_test/features/todo/domain/entities/todo.dart';
import 'package:to_do_machine_test/features/todo/presentation/bloc/todo_bloc.dart';

class TodoDetailPage extends StatelessWidget {
  static route(Todo todo) =>
      MaterialPageRoute(builder: (context) => TodoDetailPage(todo: todo));
  final Todo todo;
  const TodoDetailPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: SvgPicture.asset('assets/svg/Arrow - Left.svg'),
          ),
        ),

        title: Text(
          'Todo Details',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Color(0xff24252C),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            Container(
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
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          todo.projectName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff24252C),
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                        SizedBox(height: 6),

                        Text(
                          todo.description,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6E6A7C),
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),

                        SizedBox(height: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xffAB94FF),
                            ),

                            SizedBox(width: 8),

                            Text(
                              '${DateFormat('dd/MM/yyyy').format(todo.startDate)} - ${DateFormat('dd/MM/yyyy').format(todo.endDate)}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffAB94FF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                      SizedBox(height: 30),

                      InkWell(
                        onTap: todo.isCompleted
                            ? null
                            : () {
                                context.read<TodoBloc>().add(
                                  TodoMarkCompletedEvent(
                                    todoId: todo.id!,
                                    isCompleted: true,
                                  ),
                                );

                                Navigator.pop(context); // go back to list
                              },
                        overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: todo.isCompleted == true
                                ? Color(0xffE8F7EF)
                                : Color(0xffEDE8FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 6,
                          ),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              color: todo.isCompleted
                                  ? Color(0xff2E7D32)
                                  : Color(0xff5F33E1),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
