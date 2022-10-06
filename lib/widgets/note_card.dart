import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes/style/app_style.dart';
import 'package:google_fonts/google_fonts.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.accentColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["notes_title"],
            style: GoogleFonts.roboto(fontSize: 19.0, fontWeight: FontWeight.bold),
            ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            doc["creation_date"],
            style: AppStyle.dateTitle,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis ,
              ),
          ),
          
        ],
      ),
    ),
    
  );
}
