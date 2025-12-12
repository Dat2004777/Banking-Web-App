<%-- 
    Document   : home
    Created on : Dec 11, 2025, 11:16:28 PM
    Author     : dat20
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/main.css"/>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/home.css"/>
        <title>Trang chủ</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
            <div class="container">
                <a class="navbar-brand" href="#"><i class="fas fa-university me-2"></i>MyBank</a>
                <div class="d-flex">
                    <span class="navbar-text text-white me-3">
                        Xin chào, <strong>${user.fullName}</strong>
                    </span>
                    <a href="logout" class="btn btn-outline-light btn-sm">Đăng xuất</a>
                </div>
            </div>
        </nav>

        <div class="container">
            <div class="row">

                <div class="col-md-4">

                    <div class="card">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-id-card me-2"></i>Thông tin tài khoản</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <label class="small text-muted">Chủ tài khoản</label>
                                <div class="fw-bold">${user.fullName}</div>
                            </div>
                            <div class="mb-3">
                                <label class="small text-muted">Số tài khoản</label>
                                <div class="fw-bold text-monospace">${user.accountNumber}</div>
                            </div>
                            <div class="mb-3">
                                <label class="small text-muted">Số dư hiện tại</label>
                                <div class="balance-text">
                                    <fmt:formatNumber value="${user.balance}" type="currency" currencySymbol="₫"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-header bg-white">
                            <h5 class="mb-0"><i class="fas fa-concierge-bell me-2"></i>Dịch vụ</h5>
                        </div>
                        <div class="card-body">
                            <form action="service" method="post" class="d-grid gap-2">
                                <button type="submit" name="selection" value="WITHDRAW" class="btn btn-outline-danger">
                                    <i class="fas fa-arrow-down me-2"></i>RÚT TIỀN
                                </button>
                                <button type="submit" name="selection" value="DEPOSIT" class="btn btn-outline-success">
                                    <i class="fas fa-arrow-up me-2"></i>NẠP TIỀN
                                </button>
                                <button type="submit" name="selection" value="TRANSFER" class="btn btn-outline-primary">
                                    <i class="fas fa-exchange-alt me-2"></i>CHUYỂN TIỀN
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card h-100">
                        <div class="card-header bg-white d-flex justify-content-between align-items-center">
                            <h5 class="mb-0"><i class="fas fa-history me-2"></i>Lịch sử giao dịch</h5>
                            <span class="badge bg-secondary">Gần đây</span>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover table-striped mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Mã GD</th>
                                            <th>Loại</th>
                                            <th class="text-end">Số tiền</th>
                                            <th>Lời nhắn</th>
                                            <th>Thời gian</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${not empty sessionScope.transactionList}">
                                            <c:forEach var="transaction" items="${sessionScope.transactionList}">
                                                <tr>
                                                    <td><small class="text-muted">#${transaction.id}</small></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${transaction.type == 'DEPOSIT'}"><span class="badge bg-success">Nạp tiền</span></c:when>
                                                            <c:when test="${transaction.type == 'WITHDRAW'}"><span class="badge bg-danger">Rút tiền</span></c:when>
                                                            <c:when test="${transaction.type == 'TRANSFER'}"><span class="badge bg-primary">Chuyển khoản</span></c:when>
                                                        </c:choose>
                                                    </td>

                                                    <td class="text-end fw-bold">
                                                        <c:choose>
                                                            <c:when test="${transaction.type == 'DEPOSIT'}">
                                                                <span class="text-success">+<fmt:formatNumber value="${transaction.amount}"/> ₫</span>
                                                            </c:when>
                                                            <c:when test="${transaction.type == 'WITHDRAW'}">
                                                                <span class="text-danger">-<fmt:formatNumber value="${transaction.amount}"/> ₫</span>
                                                            </c:when>
                                                            <c:when test="${transaction.type == 'TRANSFER'}">
                                                                <c:if test="${transaction.senderID == sessionScope.user.id}">
                                                                    <span class="text-danger">-<fmt:formatNumber value="${transaction.amount}"/> ₫</span>
                                                                </c:if>
                                                                <c:if test="${transaction.receiverID == sessionScope.user.id}">
                                                                    <span class="text-success">+<fmt:formatNumber value="${transaction.amount}"/> ₫</span>
                                                                </c:if>
                                                            </c:when>
                                                        </c:choose>
                                                    </td>

                                                    <td>${transaction.message}</td>
                                                    <td>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${transaction.time}" pattern="dd/MM/yyyy HH:mm"/>
                                                        </small>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>

                                        <c:if test="${empty sessionScope.transactionList}">
                                            <tr>
                                                <td colspan="5" class="text-center py-4 text-muted">Chưa có giao dịch nào.</td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
