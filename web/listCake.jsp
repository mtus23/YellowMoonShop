<%-- 
    Document   : listCake
    Created on : Oct 10, 2020, 1:48:30 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List cake Page</title>
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <style>
            img{
                width: 50px;
                height: 50px;
            }
            p{
                font-size: 75%;
            }
            .table {
                display: table;
                width: 100%;
            }

            .width-lg {
                width: 350px !important;
            }
            .width-md {
                width: 200px !important;
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
        <div class="container mt-5">
            <c:if test="${not empty requestScope.ListCakeResult}">
                <table border="2" width="1" cellspacing="1" class="table">

                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th class="width-lg">Description</th>
                            <th>Quantity</th>
                            <th class="width-lg">Category</th>
                            <th class="width-md">Create Date</th>
                            <th class="width-md">Expiration Date</th>
                            <th>Image</th>
                            <th>status</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="dto" items="${requestScope.ListCakeResult}">
                            <tr>

                                <td>${dto.productId}</td>
                                <td>${dto.name}</td>
                                <td>${dto.price} VND</td>
                                <td>${dto.description}</td>
                                <td>${dto.quantity}</td>
                                <td>
                                    <select class="form-control" name="txtCategory" >
                                        <c:forEach var="cate" items="${sessionScope.ListCategory}">
                                            <option ${cate.categoryId eq dto.categoryId ? 'selected' : ''} value="${cate.categoryId}" disabled>${cate.name}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><p style="width:125%;">${dto.createDate}</p></td>
                                <td><p>${dto.expirationDate}</p></td>
                                <c:url var="image" value="${dto.image}"></c:url>
                                <td><img src="${image}"></td>
                                <td><input type="checkbox" ${dto.status == 'true'?'checked':''} value="true" name="cbStatus" disabled="disabled"></td>
                        
                        <td>
                            <c:url value="updateCake.jsp" var="updateCake">
                                <c:param name="txtCurrentPage" value="${requestScope.currentPage}"></c:param>
                                <c:param name="txtProductId" value="${dto.productId}"></c:param>
                                <c:param name="txtProductName" value="${dto.name}"></c:param>
                                <c:param name="txtPrice" value="${dto.price}"></c:param>
                                <c:param name="txtDescription" value="${dto.description}"></c:param>
                                <c:param name="txtQuantity" value="${dto.quantity}"></c:param>
                                <c:param name="cboCategory" value="${dto.categoryId}"></c:param>
                                <c:param name="txtCreateDate" value="${dto.createDate}"></c:param>
                                <c:param name="txtExpirationDate" value="${dto.expirationDate}"></c:param>
                                <c:param name="txtImage" value="${dto.image}"></c:param>
                                <c:param name="txtStatus" value="${dto.status}" ></c:param>
                            </c:url>
                            <a href="${updateCake}"><button class="btn btn-primary">Update Cake</button></a>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <br>
                <div class="d-flex justify-content-center">
                    <c:if test="${requestScope.currentPage != 1}">
                        <c:url var="previousPage" value="ListAllCakeController">
                            <c:param name="txtCurrentPage" value="${currentPage - 1}"/>
                        </c:url>
                        <a href="previousPage">Previous</a>
                    </c:if>
                    Page ${requestScope.currentPage} / ${requestScope.numberOfPage}
                    <c:if test="${requestScope.currentPage < requestScope.numberOfPage}">
                        <c:url var="nextPage" value="ListAllCakeController">
                            <c:param name="txtCurrentPage" value="${currentPage - 1}"/>
                        </c:url>
                        <a href="nextPage">Next</a>
                    </c:if>
                    <br>
                </c:if>
                <c:if test="${not empty requestScope.ListCakeEmptyError}">
                    <h3>${requestScope.ListCakeEmptyError}</h3>
                </c:if>
            </div>
            <a href="createCake.jsp"><button class="btn btn-primary">Create new Cake</button></a>
            <a href="ListAllCategoryController"><button class="btn btn-primary">List category</button></a>
        </div>
    </body>
</html>
