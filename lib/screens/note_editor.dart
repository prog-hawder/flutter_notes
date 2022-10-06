

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  String date = DateFormat.yMEd().add_jms().format(DateTime.now()).toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.accentColor,
        appBar: AppBar(
          backgroundColor: AppStyle.accentColor,
          elevation: 0.0,
          leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
        
          icon: Icon(Icons.close, size: 30,),
          color: AppStyle.mainColor,
        ),
          centerTitle: true,
          title: Text("New Note",
          style: TextStyle(color: Colors.black),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  fillColor: AppStyle.mainColor,
                  filled: true,
                   enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0))
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    borderSide: BorderSide(color: AppStyle.accentColor)
                  ),
                  hintText: "Note Title",
                  hintStyle:  TextStyle(color: AppStyle.accentColor, fontSize: 16),
                ),
                style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.bold, color: AppStyle.accentColor),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(date, style: AppStyle.dateTitle,),
              SizedBox(
                height: 28.0,
              ),
               Container(
                 child: TextField(
                    controller: _mainController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                       fillColor: AppStyle.mainColor,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0))
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                      borderSide: BorderSide(color: AppStyle.accentColor)
                    ),
                      hintText: "Note",
                      hintStyle:  TextStyle(color: AppStyle.accentColor, fontSize: 16),
                    ),
                    style: GoogleFonts.roboto(fontSize: 20.0, fontWeight: FontWeight.normal, color: AppStyle.accentColor),
                  ),
               ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppStyle.accentColor,
          onPressed: () async{
            FirebaseFirestore.instance.collection("Notes").doc(_titleController.text).set({
              "notes_title": _titleController.text,
              "creation_date": date,
              "note_content" : _mainController.text,
            });
             Navigator.pop(context);},
             child: Icon(Icons.save_alt_rounded,
          color: AppStyle.mainColor,),
             
      )
      );
  }
}