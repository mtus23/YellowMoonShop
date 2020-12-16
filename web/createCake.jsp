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
            .nav-item{
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <c:if test="${empty sessionScope.user || sessionScope.user.roleId == 2}">
            <c:redirect url="search.jsp"></c:redirect>
        </c:if>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: #e3f2fd;">
            <a class="navbar-brand" href="search.jsp">Yellow Moon</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarText">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                    <li class="nav-item">  
                        <a class="nav-item" href="search.jsp">Search Page</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item" href="listAllCake">List all Cake</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item" href="listAllCategory">List all Category</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item" href="listLog">List all Log</a>
                    </li>
                </ul>
                <span class="nav-item my-2">
                    <c:if test="${empty sessionScope.user}">
                        <a href="login.jsp" class="nav-item my-2"><button class="btn btn-primary">login</button></a>
                    </c:if>  
                    <c:if test="${not empty sessionScope.user}">
                        <a class="nav-item my-2" href="logout"><button class="btn btn-primary">Logout</button></a>
                    </c:if>
                </span>
            </div>
        </nav>

        <jsp:useBean id="now" class="java.util.Date" />
        <fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd"/>
        <div class="container">
            <div class="col mt-5 justify-center">
                <form action="createCake" class="need-validate" method="POST" enctype="multipart/form-data">
                    <div class="form-group">
                        <div class="form-group row d-flex justify-content-center">
                            <h3>Insert new moon cake</h3>

                        </div>
                        <hr>
                        <div class="form-group row">
                            <label>Name: </label>
                            <input type="text" name="txtProductName" required class="form-control" value="${param.txtProductName}" onchange="this.value = this.value.trim()">
                        </div>
                        <div class="form-group row">
                            <label>Image:</label>
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" id="file" name="txtImage" accept="image/png,image/jpeg" onchange="validateImage()" required>
                                <label class="custom-file-label" for="inputGroupFile01" id="fileLabel">Choose file</label>
                            </div>
                        </div>
                        <c:if test="${not empty requestScope.errorImage}">
                            <div class="d-flex justify-content-center">
                                <p style="color: red;">${requestScope.errorImage}</p>
                            </div>
                        </c:if>
                        <div class="form-group row">
                            <label>Description:</label>
                            <textarea class="form-control" id=description" row="3" name="txtDescription" required onchange="this.value = this.value.trim()">${param.txtDescription}</textarea>
                        </div>
                        <div class="form-group row">
                            <label>Price: </label>
                            <input type="number" name="txtPrice" required class="form-control" min="1" max="1000000" value="${param.txtPrice}">
                        </div>
                        <div class="form-group row">
                            <label>Quantity: </label>
                            <input type="number" name="txtQuantity" required class="form-control" min="1" max="1000" value="${param.txtQuantity}">
                        </div>
                        <div class="form-group row">
                            <label>Expiration Date:</label>
                            <input type="date" name="txtExpirationDate" min="${today}" id="endDate"
                                   <c:if test="${not empty param.txtExpirationCate}"> value="${param.txtExpirationCate}"</c:if>
                                       class="form-control" required onchange="testDate()">
                            </div>
                            <div class="form-group row">
                                <label>Category: </label>
                                <select name="cboCategory" class="form-control">
                                <c:forEach var="cate" items="${sessionScope.listCategory}">
                                    <option value="${cate.categoryId}" ${param.cboCategory == cate.categoryId ? 'selected' : ''}>${cate.name}</option>
                                </c:forEach>
                            </select>
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
        function testDate() {
            var start = new Date().getTime();
            var end = document.getElementById("endDate").value;
            if (start !== null && end !== null) {
                if ((new Date(start).getTime() >= new Date(end).getTime())) {
                    alert('Expiration date must be after today');
                    document.getElementById("endDate").value = '';
                } else {
                    var oneYearAfter = new Date(new Date().setFullYear(new Date().getFullYear() + 1));
                    if (new Date(end).getTime() > oneYearAfter.getTime()) {
                        alert('Expiration date must less than 1 year from now');
                        document.getElementById("endDate").value = '';
                    }
                }
            }
        }
        function validateImage() {
            var fileInput =
                    document.getElementById("file");

            var filePath = fileInput.value;

            // Allowing file type 
            var allowedExtensions =
                    /(\.jpg|\.jpeg|\.png|\.gif)$/i;

            if (!allowedExtensions.exec(filePath)) {
                alert('Invalid file type');
                fileInput.value = '';
            } else {
                var name = filePath.split(/(\\|\/)/g).pop();
                document.getElementById("fileLabel").innerHTML = name;
            }
            return true;
        }
    </script>
</html>
