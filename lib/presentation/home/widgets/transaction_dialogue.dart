import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneybook/application/auth/auth_provider.dart';
import 'package:moneybook/application/auth/transaction/transaction_provider.dart';
import 'package:moneybook/domain/app/transaction.dart';
import 'package:moneybook/presentation/util/validation_rules.dart';

class TransactionDialog extends HookConsumerWidget {
  const TransactionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final profile = ref.watch(authProvider.select((value) => value.profile));
    final amountController = useTextEditingController();
    final noteController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedSource = useState('');
    final selectedType = useState('');
    return AlertDialog(
      title: const Text('New Transaction'),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Source :'),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField(
                    items: List<DropdownMenuItem<String>>.from(
                      profile.sources.map(
                        (e) => DropdownMenuItem(
                          value: e.name,
                          child: Text(e.name),
                        ),
                      ),
                    )..add(
                        const DropdownMenuItem(
                          value: '',
                          child: Text('Select One'),
                        ),
                      ),
                    onChanged: (value) {
                      selectedSource.value = value.toString();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount :'),
                Expanded(
                  child: TextFormField(
                    controller: amountController,
                    validator: ValidationRules.money,
                    keyboardType: TextInputType.number,
                    enabled: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      label: Text('0 BDT'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        // borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Trans. Type :'),
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField(
                    onChanged: (value) {
                      selectedType.value = value.toString();
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'income',
                        child: Text('Income'),
                      ),
                      DropdownMenuItem(
                        value: 'expense',
                        child: Text('Expense'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Note :'),
                Expanded(
                  child: TextFormField(
                    controller: noteController,
                    maxLines: 2,
                    enabled: true,
                    decoration: const InputDecoration(
                      isDense: true,
                      label: Text('Note (Optional)'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        //borderRadius: BorderRadius.circular(15),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple),
                        // borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  ref.watch(transactionProvider.notifier).submit(Transaction(
                      amount: double.parse(amountController.text),
                      time: DateTime.now(),
                      source: selectedSource.value,
                      transactionType: selectedType.value,
                      note: noteController.text));

                  Navigator.of(context).pop();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
