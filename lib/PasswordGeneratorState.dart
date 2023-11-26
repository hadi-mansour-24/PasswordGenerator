import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'PasswordGenerator.dart';
import 'package:flutter/services.dart';

class PasswordGeneratorState extends State<PasswordGenerator> {
  String generatedPassword = '';
  TextEditingController lengthController = TextEditingController();
  bool includeUppercase = false;
  bool includeLowercase = false;
  bool includeNumbers = false;
  bool includeSymbols = false;

  void generatePassword() {
    final random = Random.secure();
    int length = int.tryParse(lengthController.text) ?? 12;

    String charset = '';
    if(!includeLowercase && !includeUppercase &&
        !includeNumbers && !includeSymbols){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Choose some options to create your password!'),
        ),
      );
    }
    if (includeUppercase) charset += 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    if (includeLowercase) charset += 'abcdefghijklmnopqrstuvwxyz';
    if (includeNumbers) charset += '0123456789';
    if (includeSymbols) charset += '!@#\$%^&*()_-+=<>?/{}[]';
    final List<int> bytes = List.generate(
        length, (index) => charset.codeUnitAt(random.nextInt(charset.length)));
    final password = String.fromCharCodes(bytes);

    setState(() {
      generatedPassword = password;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Password created! Keep it a secret '
                'and do not share it with anyone.')
      ),
    );
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: generatedPassword));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password copied to clipboard!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Password Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Generated Password:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              generatedPassword,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: TextField(
                controller: lengthController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(labelText: 'Password Length'),
              ),
            ),
            SizedBox(height: 10),
            CheckboxListTile(
              title: Text('Uppercase Letters'),
              value: includeUppercase,
              onChanged: (value) {
                setState(() {
                  includeUppercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Lowercase Letters'),
              value: includeLowercase,
              onChanged: (value) {
                setState(() {
                  includeLowercase = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Numbers'),
              value: includeNumbers,
              onChanged: (value) {
                setState(() {
                  includeNumbers = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Symbols'),
              value: includeSymbols,
              onChanged: (value) {
                setState(() {
                  includeSymbols = value!;
                });
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: generatePassword,
              child: Text('Generate Password'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: copyToClipboard,
              child: Text('Copy to Clipboard'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
