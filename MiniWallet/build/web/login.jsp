<%-- 
    Document : login 
    Created on : Dec 11, 2025, 11:06:25 PM 
    Author : dat20 
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="assets/css/main.css" />
        <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
        <link rel="stylesheet" href="assets/css/login.css" />
        <title>Đăng nhập</title>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4"> <div class="card">
                        <div class="card-header text-center bg-primary text-white">
                            <h3>Đăng nhập</h3>
                        </div>
                        <div class="card-body p-4">

                            <form action="login" method="post">

                                <div class="mb-3">
                                    <label for="user" class="form-label">Tên đăng nhập</label>
                                    <input type="text" class="form-control" id="user" name="username" 
                                           value="${username}" placeholder="Nhập tên đăng nhập" required>
                                </div>

                                <div class="mb-3">
                                    <label for="pass" class="form-label">Mật khẩu</label>
                                    <input type="password" class="form-control" id="pass" name="password" 
                                           value="${password}" placeholder="Nhập mật khẩu" required>
                                </div>

                                <div class="d-grid">
                                    <input type="submit" class="btn btn-primary" value="Đăng nhập">
                                </div>
                            </form>
                            <c:if test="${errorMessage != null}">
                                <div class="alert alert-danger mt-3 text-center" role="alert">
                                    ${errorMessage}
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
