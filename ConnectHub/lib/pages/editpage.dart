import 'package:ConnectHub/servies/serviespost.dart';
import 'package:flutter/material.dart';

class NoteFormScreen extends StatefulWidget {
  final String? noteId;
  final String? initialTitle;
  final String? initialContent;

  const NoteFormScreen({
    
    this.noteId,
    this.initialTitle,
    this.initialContent,
    super.key,
  });

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  Firebasestores firebasestores=Firebasestores();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initialTitle ?? "";
    _contentController.text = widget.initialContent ?? "";
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.noteId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "تعديل الملاحظة" : "إضافة ملاحظة"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'المحتوى'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if(widget.noteId==null) {
                  firebasestores.addnote(title:_titleController.text, description: _contentController.text);
                }else{
                  firebasestores.uodatenote(nodeid: widget.noteId!, title: _titleController.text, description: _contentController.text);
                }
                if (mounted) Navigator.pop(context);
              },
              child: Text(isEditing ? "تحديث الملاحظة" : "حفظ الملاحظة"),
            ),
          ],
        ),
      ),
    );
  }
}