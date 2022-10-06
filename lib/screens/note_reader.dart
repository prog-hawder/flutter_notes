import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../style/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.accentColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.doc["notes_title"],
          style: GoogleFonts.roboto(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.close,
            size: 30,
          ),
          color: AppStyle.mainColor,
        ),
        backgroundColor: AppStyle.accentColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 6.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(16.0),
                  width: 2000,
                  child: Text(
                    widget.doc["note_content"],
                    style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                        color: AppStyle.accentColor),
                    overflow: TextOverflow.ellipsis,
                  ),
            ),),
            SizedBox(
              height: 58.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance
              .collection("Notes")
              .doc(widget.doc["notes_title"])
              .delete();
          Navigator.pop(context);
        },
        child: Icon(
          Icons.delete_forever_rounded,
          color: AppStyle.accentColor,
        ),
        backgroundColor: AppStyle.mainColor,
      ),
    );
  }
}
