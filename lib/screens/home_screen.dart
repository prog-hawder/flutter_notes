import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/screens/note_editor.dart';
import 'package:flutter_notes/screens/note_reader.dart';
import 'package:flutter_notes/widgets/note_card.dart';
import 'package:google_fonts/google_fonts.dart';
import '../style/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.mainColor,
      appBar: AppBar(
          elevation: 0.0,
          title: Text("Notes", style: AppStyle.mainTitle,),
          centerTitle: true,
          backgroundColor: AppStyle.mainColor),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("Notes").snapshots(),
                builder: (context, AsyncSnapshot <QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                      children: snapshot.data!.docs
                          .map((note)=> noteCard((){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => 
                                  NoteReaderScreen(note)));
                          }, note))
                          .toList(),
                    );
                  }
                  return Text("ther's no Notes", style: GoogleFonts.nunito(color: Colors.white) ,);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => 
                NoteEditorScreen()));
        }, 
        child: Icon(Icons.add_rounded, color: AppStyle.mainColor,),
        backgroundColor: AppStyle.accentColor,  
        ),
    );
  }
}
