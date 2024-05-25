import 'package:flutter/material.dart';

void showAboutTasksDialog(BuildContext context) {
  final dialog = AlertDialog(
    title: const Text('O co chodzi z zadaniami w Workus?'),
    content: const Text(
      'Używając tego okna możesz dodać zadania, które chcesz wykonać zanim rozpoczniesz swoją pracę, w czasie krótkich przerw, i po zakończeniu swoich sesji. Dzięki temu możesz zadbać o swoje zdrowie, gdyż będziesz pamiętać, aby na przykład dać odpocząć swoim oczom po okresie intensywnej pracy przed komputerem. Zadania możesz dodawać dowolnie według uznania, nie przekraczając trzech zadań na kategorię.',
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Zrozumiano!'),
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (context) => dialog,
  );
}
