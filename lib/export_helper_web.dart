import 'dart:html' as html;

void exportJobCardPdf(Map<String, dynamic> card) {
  final htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <title>MOTO-X Job Card - ${card['jcNumber']}</title>
  <style>
    @page {
      size: A4 portrait;
      margin: 6mm;
    }
    * {
      box-sizing: border-box;
    }
    html, body {
      width: 100%;
      height: 100%;
      margin: 0;
      padding: 0;
    }
    body {
      font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
      color: #1E1E2F;
      line-height: 1.25;
      font-size: 10px;
      background-color: #FFFFFF;
    }
    .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 2px solid #6366F1;
      padding-bottom: 6px;
      margin-bottom: 10px;
    }
    .logo-container {
      display: flex;
      align-items: center;
    }
    .logo-badge {
      width: 28px;
      height: 28px;
      background: linear-gradient(135deg, #6366F1, #22D3EE);
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 6px;
      color: white;
      font-size: 16px;
      font-weight: bold;
    }
    .logo-title {
      font-size: 16px;
      font-weight: 900;
      color: #1A1A2E;
      letter-spacing: 0.5px;
      line-height: 1.0;
    }
    .logo-sub {
      font-size: 7px;
      color: #6366F1;
      letter-spacing: 1.5px;
      font-weight: 700;
    }
    .invoice-info {
      text-align: right;
    }
    .invoice-title {
      font-size: 14px;
      font-weight: 800;
      color: #6366F1;
      margin-bottom: 2px;
    }
    .invoice-number {
      font-family: monospace;
      font-size: 10px;
      font-weight: 700;
      background-color: #F3F4F6;
      padding: 1px 4px;
      border-radius: 4px;
    }
    .invoice-date {
      font-size: 8.5px;
      color: #6B7280;
      margin-top: 2px;
    }
    .grid {
      display: flex;
      margin-bottom: 10px;
      gap: 10px;
    }
    .col {
      flex: 1;
      background-color: #F9FAFB;
      border: 1px solid #E5E7EB;
      border-radius: 6px;
      padding: 8px 10px;
    }
    .section-title {
      font-size: 9px;
      font-weight: 800;
      color: #4F46E5;
      border-bottom: 1.5px solid #E5E7EB;
      padding-bottom: 3px;
      margin-bottom: 6px;
      text-transform: uppercase;
      letter-spacing: 0.8px;
    }
    .field {
      margin-bottom: 3.5px;
      font-size: 9.5px;
      display: flex;
      justify-content: space-between;
    }
    .label {
      color: #6B7280;
      font-weight: 600;
    }
    .val {
      font-weight: 700;
      color: #111827;
      text-align: right;
    }
    .mono {
      font-family: monospace;
      font-size: 8.5px;
    }
    .badge {
      display: inline-block;
      padding: 1.5px 5px;
      font-size: 8.5px;
      font-weight: 700;
      border-radius: 4px;
      margin-right: 3px;
      margin-bottom: 3px;
    }
    .badge-primary {
      background-color: rgba(99, 102, 241, 0.08);
      color: #4F46E5;
      border: 1px solid rgba(99, 102, 241, 0.2);
    }
    .badge-error {
      background-color: rgba(239, 68, 68, 0.08);
      color: #DC2626;
      border: 1px solid rgba(239, 68, 68, 0.2);
    }
    .badge-success {
      background-color: rgba(16, 185, 129, 0.08);
      color: #059669;
      border: 1px solid rgba(16, 185, 129, 0.2);
    }
    .detail-section {
      background-color: #F9FAFB;
      border: 1px solid #E5E7EB;
      border-radius: 6px;
      padding: 8px 10px;
      margin-bottom: 10px;
    }
    .signature-area {
      margin-top: 10px;
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
    }
    .sig-box {
      border: 1px dashed #9CA3AF;
      border-radius: 6px;
      width: 180px;
      height: 45px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 9.5px;
      color: #9CA3AF;
      font-style: italic;
    }
    .signature-img-container {
      border: 1px solid #E5E7EB;
      border-radius: 6px;
      padding: 2px;
      background-color: #FFF;
      display: inline-block;
    }
    .signature-status {
      color: #059669;
      font-weight: bold;
      font-size: 11px;
    }
    @media print {
      body {
        padding: 0;
        background-color: transparent;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
      }
      html, body {
        height: 297mm;
        overflow: hidden;
      }
      .col, .detail-section {
        border: 1px solid #D1D5DB;
        page-break-inside: avoid;
      }
      .signature-area {
        page-break-inside: avoid;
      }
    }
  </style>
</head>
<body>
  <div class="header">
    <div class="logo-container">
      <div class="logo-badge">✓</div>
      <div>
        <div class="logo-title">MOTO-X</div>
        <div class="logo-sub">SERVICE MANAGEMENT</div>
      </div>
    </div>
    <div class="invoice-info">
      <div class="invoice-title">JOB CARD</div>
      <div class="invoice-number">${card['jcNumber']}</div>
      <div class="invoice-date">Date: ${card['jcDate']}</div>
    </div>
  </div>

  <div class="grid">
    <div class="col">
      <div class="section-title">Customer Details</div>
      <div class="field"><span class="label">Name:</span> <span class="val">${card['customer']['name']}</span></div>
      <div class="field"><span class="label">Mobile:</span> <span class="val">+91 ${card['customer']['phone']}</span></div>
      <div class="field"><span class="label">Email:</span> <span class="val">${card['customer']['email']}</span></div>
      <div class="field"><span class="label">Address:</span> <span class="val">${card['customer']['address']}</span></div>
      <div class="field"><span class="label">Service Advisor:</span> <span class="val">${card['service']['advisor']}</span></div>
      <div class="field"><span class="label">Technician:</span> <span class="val">${card['service']['technician']}</span></div>
    </div>
    <div class="col">
      <div class="section-title">Vehicle Details</div>
      <div class="field"><span class="label">Reg No.:</span> <span class="val">${card['vehicle']['registration']}</span></div>
      <div class="field"><span class="label">Model:</span> <span class="val">${card['vehicle']['make']} ${card['vehicle']['model']}</span></div>
      <div class="field"><span class="label">Year / Color:</span> <span class="val">${card['vehicle']['year']} / ${card['vehicle']['color']}</span></div>
      <div class="field"><span class="label">Odometer:</span> <span class="val">${card['vehicle']['odometer']} KM</span></div>
      <div class="field"><span class="label">Fuel / Trans.:</span> <span class="val">${card['vehicle']['fuel']} / ${card['vehicle']['transmission']}</span></div>
      <div class="field"><span class="label">Chassis / VIN:</span> <span class="val mono">${card['vehicle']['chassis']}</span></div>
    </div>
  </div>

  <div class="detail-section">
    <div class="section-title">Service Details</div>
    <div style="margin-bottom: 8px;">
      <span class="label" style="display:block; margin-bottom: 4px;">Service Types:</span>
      <div>
        ${(card['service']['types'] as List).map((t) => '<span class="badge badge-primary">' + t + '</span>').join('')}
      </div>
    </div>
    <div style="margin-bottom: 8px;">
      <span class="label" style="display:block; margin-bottom: 4px;">Reported Complaints:</span>
      <div>
        ${(card['service']['complaints'] as List).isEmpty && (card['service']['details'] as String).isEmpty ? '<span class="badge badge-success">No Complaints</span>' : ''}
        ${(card['service']['complaints'] as List).map((c) => '<span class="badge badge-error">' + c + '</span>').join('')}
      </div>
      ${(card['service']['details'] as String).isNotEmpty ? '<div style="margin-top: 4px; font-style: italic; font-size: 11px; color: #4B5563; background: #F3F4F6; padding: 6px; border-radius: 4px;">' + card['service']['details'] + '</div>' : ''}
    </div>
    <div class="field" style="margin-bottom: 8px;">
      <span class="label">Fuel Level at Reception:</span>
      <span class="val">${card['service']['fuelLevel'].toInt()}%</span>
    </div>
    <div>
      <span class="label" style="display:block; margin-bottom: 4px;">Inventory Received:</span>
      <div>
        <span class="badge ${card['service']['inventory']['spareWheel'] ? 'badge-success' : 'badge-error'}">Spare Wheel: ${card['service']['inventory']['spareWheel'] ? 'Yes' : 'No'}</span>
        <span class="badge ${card['service']['inventory']['toolKit'] ? 'badge-success' : 'badge-error'}">Tool Kit: ${card['service']['inventory']['toolKit'] ? 'Yes' : 'No'}</span>
        <span class="badge ${card['service']['inventory']['jackKit'] ? 'badge-success' : 'badge-error'}">Jack Kit: ${card['service']['inventory']['jackKit'] ? 'Yes' : 'No'}</span>
        <span class="badge ${card['service']['inventory']['documents'] ? 'badge-success' : 'badge-error'}">Documents: ${card['service']['inventory']['documents'] ? 'Yes' : 'No'}</span>
      </div>
    </div>
  </div>

  <div class="detail-section">
    <div class="section-title">Inspection Anomalies & Notes</div>
    <div style="margin-bottom: 8px;">
      <span class="label" style="display:block; margin-bottom: 4px;">Inspection Defects:</span>
      <div>
        ${(card['inspection'] as Map).entries.where((e) => e.value == false).map((e) => '<span class="badge badge-error">' + e.key + '</span>').join('')}
        ${(card['inspection'] as Map).entries.where((e) => e.value == false).isEmpty ? '<span class="badge badge-success">All Systems Clear ✓</span>' : ''}
      </div>
    </div>
    ${(card['otherIssues'] as String).isNotEmpty ? '<div><span class="label">Other Inspection Notes:</span> <div style="font-size: 9.5px; margin-top: 3px; font-weight: 600; color: #1F2937; background: #F3F4F6; padding: 4px; border-radius: 4px;">' + card['otherIssues'] + '</div></div>' : ''}
  </div>

  <div class="signature-area">
    <div>
      <div style="font-size: 9px; color: #6B7280; margin-bottom: 3px; font-weight: bold;">CUSTOMER SIGNATURE</div>
      ${card['signatureBase64'] != null ? '<div class="signature-img-container"><img src="data:image/png;base64,' + card['signatureBase64'] + '" style="max-height: 40px; max-width: 180px; display: block;" /></div>' : '<div style="color: #9CA3AF; font-style: italic; font-size: 9px; border: 1px dashed #9CA3AF; width: 180px; height: 40px; display: flex; align-items: center; justify-content: center; border-radius: 4px;">Signed Digitally</div>'}
      <div style="font-size: 8px; color: #9CA3AF; margin-top: 3px; font-weight: 500;">Authorized digitally by Customer</div>
    </div>
    <div>
      <div style="font-size: 9px; color: #6B7280; margin-bottom: 3px; font-weight: bold;">WORKSHOP SIGN-OFF</div>
      <div class="sig-box">Service Advisor Signature</div>
    </div>
  </div>

  <script>
    window.onload = function() {
      setTimeout(function() {
        window.print();
      }, 500);
    }
  </script>
</body>
</html>
  ''';

  final blob = html.Blob([htmlContent], 'text/html');
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.window.open(url, '_blank');
}
