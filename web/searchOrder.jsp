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

            <c:if test="${empty sessionScope.User}">
                <a href="login.jsp" class="nav-item my-2"><button class="btn btn-primary">login</button></a>

            </c:if>  
            <c:if test="${not empty sessionScope.User}">
                <a class="nav-item my-2" href="LogoutController"><button class="btn btn-primary">Logout</button></a>
            </c:if>
        </nav>
        <div class="container mt-5">
            <form action="SearchOrderController">
                <div class="form-inline row d-flex justify-content-center">
                    <input type="text" name="txtOrderId" placeholder="Order Id" min="1" class="form-inline form-control m-3">
                    <input type="submit" value="Search" class="btn btn-primary form-inline m-3">
                </div>
            </form>
            <c:if test="${not empty requestScope.OrderSearchError}">
                <div class="d-flex justify-content-center">
                    <h3>${requestScope.OrderSearchError}</h3>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.OrderFound}">
                <div class="d-flex justify-content-center m-1 col">
                    Name: ${requestScope.OrderFound.name}<br>
                    Phone: ${requestScope.OrderFound.phone}<br>
                    Address: ${requestScope.OrderFound.address}<br>
                    Date: ${requestScope.OrderFound.date}<br>
                    Payment: ${requestScope.OrderFound.payment}<br>
                    Payment status: ${requestScope.OrderFound.paymentStatus}
                    <hr>
                </div>
                <div class="d-flex justify-content-center">
                    <c:if test="${not empty requestScope.ListOrderDetail}">
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
                                    <c:forEach var="item" items="${requestScope.ListOrderDetail}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${requestScope.MapProductName[item.productId]}</td>
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
                                        ${requestScope.OrderFound.total} VND
                                        </td>
                                    </tr>

                                </tbody>
                            </table>

                        </c:if>
                    </div>
                </div>
            </c:if>
        </div>
        <div class="d-flex justify-content-center col">
            <a href="search.jsp" class="m-3">Continue shopping</a><br>
            <a href="cart.jsp" class="m-3">Return cart page</a>
        </div>
    </body>

</html>
