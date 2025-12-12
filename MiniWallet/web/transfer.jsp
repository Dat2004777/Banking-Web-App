<%-- 
    Document   : transfer
    Created on : Dec 11, 2025, 10:51:25 PM
    Author     : dat20
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/main.css"/>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/transfer.css"/>
        <title>Chuyển tiền</title>
    </head>
    <body>
        <nav class="navbar navbar-dark bg-primary mb-4">
            <div class="container">
                <a class="navbar-brand" href="home"><i class="fas fa-university me-2"></i>MyBank</a>
                <a href="home" class="btn btn-outline-light btn-sm"><i class="fas fa-arrow-left me-2"></i>Quay lại trang chủ</a>
            </div>
        </nav>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">

                    <div class="card shadow">
                        <div class="card-header bg-primary text-white text-center py-3">
                            <h4 class="mb-0"><i class="fas fa-paper-plane me-2"></i>Chuyển tiền</h4>
                        </div>

                        <div class="card-body p-4">

                            <div class="info-box">
                                <h6 class="text-primary text-uppercase small fw-bold mb-3">Tài khoản nguồn</h6>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Chủ tài khoản:</span>
                                    <span class="fw-bold">${user.fullName}</span>
                                </div>
                                <div class="d-flex justify-content-between mb-2">
                                    <span class="text-muted">Số tài khoản:</span>
                                    <span class="fw-bold font-monospace">${user.accountNumber}</span>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <span class="text-muted">Số dư khả dụng:</span>
                                    <span class="fw-bold text-success">
                                        <fmt:formatNumber value="${user.balance}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                            </div>

                            <form action="transfer" method="post">

                                <div class="mb-3">
                                    <label for="receiver" class="form-label fw-bold">Số tài khoản người nhận</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-user-circle"></i></span>
                                        <input type="text" class="form-control" id="receiver" name="receiverAccountNumber" 
                                               placeholder="Nhập số tài khoản người nhận" required>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="amount" class="form-label fw-bold">Số tiền chuyển</label>
                                    <div class="input-group">
                                        <input type="number" class="form-control" id="amount" name="transferAmount" 
                                               placeholder="Tối thiểu 2,000" min="2000" required>
                                        <span class="input-group-text fw-bold">₫</span>
                                    </div>
                                    <div class="form-text">Số tiền tối thiểu một lần chuyển là 2,000đ.</div>
                                </div>

                                <div class="mb-4">
                                    <label for="msg" class="form-label fw-bold">Nội dung chuyển tiền</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light"><i class="fas fa-pen"></i></span>
                                        <input type="text" class="form-control" id="msg" name="message" 
                                               placeholder="Ví dụ: Chuyển tiền ăn trưa...">
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <input type="submit" class="btn btn-primary btn-lg" value="Xác nhận chuyển">
                                    <a href="home" class="btn btn-outline-secondary">Hủy bỏ</a>
                                </div>
                            </form>

                            <c:if test="${successMessage != null}">
                                <div class="alert alert-success mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-check-circle me-3 fs-4"></i>
                                    <div>${successMessage}</div>
                                </div>
                            </c:if>

                            <c:if test="${errorMessage != null}">
                                <div class="alert alert-danger mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-exclamation-triangle me-3 fs-4"></i>
                                    <div>${errorMessage}</div>
                                </div>
                            </c:if>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <c:set var="errorMessage" value="${null}" scope="session"></c:set>
        <c:set var="successMessage" value="${null}" scope="session"></c:set>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
