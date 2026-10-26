<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Reservation Receipt - Château Fido</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { background-color: #f8f9fa; }
        .receipt-container { max-width: 800px; margin: 40px auto; }
        .receipt-header { border-bottom: 3px solid #764ba2; padding-bottom: 20px; margin-bottom: 30px; }
        .receipt-logo { color: #764ba2; font-weight: bold; font-size: 1.8rem; }
        .receipt-section { background: white; border-radius: 10px; padding: 25px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .receipt-row { padding: 10px 0; border-bottom: 1px solid #e9ecef; }
        .receipt-total { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border-radius: 10px; padding: 20px; }
        .print-only { display: none; }
        @media print {
            .no-print { display: none !important; }
            .print-only { display: block !important; }
            body { background-color: white; }
            .receipt-container { max-width: 100%; margin: 0; }
            .receipt-section { box-shadow: none; border: 1px solid #ddd; }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <!-- Print Header -->
        <div class="print-only text-center mb-4">
            <h2 class="receipt-logo">🐾 Château Fido</h2>
            <p class="mb-0">Premium Pet Resort & Boarding</p>
            <p class="mb-0">123 Luxury Lane, Pet City</p>
            <p class="mb-0">Tel: (123) 456-7890 | Email: contact@chateaufido.com</p>
        </div>

        <div class="receipt-container">
            <!-- Action Buttons (Non-print) -->
            <div class="d-flex justify-content-between align-items-center mb-4 no-print">
                <a href="${pageContext.request.contextPath}/admin-reservations" class="btn btn-outline-secondary">
                    <i class="bi bi-arrow-left me-1"></i> Back to Reservations
                </a>
                <div class="btn-group">
                    <button onclick="window.print()" class="btn btn-primary">
                        <i class="bi bi-printer me-1"></i> Print Receipt
                    </button>
                    <button onclick="downloadPDF()" class="btn btn-outline-primary">
                        <i class="bi bi-download me-1"></i> Download PDF
                    </button>
                </div>
            </div>

            <!-- Receipt Header -->
            <div class="receipt-section">
                <div class="row">
                    <div class="col-md-6">
                        <h2 class="receipt-logo mb-3">Château Fido</h2>
                        <p class="mb-1">Premium Pet Resort & Boarding</p>
                        <p class="mb-1">123 Luxury Lane, Pet City</p>
                        <p class="mb-0">Tel: (123) 456-7890</p>
                        <p class="mb-0">Email: contact@chateaufido.com</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h3 class="mb-3">INVOICE</h3>
                        <div class="mb-2">
                            <strong>Invoice #:</strong> ${reservation.reservID}
                        </div>
                        <div class="mb-2">
                            <strong>Date Issued:</strong> 
                            <fmt:formatDate value="<%= new java.util.Date() %>" pattern="dd MMMM yyyy"/>
                        </div>
                        <div>
                            <strong>Status:</strong>
                            <span class="badge bg-${reservation.status == 'Confirmed' ? 'success' : 
                                reservation.status == 'PENDING' ? 'warning' : 
                                reservation.status == 'Cancelled' ? 'danger' : 'info'}">
                                ${reservation.status}
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Customer & Pet Information -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="receipt-section">
                        <h5 class="mb-3"><i class="bi bi-person me-2"></i> Customer Information</h5>
                        <div class="receipt-row">
                            <strong>Customer ID:</strong> ${reservation.custID}
                        </div>
                        <div class="receipt-row">
                            <strong>Customer Name:</strong> ${reservation.customerName}
                        </div>
                        <div class="receipt-row">
                            <strong>Email:</strong> ${reservation.customerEmail}
                        </div>
                        <div class="receipt-row">
                            <strong>Phone:</strong> ${reservation.customerPhone}
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="receipt-section">
                        <h5 class="mb-3"><i class="bi bi-heart me-2"></i> Pet Information</h5>
                        <div class="receipt-row">
                            <strong>Pet ID:</strong> ${reservation.dogID}
                        </div>
                        <div class="receipt-row">
                            <strong>Pet Name:</strong> ${reservation.dogName}
                        </div>
                        <div class="receipt-row">
                            <strong>Breed:</strong> ${reservation.dogBreed}
                        </div>
                    </div>
                </div>
            </div>

            <!-- Booking Details -->
            <div class="receipt-section mb-4">
                <h5 class="mb-3"><i class="bi bi-calendar-check me-2"></i> Booking Details</h5>
                <div class="row">
                    <div class="col-md-6">
                        <div class="receipt-row">
                            <strong>Room ID:</strong> ${reservation.roomID}
                        </div>
                        <div class="receipt-row">
                            <strong>Room Type:</strong> ${reservation.roomType}
                        </div>
                        <div class="receipt-row">
                            <strong>Rate per Night:</strong> RM <fmt:formatNumber value="${reservation.roomPrice}" pattern="#,##0.00"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="receipt-row">
                            <strong>Check-in Date:</strong> 
                            <fmt:formatDate value="${reservation.checkInDate}" pattern="EEEE, dd MMMM yyyy"/>
                        </div>
                        <div class="receipt-row">
                            <strong>Check-out Date:</strong> 
                            <fmt:formatDate value="${reservation.checkOutDate}" pattern="EEEE, dd MMMM yyyy"/>
                        </div>
                        <div class="receipt-row">
                            <strong>Nights Stay:</strong> 
                            <c:set var="diff" value="${reservation.checkOutDate.time - reservation.checkInDate.time}"/>
                            <c:set var="nights" value="${(diff / (1000 * 60 * 60 * 24))}"/>
                            <fmt:formatNumber value="${nights}" maxFractionDigits="0"/>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Payment Breakdown -->
            <div class="receipt-section mb-4">
                <h5 class="mb-3"><i class="bi bi-cash-coin me-2"></i> Payment Breakdown</h5>
                <table class="table table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Description</th>
                            <th class="text-end">Rate</th>
                            <th class="text-end">Nights</th>
                            <th class="text-end">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${reservation.roomType} Accommodation</td>
                            <td class="text-end">RM <fmt:formatNumber value="${reservation.roomPrice}" pattern="#,##0.00"/></td>
                            <td class="text-end">
                                <fmt:formatNumber value="${nights}" maxFractionDigits="0"/>
                            </td>
                            <td class="text-end">RM <fmt:formatNumber value="${reservation.totalAmount}" pattern="#,##0.00"/></td>
                        </tr>
                        <tr>
                            <td>Service Charge</td>
                            <td class="text-end">-</td>
                            <td class="text-end">-</td>
                            <td class="text-end">RM 15.00</td>
                        </tr>
                        <tr>
                            <td>Service Tax (6%)</td>
                            <td class="text-end">-</td>
                            <td class="text-end">-</td>
                            <td class="text-end">
                                RM <fmt:formatNumber value="${reservation.totalAmount * 0.06}" pattern="#,##0.00"/>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Total Amount -->
            <div class="receipt-total">
                <div class="row align-items-center">
                    <div class="col-md-6">
                        <h4 class="mb-0">TOTAL AMOUNT</h4>
                        <p class="mb-0 small">Includes all taxes and charges</p>
                    </div>
                    <div class="col-md-6 text-md-end">
                        <h2 class="mb-0">
                            RM <fmt:formatNumber 
                                value="${reservation.totalAmount + (reservation.totalAmount * 0.06) + 15}" 
                                pattern="#,##0.00"/>
                        </h2>
                    </div>
                </div>
            </div>

            <!-- Payment Status -->
            <div class="receipt-section mt-4">
                <h5 class="mb-3"><i class="bi bi-credit-card me-2"></i> Payment Status</h5>
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h6>Current Status:</h6>
                        <span class="badge ${reservation.paymentStatus == 'PAID' ? 'bg-success' : 'bg-warning'} fs-6">
                            ${reservation.paymentStatus}
                        </span>
                    </div>
                    <div class="text-end">
                        <p class="mb-1"><small>Payment Method: Credit Card</small></p>
                        <p class="mb-0"><small>Transaction ID: TXN${reservation.reservID}</small></p>
                    </div>
                </div>
            </div>

            <!-- Footer Notes -->
            <div class="text-center mt-4 pt-3 border-top">
                <p class="text-muted small mb-2">
                    <i class="bi bi-info-circle me-1"></i>
                    This is a computer-generated invoice. No signature required.
                </p>
                <p class="text-muted small">
                    Thank you for choosing Château Fido! For any inquiries, please contact our customer service.
                </p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function downloadPDF() {
            alert('PDF download feature would be implemented with a PDF generation library');
            // In production, you would implement PDF generation here
            // window.open('${pageContext.request.contextPath}/generate-pdf?reservID=${reservation.reservID}', '_blank');
        }
        
        // Set page title for print
        window.onbeforeprint = function() {
            document.title = "Receipt_${reservation.reservID}_ChateauFido";
        };
    </script>
</body>
</html>