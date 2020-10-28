<%-- 
    Document   : search
    Created on : Oct 9, 2020, 2:23:02 PM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- CSS only -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <title>Yellow Moon Shop</title>
        <style>
            .container{
                margin-top: 25px;
            }
            img{
                width: 200px;
                height: 250px;
            }
        </style>
    </head>
    <body>


        <nav class="navbar navbar-light" style="background-color: #e3f2fd;">
            <a class="nav-item" href="search.jsp">Search Page</a>
            <c:if test="${sessionScope.User.roleId!=1}">
                <a class="nav-item" href="cart.jsp">My cart</a>
            </c:if>
                <c:if test="${sessionScope.User.roleId==2}">
                <a class="nav-item" href="searchOrder.jsp">My history</a>
            </c:if>
            <c:if test="${sessionScope.User.roleId == 1}">
                <a class="nav-item" href="ListAllCakeController">List all Cake</a>
                <a class="nav-item" href="ListAllCategoryController">List all Category</a>
                <a class="nav-item" href="ListLogController">List all Log</a>
            </c:if>
            <c:if test="${empty sessionScope.User}">
                <a href="login.jsp" class="nav-item my-2"><button class="btn btn-primary">login</button></a>

            </c:if>  
            <c:if test="${not empty sessionScope.User}">
                <a class="nav-item my-2" href="LogoutController"><button class="btn btn-primary">Logout</button></a>
            </c:if>
        </nav>


        <div class="container mt-5">
            <c:if test="${not empty sessionScope.User}">
                <h1>Hello ${sessionScope.User.name}</h1>
            </c:if>
            <div class="mt-5">
                <div class="d-flex justify-content-center m-3">
                    <form action="SearchCakeController" method="POST">
                        <div class="form-inline">
                            <label class="m-3">Search Cake:</label>
                            <input class="form-control m-3" type="text" name="txtProductNameSearch" value="${param.txtProductNameSearch}" placeholder="Cake Name">
                            <label class="m-1">Category: </label>
                            <select name="cboCategory" class="form-control ml-3">
                                <option>------All------</option>
                                <c:forEach var="cate" items="${sessionScope.ListCategory}">
                                    <option value="${cate.categoryId}" ${cate.categoryId eq param.cobCategory ? 'selected' : ''}>${cate.name}</option>
                                </c:forEach>
                            </select>
                            <label class="ml-3" id="lbPriceRange">Range : 0 - </label>
                            <label class="ml-1" id="lbRange"> ${param.rgPrice != null ? param.rgPrice: 50000}</label>
                            <input type="range" name="rgPrice" min="0" max="1000000" value="${param.rgPrice}" class="form-control ml-3" onchange="document.getElementById('lbRange').innerHTML = this.value">
                            <input type="submit" class="btn btn-primary form-control ml-3" value="Search">
                        </div>
                    </form>
                    <div>
                        <hr>
                        <c:if test="${not empty requestScope.ErrorSEarch}">
                            <p style="color: red;">${requestScope.ErrorSearch}</p>
                        </c:if>
                    </div>
                </div>
                <hr>
                <div class="row">
                    
                    <c:if test="${not empty requestScope.searchResult}">
                        <c:set var="currentPage" value="${requestScope.currentPage}"></c:set>
                        <c:set var="numberOfPage" value="${requestScope.numberOfPage}"></c:set>
                        <c:set var="searchResult" value="${requestScope.searchResult}"></c:set>
                        <c:forEach var="dto" items="${requestScope.searchResult}">
                            <div class="card m-3" style="width: 18rem;">
                                <c:url var="image" value="${dto.image}"></c:url>
                                <img class="card-img-top" src="${image}" alt="Card image cap">
                                <div class="card-body">
                                    <h5 class="card-title">${dto.name}</h5>
                                    <p class="card-text">${dto.price} VND</p>
                                    <c:if test="${sessionScope.User.roleId != 1}">
                                        <form action="AddToCartController" method="POST">
                                            <input type="hidden" name="cboCategory" value="${param.cboCategory}">
                                            <input type="hidden" name="txtProductNameSearch" value="${param.txtProductNameSearch}">
                                            <input type="hidden" name="rgPrice" value="${param.rgPrice}">
                                            <input type="hidden" name="txtProductId" value="${dto.productId}">
                                            <input type="submit" class="btn btn-primary" value="Add to cart">
                                        </form>
                                        </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                        <div class="col">
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
                </div>
            </div>
    </body>
    <script>
        function updateRangePrice() {
            var range = document.getElementById('rgPrice').value;
            document.getElementById('range').innerHTML = range;
        }
    </script>
</html>
