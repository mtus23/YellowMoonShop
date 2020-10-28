<%-- 
    Document   : createCake
    Created on : Oct 11, 2020, 11:03:36 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Cake Page</title>
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <style>
            textarea{
                resize: none;
                white-space: pre-wrap;
            }
        </style>
    </head>
    <body>
        <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <a class="nav-item" href="search.jsp">Search Page</a>
            <a class="nav-item" href="ListAllCakeController">List all Cake</a>
            <a class="nav-item" href="ListAllCategoryController">List all Category</a>
            <a class="nav-item" href="ListLogController">List all Log</a>
            <a class="nav-item my-2" href="LogoutController"><button class="btn btn-primary">Logout</button></a>
        </nav>
        <jsp:useBean id="now" class="java.util.Date" />
    <fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd" />
    <div class="container">
        <div class="col mt-5 justify-center">
            <form action="CreateCakeController" class="need-validate" method="POST">
                <div class="form-group">
                    <div class="form-group row d-flex justify-content-center">
                        <h3>Insert new moon cake</h3>

                    </div>
                    <hr>
                    <div class="form-group row">
                        <label>Name: </label>
                        <input type="text" name="txtProductName" required class="form-control" value="${param.txtProductName}">
                    </div>
                    <div class="form-group row">
                        <label>Image link:</label>
                        <input type="text" name="txtImage" required class="form-control" value="${param.txtImage}">
                    </div>
                    <c:if test="${not empty requestScope.ErrorImage}">
                        <div class="d-flex justify-content-center">
                            <p style="color: red;">${requestScope.ErrorImage}</p>
                        </div>
                    </c:if>
                    <div class="form-group row">
                        <label>Description:</label>
                        <textarea class="form-control" id=description" row="3" name="txtDescription" required>${param.txtDescription}</textarea>
                    </div>
                    <div class="form-group row">
                        <label>Price: </label>
                        <input type="number" name="txtPrice" required class="form-control" min="1" onchange="validateNumber()" max="1000000" value="${param.txtPrice}">
                    </div>
                    <div class="form-group row">
                        <label>Quantity: </label>
                        <input type="number" name="txtQuantity" required class="form-control" min="1" onchange="validateNumber()" max="1000" value="${param.txtQuantity}">
                    </div>
                    <div class="form-group row">
                        <label>Create Date:</label>
                        <input type="date" name="txtCreateDate" 
                               <c:if test="${not empty param.txtCreateDate}">value=${param.txtCreateDate}</c:if>
                               <c:if test="${empty param.txtCreateDate}">value="${today}"</c:if>
                                   class="form-control">
                               <label>Expiration Date:</label>
                               <input type="date" name="txtExpirationDate" 
                               <c:if test="${not empty param.txtExpirationCate}">value=${param.txtExpirationCate}</c:if>
                               <c:if test="${empty param.txtExpirationCate}">value="${today}"</c:if>
                                   class="form-control">
                               <br>
                        </div>
                    <c:if test="${not empty requestScope.ErrorDate}">
                        <div class="d-flex justify-content-center">
                            <p style="color: red;">${requestScope.ErrorDate}</p>
                        </div>
                    </c:if>
                    <div class="form-group row">
                        <label>Category: </label>
                        <select name="cboCategory" class="form-control">
                            <c:forEach var="cate" items="${sessionScope.ListCategory}">
                                <option value="${cate.categoryId}" ${param.cboCategory == cate.categoryId ? 'selected' : ''}>${cate.name}</option>
                            </c:forEach>
                        </select>
                        <br>
                    </div>
                    <div class="d-flex justify-content-center form-group row">
                        <input type="submit" class="btn btn-primary" value="Create">
                    </div>

                </div>
            </form>
        </div>
    </div>
</body>
<script>
    (function () {
        'use strict';
        window.addEventListener('load', function () {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('need-validate');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function (form) {
                form.addEventListener('submit', function (event) {
                    if (form.checkValidity() === false || validateImage() === false) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);
    })();
</script>
</html>
