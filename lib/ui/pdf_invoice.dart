import 'dart:io';
import 'package:flutter/services.dart';
import 'package:link_up/ui/pdf_ticket.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceApi {
  static Future<File> generate(
      {String? Event_Name,
      String? Event_Date,
      String? Event_Location,
      String? Username,
      String? user_email,
      String? userphoneNumber,
      String? TicketType,
      String? NoOfTickets,
      String? SubTotal,
      String? Fee,
      String? Tax,
      String? Discount,
      String? Grandtotal}) async {
    final pdf = pw.Document();

    final iconImage = (await rootBundle.load('assets/events_splash2.png'))
        .buffer
        .asUint8List();

    final tableHeaders = [
      'Ticket Type',
      'Quantity',
      'Unit Price',
      'Tax',
      'Fee',
      'Discount',
      'Total',
    ];

    final tableData = [
      [
        TicketType,
        NoOfTickets,
        '\$ ' + SubTotal.toString(),
        '\$ ' + Tax.toString(),
        '\$ ' + Fee.toString(),
        '\$ ' + Discount.toString(),
        '\$ ' + Grandtotal.toString(),
      ],
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (context) {
          return [
            pw.Row(
              children: [
                pw.Image(
                  pw.MemoryImage(iconImage),
                  height: 72,
                  width: 72,
                ),
                pw.SizedBox(width: 1 * PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      Event_Name!,
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      Event_Location!,
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      Event_Date!,
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      Username!,
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      user_email!,
                    ),
                    pw.Text(
                      userphoneNumber!,
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
            pw.Text(
              '',
              textAlign: pw.TextAlign.justify,
            ),
            pw.SizedBox(height: 5 * PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
                5: pw.Alignment.centerRight,
                6: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(),
            pw.SizedBox(height: 1 * PdfPageFormat.mm),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * PdfPageFormat.mm),
              pw.Text(
                'Link up Invoice',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.mm),
            ],
          );
        },
      ),
    );

    return FileHandleApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
