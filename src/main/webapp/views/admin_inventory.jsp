<%-- 
    Document   : admin_inventory
    Created on : 29 Dec 2025, 10:58:30 pm
    Author     : Administrator
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Inventory - Château Fido</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
         <link rel="stylesheet" href="${pageContext.request.contextPath}/views/assets/css/styles.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        .sidebar { min-height: 100vh; background-color: #2c3e50; }
        .sidebar .nav-link { color: rgba(255,255,255,0.85); padding: 1rem 1.5rem; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { color: #fff; background-color: rgba(255,255,255,0.1); }
        .sidebar-brand { padding: 1.5rem; color: #fff; font-size: 1.5rem; font-weight: bold; text-align: center; }
        .status-Good { color: #198754; font-weight: bold; }
        .status-Low { color: #fd7e14; font-weight: bold; }
        .status-Critical { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            
            <!-- SIDEBAR -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar collapse p-0">
                <div class="sidebar-brand">Château Fido</div>
                <div class="position-sticky">
                    <ul class="nav flex-column">
                        <li class="nav-item"><a class="nav-link" href="admin-dashboard"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a></li>
                        <li class="nav-item"><a class="nav-link" href="admin-bookings"><i class="bi bi-file-earmark-medical me-2"></i>  Vaccines</a></li>
                             <li class="nav-item">
                            <a class="nav-link" href="admin-reservations">
                                <i class="bi bi-calendar-week"></i> Reservations
                            </a>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="admin-rooms"><i class="bi bi-houses me-2"></i> Room Management</a>
                        <li class="nav-item"><a class="nav-link active" href="admin-inventory"><i class="bi bi-box-seam me-2"></i> Inventory</a></li>
                        <li class="nav-item mt-4 border-top border-secondary"><a class="nav-link text-danger" href="logout"><i class="bi bi-box-arrow-right me-2"></i> Logout</a></li>
                    </ul>
                </div>
            </nav>

            <!-- MAIN CONTENT -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4 bg-light min-vh-100">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h2">Inventory Management</h1>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addItemModal">
                        <i class="bi bi-plus-lg"></i> Add New Item
                    </button>
                </div>

                <!-- SEARCH & FILTER FORM -->
                <div class="card border-0 shadow-sm mb-4">
                    <div class="card-body">
                        <form action="admin-inventory" method="get" class="row g-2 align-items-center">
                            <div class="col-md-5">
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-search"></i></span>
                                    <input type="text" name="search" class="form-control" placeholder="Search by item name or ID..." value="${param.search}">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <select name="category" class="form-select">
                                    <option value="All">All Categories</option>
                                    <option value="Food" ${param.category == 'Food' ? 'selected' : ''}>Food</option>
                                    <option value="Toys" ${param.category == 'Toys' ? 'selected' : ''}>Toys</option>
                                    <option value="Cleaning" ${param.category == 'Cleaning' ? 'selected' : ''}>Cleaning</option>
                                    <option value="Medical" ${param.category == 'Medical' ? 'selected' : ''}>Medical</option>
                                    <option value="Supplies" ${param.category == 'Supplies' ? 'selected' : ''}>Supplies</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-dark w-100">Filter</button>
                            </div>
                            <div class="col-md-2">
                                <a href="admin-inventory" class="btn btn-outline-secondary w-100">Clear</a>
                            </div>
                        </form>
                    </div>
                </div>

                <c:if test="${not empty message}"><div class="alert alert-success">${message}</div></c:if>
                <c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

                <div class="card border-0 shadow-sm">
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Item ID</th>
                                        <th>Name</th>
                                        <th>Category</th>
                                        <th>Stock Level</th>
                                        <th>Status</th>
                                        <th>Last Update</th>
                                        <th class="text-end pe-4">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty items}">
                                        <tr>
                                            <td colspan="7" class="text-center py-4 text-muted">No items found matching your search.</td>
                                        </tr>
                                    </c:if>
                                    
                                    <c:forEach var="item" items="${items}">
                                        <tr class="${item.status == 'Critical' ? 'table-danger' : ''}">
                                            <td class="ps-4 text-muted small">${item.itemID}</td>
                                            <td class="fw-bold">${item.itemName}</td>
                                            <td><span class="badge bg-secondary">${item.category}</span></td>
                                            <td>
                                                <strong>${item.currentStock}</strong> / <small class="text-muted">Min: ${item.minStock}</small>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${item.status == 'Critical'}">
                                                        <span class="badge bg-danger">
                                                            <i class="bi bi-exclamation-triangle-fill me-1"></i> Critical
                                                        </span>
                                                    </c:when>
                                                    <c:when test="${item.status == 'Low'}">
                                                        <span class="badge bg-warning text-dark">
                                                            <i class="bi bi-exclamation-circle-fill me-1"></i> Low Stock
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-success">
                                                            <i class="bi bi-check-circle-fill me-1"></i> Good
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="small text-muted">${item.lastRestock}</td>
                                            <td class="text-end pe-4">
                                                <button class="btn btn-sm btn-outline-primary me-1" 
                                                        title="Edit Details"
                                                        onclick="openEditModal('${item.itemID}', '${item.itemName}', '${item.category}', '${item.minStock}')">
                                                    <i class="bi bi-pencil"></i>
                                                </button>

                                                <button class="btn btn-sm btn-outline-success me-1" 
                                                        title="Stock In"
                                                        onclick="openStockModal('${item.itemID}', '${item.itemName}', 'in')">
                                                    <i class="bi bi-plus-lg"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" 
                                                        title="Stock Out"
                                                        onclick="openStockModal('${item.itemID}', '${item.itemName}', 'out')">
                                                    <i class="bi bi-dash-lg"></i>
                                                </button>
                                                
                                                <form action="admin-inventory" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete ${item.itemName}?');">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="itemID" value="${item.itemID}">
                                                    <button type="submit" class="btn btn-sm btn-outline-secondary ms-1" title="Delete Item">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- ADD ITEM MODAL -->
    <div class="modal fade" id="addItemModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Inventory Item</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="admin-inventory" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="modal-body">
                        <div class="mb-3"><label>Item Name</label><input type="text" name="itemName" class="form-control" required></div>
                        <div class="mb-3"><label>Category</label>
                            <select name="category" class="form-select">
                                <option>Food</option><option>Toys</option><option>Cleaning</option><option>Medical</option><option>Supplies</option>
                            </select>
                        </div>
                        <div class="row">
                            <div class="col mb-3"><label>Current Stock</label><input type="number" name="currentStock" class="form-control" required></div>
                            <div class="col mb-3"><label>Min Level</label><input type="number" name="minStock" class="form-control" required></div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Save Item</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- EDIT ITEM MODAL -->
    <div class="modal fade" id="editItemModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Item Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="admin-inventory" method="post">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="itemID" id="editItemID">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label>Item Name</label>
                            <input type="text" name="itemName" id="editItemName" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label>Category</label>
                            <select name="category" id="editCategory" class="form-select">
                                <option>Food</option><option>Toys</option><option>Cleaning</option><option>Medical</option><option>Supplies</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label>Min Stock Level</label>
                            <input type="number" name="minStock" id="editMinStock" class="form-control" required>
                            <small class="text-muted">Current Stock cannot be changed here. Use Stock In/Out.</small>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary">Update Item</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- STOCK UPDATE MODAL -->
    <div class="modal fade" id="stockModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="stockModalTitle">Update Stock</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form action="admin-inventory" method="post">
                    <input type="hidden" name="action" value="update_stock">
                    <input type="hidden" name="itemID" id="stockItemID">
                    <input type="hidden" name="type" id="stockType">
                    <div class="modal-body">
                        <p id="stockItemName" class="fw-bold"></p>
                        <div class="mb-3">
                            <label>Quantity</label>
                            <input type="number" name="quantity" class="form-control" min="1" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-success" id="stockSubmitBtn">Confirm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function openStockModal(id, name, type) {
            document.getElementById('stockItemID').value = id;
            document.getElementById('stockType').value = type;
            document.getElementById('stockItemName').innerText = (type === 'in' ? "Adding stock for: " : "Using stock from: ") + name;
            document.getElementById('stockModalTitle').innerText = type === 'in' ? "Stock In (+)" : "Stock Out (-)";
            document.getElementById('stockSubmitBtn').className = type === 'in' ? "btn btn-success" : "btn btn-danger";
            document.getElementById('stockSubmitBtn').innerText = type === 'in' ? "Add Stock" : "Remove Stock";
            
            var modal = new bootstrap.Modal(document.getElementById('stockModal'));
            modal.show();
        }

        function openEditModal(id, name, category, minStock) {
            document.getElementById('editItemID').value = id;
            document.getElementById('editItemName').value = name;
            document.getElementById('editCategory').value = category;
            document.getElementById('editMinStock').value = minStock;
            
            var modal = new bootstrap.Modal(document.getElementById('editItemModal'));
            modal.show();
        }
    </script>
</body>
</html>