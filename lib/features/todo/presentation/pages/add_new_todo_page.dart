import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:to_do_machine_test/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:to_do_machine_test/core/common/widgets/loader.dart';
import 'package:to_do_machine_test/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:to_do_machine_test/features/todo/presentation/pages/home_page.dart';

class AddNewTodoPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewTodoPage());
  const AddNewTodoPage({super.key});

  @override
  State<AddNewTodoPage> createState() => _AddNewTodoPageState();
}

class _AddNewTodoPageState extends State<AddNewTodoPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

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
          'Add task',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: Color(0xff24252C),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),

      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is TodoUploadSuccess) {
            Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Loader();
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    // project name
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Project Name',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E6A7C),
                            ),
                          ),

                          TextFormField(
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter project name';
                              }

                              return null;
                            },
                            maxLines: 2,
                            minLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff24252C),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // description
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E6A7C),
                            ),
                          ),

                          TextFormField(
                            controller: descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter description';
                              }

                              return null;
                            },
                            maxLines: 8,
                            minLines: 5,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff6E6A7C),
                            ),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // start date
                    Container(
                      padding: EdgeInsets.only(
                        left: 50,
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6E6A7C),
                                ),
                              ),

                              Text(
                                // '01 May, 2022',
                                DateFormat('dd MMMM, yyyy').format(startDate),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff24252C),
                                ),
                              ),
                            ],
                          ),

                          InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color(
                                          0xff5F33E1,
                                        ), // Header background color
                                        onPrimary:
                                            Colors.white, // Header text color
                                        onSurface:
                                            Colors.black, // Body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Color(
                                            0xff5F33E1,
                                          ), // Button text color
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (picked != null) {
                                setState(() {
                                  startDate = picked;
                                });
                              }
                            },
                            child: Image.asset(
                              'assets/images/Arrow - Down 3.png',
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // end date
                    Container(
                      padding: EdgeInsets.only(
                        left: 50,
                        right: 16,
                        top: 16,
                        bottom: 16,
                      ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff6E6A7C),
                                ),
                              ),

                              Text(
                                DateFormat('dd MMMM, yyyy').format(endDate),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff24252C),
                                ),
                              ),
                            ],
                          ),

                          InkWell(
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: startDate,
                                firstDate: startDate,
                                lastDate: DateTime(2100),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color(
                                          0xff5F33E1,
                                        ), // Header background color
                                        onPrimary:
                                            Colors.white, // Header text color
                                        onSurface:
                                            Colors.black, // Body text color
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Color.fromARGB(
                                            255,
                                            128,
                                            120,
                                            152,
                                          ), // Button text color
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (picked != null) {
                                setState(() {
                                  endDate = picked;
                                });
                              }
                            },
                            child: Image.asset(
                              'assets/images/Arrow - Down 3.png',
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 40),

                    // add project
                    InkWell(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          final userId =
                              (context.read<AppUserCubit>().state
                                      as AppUserLoggedIn)
                                  .user
                                  .id;
                          context.read<TodoBloc>().add(
                            TodoUploadEvent(
                              userId: userId,
                              projectName: nameController.text,
                              description: descriptionController.text,
                              startDate: startDate,
                              endDate: endDate,
                              isCompleted: false,
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff5F33E1),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          'Add Project',
                          style: TextStyle(
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
