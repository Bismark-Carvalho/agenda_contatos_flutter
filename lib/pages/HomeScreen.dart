import 'dart:io';

import 'package:agenda_contatos/pages/contact_page.dart';
import 'package:agenda_contatos/pages/helpers/contact_helper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List<Contact> contacts = List();

class _HomeScreenState extends State<HomeScreen> {
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();

    // Contact c = Contact();
    // c.name = "Bismark Carvalho de Oliveira";
    // c.email = "bismark@gmail.com";
    // c.img = "imgTeste";
    // c.phone = "123456789";
    // helper.saveContact(c);
    print(contacts);
    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Contatos"),
          backgroundColor: Colors.red,
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showContactPage(context);
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.red),
        body: ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            return contactCard(context, index);
          },
        ),
      ),
    );
  }
}

Widget contactCard(BuildContext context, int index) {
  return GestureDetector(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].img != null
                          ? FileImage(File(contacts[index].img))
                          : AssetImage("image/person.png"))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contacts[index].name ?? "",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    contacts[index].email ?? "",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    contacts[index].phone ?? "",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
    onTap: () {
      _showContactPage(context, contact: contacts[index]);
    },
  );
}

void _showContactPage(BuildContext context, {Contact contact}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ContactPage(
                contact: contact,
              )));
}
