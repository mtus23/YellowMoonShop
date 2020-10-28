<%-- 
    Document   : listCategory
    Created on : Oct 11, 2020, 11:25:13 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Category Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

    </head>
    <body>
        <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <a class="nav-item" href="search.jsp">Search Page</a>
            <a class="nav-item" href="ListAllCakeController">List all Cake</a>
            <a class="nav-item" href="ListAllCategoryController">List all Category</a>
            <a class="nav-item" href="ListLogController">List all Log</a>
            <a class="nav-item my-2" href="LogoutController"><button class="btn btn-primary">Logout</button></a>
        </nav>
        <div class="container mt-5">
            <c:if test="${not empty requestScope.UpdateCategoryError}">
                <p style="color:red;">${requestScope.UpdateCategoryError}</p>
            </c:if>
            <c:if test="${not empty sessionScope.ListCategory}">
                <table border="1" class="table">
                    <thead>
                        <tr>
                            <th>Category ID</th>
                            <th>Name</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cate" items="${sessionScope.ListCategory}">
                            <tr>
                        <form action="UpdateCategoryController" method="POST">
                            <th>${cate.categoryId}<input type="hidden" value="${cate.categoryId}" name="txtCategoryId" readonly></th>
                            <th>

                                <input type="text" value="${cate.name}" name="txtCategoryName">

                            </th>
                            <th><input type="submit" value="Update" class="btn btn-primary"></th>
                        </form>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty requestScope.ListAllCateError}">
                <p style="color: red;">${requestScope.ListAllCateError}</p>
            </c:if>
            <div class="d-flex justify-content-center">
                <form action="CreateCategoryController" method="POST">
                    <div class="form-inline">
                        <label>Create new category:</label>
                        <input class="form-control m-3" type="text" name="txtCategoryName" value="">
                        <input type="submit" class="btn btn-primary form-control" value="Create">
                    </div>
                </form>
            </div>
            <div class="d-flex justify-content-center">
                <c:if test="${not empty requestScope.CreateCategoryError}">
                    <p style="color: red;">${requestScope.CreateCategoryError}</p> 
                </c:if>
            </div>
        </div>
    </body>
</html>
