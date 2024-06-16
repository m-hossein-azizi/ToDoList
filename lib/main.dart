import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todolist/data/data.dart';
import 'package:todolist/data/repo/repository.dart';
import 'package:todolist/data/source/hive_task_source.dart';
import 'package:todolist/screens/home/home.dart';

const taskBoxName = "tasks";

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskEntityAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<TaskEntity>(taskBoxName);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: primaryContainerColor));
  runApp(ChangeNotifierProvider<Repository<TaskEntity>>(
      create: (context) => Repository<TaskEntity>(
          localDataSource: HiveTaskDataSource(box: Hive.box(taskBoxName))),
      child: const MyApp()));
}

const Color primaryColor = Color(0xff794CFF);
const Color primaryContainerColor = Color(0xff5C0AFF);
const Color secondryTextColor = Color(0xffAFBED0);
const Color highPriority = primaryColor;
const Color normalPriority = Color(0xffF09819);
const Color lowpriority = Color(0xff3BE1F1);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final primaryTextColor = Color(0xff1D2830);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(color: secondryTextColor),
            iconColor: secondryTextColor,
            border: InputBorder.none),
        colorScheme: ColorScheme.light(
            primary: primaryColor,
            onPrimary: Colors.white,
            primaryContainer: primaryContainerColor,
            surface: const Color(0xffF3F5F8),
            onSurface: primaryTextColor,
            secondary: primaryColor,
            onSecondary: Colors.white),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
