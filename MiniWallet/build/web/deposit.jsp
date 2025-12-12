<%-- 
    Document   : deposit
    Created on : Dec 12, 2025, 3:47:45 PM
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
        <link rel="stylesheet" href="assets/css/deposit.css"/>
        <title>Nạp tiền</title>
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
                <div class="col-md-6">

                    <div class="card shadow-sm">
                        <div class="card-header bg-white text-center py-3">
                            <h4 class="mb-0 text-success"><i class="fas fa-arrow-circle-up me-2"></i>Nạp tiền</h4>
                        </div>

                        <div class="card-body p-4">

                            <div class="info-box">
                                <h6 class="text-muted text-uppercase small fw-bold mb-3">Thông tin tài khoản nhận</h6>
                                <div class="row mb-2">
                                    <div class="col-4 text-muted">Chủ thẻ:</div>
                                    <div class="col-8 fw-bold">${user.fullName}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-4 text-muted">Số TK:</div>
                                    <div class="col-8 fw-bold font-monospace">${user.accountNumber}</div>
                                </div>
                                <div class="row">
                                    <div class="col-4 text-muted">Số dư:</div>
                                    <div class="col-8 fw-bold text-primary">
                                        <fmt:formatNumber value="${user.balance}" type="currency" currencySymbol="₫"/>
                                    </div>
                                </div>
                            </div>

                            <form action="deposit" method="post">
                                <div class="mb-4">
                                    <label for="amount" class="form-label fw-bold">Nhập số tiền muốn nạp (VND)</label>
                                    <div class="input-group input-group-lg">
                                        <input type="number" class="form-control" id="amount" name="depositAmount" 
                                               placeholder="Ví dụ: 500000" min="1000" step="1000" required>
                                        <span class="input-group-text">₫</span>
                                    </div>
                                    <div class="form-text">Số tiền nạp tối thiểu là 1,000đ.</div>
                                </div>

                                <div class="d-grid gap-2">
                                    <input type="submit" class="btn btn-success btn-lg" value="Xác nhận nạp tiền">
                                    <a href="home" class="btn btn-outline-secondary">Hủy bỏ</a>
                                </div>
                            </form>

                            <c:if test="${successMessage != null}">
                                <div class="alert alert-success mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-check-circle me-2"></i>
                                    <div>${successMessage}</div>
                                </div>
                            </c:if>

                            <c:if test="${errorMessage != null}">
                                <div class="alert alert-danger mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-exclamation-circle me-2"></i>
                                    <div>${errorMessage}</div>
                                </div>
                            </c:if>

                        </div>
                    </div>

                </div>
            </div>
        </div>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
