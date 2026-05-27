import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/app_scaffold.dart';
import 'core/widgets/primary_button.dart';

class DyanaApp extends StatelessWidget {
  const DyanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dyana',
      theme: buildAppTheme(),
      home: const AppScaffold(
        title: 'Dyana',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Um timer calmo para meditar.', textAlign: TextAlign.center),
            SizedBox(height: 24),
            PrimaryButton(label: 'Comecar', onPressed: null),
          ],
        ),
      ),
    );
  }
}
