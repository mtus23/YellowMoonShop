<%-- 
    Document   : searchOrder
    Created on : Oct 18, 2020, 12:23:36 PM
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
        <title>Search Order Page</title>
        <style>
            .container{
                margin-top: 25px;
            }
            .nav-item{
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp"></c:redirect>
        </c:if>
        <c:if test="${sessionScope.user.roleId == 1}">
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
                    <c:if test="${sessionScope.user.roleId!=1}">
                        <li class="nav-item">
                            <a class="nav-item" href="cart.jsp">My cart</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.user.roleId==2}">
                        <li class="nav-item">
                            <a class="nav-item" href="listOrderHistory">My history</a>
                        </li>
                    </c:if>
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

        <div class="container mt-5">
            <form action="searchOrder">
                <div class="form-inline row d-flex justify-content-center">
                    <input type="text" name="txtOrderId" placeholder="Order Id" min="1" class="form-inline form-control m-3" required>
                    <input type="submit" value="Search" class="btn btn-primary form-inline m-3">
                </div>
            </form>
            <c:if test="${not empty requestScope.orderSearchError}">
                <div class="d-flex justify-content-center">
                    <h3>${requestScope.orderSearchError}</h3>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.listOrderError}">
                <div class="d-flex justify-content-center">
                    <h3>${requestScope.listOrderError}</h3>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.orderFound}">
                <div class="d-flex justify-content-center m-1 col">
                    Order ID : ${requestScope.orderFound.orderId}<br>
                    Name: ${requestScope.orderFound.name}<br>
                    Phone: ${requestScope.orderFound.phone}<br>
                    Address: ${requestScope.orderFound.address}<br>
                    Date: ${requestScope.orderFound.date}<br>
                    Payment: ${requestScope.orderFound.payment}<br>
                    Payment status: ${requestScope.orderFound.paymentStatus}
                    <hr>
                </div>
                <div class="d-flex justify-content-center">
                    <c:if test="${not empty requestScope.listOrderDetail}">
                        <div class="table col m-3">
                            <table border="1">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Name</th>
                                        <th>Price</th>
                                        <th>Quantity</th>
                                        <th>Total</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${requestScope.listOrderDetail}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${requestScope.mapProductName[item.productId]}</td>
                                            <td>${item.price} VND</td>
                                            <td>
                                                ${item.quantity}
                                            </td>
                                            <td>${item.price * item.quantity} VND</td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="2">
                                            <p>Total Bill</p>
                                        <td colspan="3">
                                            ${requestScope.orderFound.total} VND
                                        </td>
                                    </tr>

                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.listOrderHistory}">
                <c:forEach items="${requestScope.listOrderHistory}" var="order">
                    <div class="m-3 rounded border border-primary">

                        <div class="d-flex justify-content-center m-1 col">
                            Order ID : ${order.orderId}<br>
                            Name: ${order.name}<br>
                            Phone: ${order.phone}<br>
                            Address: ${order.address}<br>
                            Date: ${order.date}<br>
                            Payment: ${order.payment}<br>
                            Payment status: ${order.paymentStatus}
                            <hr>
                        </div>
                        <div class="d-flex justify-content-center">
                            <c:if test="${not empty requestScope.mapOrderDetail[order.orderId]}">
                                <div class="table col m-3">
                                    <table border="1">
                                        <thead>
                                            <tr>
                                                <th>No</th>
                                                <th>Name</th>
                                                <th>Price</th>
                                                <th>Quantity</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="item" items="${requestScope.mapOrderDetail[order.orderId]}" varStatus="counter">
                                                <tr>
                                                    <td>${counter.count}</td>
                                                    <td>${requestScope.mapProductName[item.productId]}</td>
                                                    <td>${item.price} VND</td>
                                                    <td>
                                                        ${item.quantity}
                                                    </td>
                                                    <td>${item.price * item.quantity} VND</td>
                                                </tr>
                                            </c:forEach>
                                            <tr>
                                                <td colspan="2">
                                                    <p>Total Bill</p>
                                                <td colspan="3">
                                                    ${order.total} VND
                                                </td>
                                            </tr>

                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <div class="d-flex justify-content-center">
                    <c:if test="${requestScope.currentPage != 1 && requestScope.numberOfPage != 1}">
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
                    </c:if>
                </div>
            </c:if>
        </div>
        <div class="d-flex justify-content-center col">
            <a href="search.jsp" class="m-3">Continue shopping</a><br>
            <a href="cart.jsp" class="m-3">Return cart page</a>
        </div>
    </body>

</html>
