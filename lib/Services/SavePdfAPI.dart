import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFAPI {
  pw.Widget buildFooter() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Divider(),
        pw.Row(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("PDF Generated By :",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(width: 2 * PdfPageFormat.mm),
            pw.Text("SGPA-Calculator Open Source Application"),
          ],
        ),
        pw.Row(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("GitHub :",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(width: 2 * PdfPageFormat.mm),
            pw.Text("https://github.com/hemanth-kotagiri/sgpa-calculator"),
          ],
        ),
        pw.Row(
          mainAxisSize: pw.MainAxisSize.min,
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("Application Copyright",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(width: 2 * PdfPageFormat.mm),
            pw.Icon(
              pw.IconData(
                0xA9,
              ),
              size: 15.0,
            ),
            pw.SizedBox(width: 2 * PdfPageFormat.mm),
            pw.Text("Hemanth Kotagiri"),
          ],
        )
      ],
    );
  }

  pw.Widget buildHeader(examName) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          examName,
          style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center,
        ),
      ],
    );
  }

  pw.Widget buildResultTable(result, supply) {
    final resultInfo = supply ? result.elementAt(1) : result.elementAt(2);

    final headers = ["NAME", "GRADE", "CREDITS"];
    if (resultInfo.elementAt(0).keys.toList().length > 4) {
      headers.add("INTERNAL");
      headers.add("EXTERNAL");
      headers.add("TOTAL");
    }

    return pw.Table.fromTextArray(
      headers: headers,
      border: null,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      data: _getResultDataRows(resultInfo),
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
      },
      defaultColumnWidth: const pw.IntrinsicColumnWidth(flex: 2),
      columnWidths: {
        0: pw.FixedColumnWidth(150.0),
      },
    );
  }

  pw.Widget buildStudentInfoWithGPA(result, supply) {
    final sgpaInfo = result.elementAt(0);
    final studentInfo = supply ? result.elementAt(0) : result.elementAt(1);

    return pw.Table.fromTextArray(
      border: null,
      headers: ["HALLTICKET NUMBER", "NAME", "SGPA"],
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.center,
      },
      data: [
        [
          studentInfo["HTNO"],
          studentInfo["NAME"],
          sgpaInfo["SGPA"] == null ? "NONE" : sgpaInfo["SGPA"],
        ]
      ],
    );
  }

  Future<File> generate(result, examName, supply) async {
    final pdf = pw.Document();
    final studentInfo = supply ? result.elementAt(0) : result.elementAt(1);
    final hallticket = studentInfo["HTNO"];
    pdf.addPage(pw.MultiPage(
      build: (context) => [
        buildHeader(examName),
        pw.Divider(),
        buildStudentInfoWithGPA(result, supply),
        pw.Divider(),
        buildResultTable(result, supply),
      ],
      footer: (context) => buildFooter(),
    ));
    return saveDocument(name: hallticket, pdf: pdf, examName: examName);
  }

  Future openFile(File file) async {
    final fileUrl = file.path;

    await OpenFile.open(fileUrl);
  }

  //buildFooter() {}

  Future<File> saveDocument(
      {String name, pw.Document pdf, String examName}) async {
    final bytes = await pdf.save();

    examName = examName.replaceAll(r'/', ' '); // replacing for rc/rv
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name-$examName.pdf');

    await file.writeAsBytes(bytes);

    return file;
  }

  List<List<dynamic>> _getResultDataRows(resultInfo) {
    List<List<dynamic>> data = [];
    for (int i = 0; i < resultInfo.length; i++) {
      List<dynamic> element = resultInfo.elementAt(i).values.toList();
      element.removeAt(0);
      data.add(element);
    }
    return data;
  }
}
