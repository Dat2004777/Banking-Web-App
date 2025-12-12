<%-- 
    Document   : withdraw
    Created on : Dec 12, 2025, 12:20:04 AM
    Author     : dat20
--%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="assets/css/main.css"/>
        <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="assets/css/withdraw.css"/>
        <title>Rút Tiền</title>
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
                <div class="col-md-6 col-lg-5">

                    <div class="card shadow">
                        <div class="card-header bg-danger text-white text-center py-3">
                            <h4 class="mb-0"><i class="fas fa-wallet me-2"></i>Rút Tiền</h4>
                        </div>

                        <div class="card-body p-4">

                            <div class="info-box">
                                <h6 class="text-danger text-uppercase small fw-bold mb-3">Tài khoản nguồn</h6>
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
                                    <span class="fw-bold text-primary">
                                        <fmt:formatNumber value="${user.balance}" type="currency" currencySymbol="₫"/>
                                    </span>
                                </div>
                            </div>

                            <form action="withdraw" method="post">
                                <div class="mb-4">
                                    <label for="amount" class="form-label fw-bold">Nhập số tiền cần rút</label>
                                    <div class="input-group input-group-lg">
                                        <input type="number" class="form-control" id="amount" name="withdrawAmount" 
                                               placeholder="Tối thiểu 2,000" min="2000" step="1000" required>
                                        <span class="input-group-text fw-bold text-danger">₫</span>
                                    </div>
                                    <div class="form-text text-muted">
                                        <i class="fas fa-info-circle me-1"></i>Số dư còn lại sau khi rút phải lớn hơn 50,000đ (Ví dụ).
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <input type="submit" class="btn btn-danger btn-lg" value="Xác nhận rút tiền">
                                    <a href="home" class="btn btn-outline-secondary">Hủy bỏ</a>
                                </div>
                            </form>

                            <c:if test="${successMessage != null}">
                                <div class="alert alert-success mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-check-circle me-2 fs-5"></i>
                                    <div>${successMessage}</div>
                                </div>
                            </c:if>

                            <c:if test="${errorMessage != null}">
                                <div class="alert alert-danger mt-4 d-flex align-items-center" role="alert">
                                    <i class="fas fa-times-circle me-2 fs-5"></i>
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
