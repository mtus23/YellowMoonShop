<%-- 
    Document   : confirm
    Created on : Oct 18, 2020, 9:46:42 AM
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
        <title>Confirm Page</title>
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
            <c:if test="${empty requestScope.AddSuccess}">
                <div class="d-flex justify-content-center m-1">
                    <h3>Please confirm before progressing</h3>
                    <hr>
                </div>
                <div class="d-flex justify-content-center m-1">
                    <c:if test="${empty sessionScope.Cart}">
                        <div class="m-3"> <h3>No items</h3></div>
                    </c:if>
                </div>
                <div class="d-flex justify-content-center m-1 col">
                    Name: ${requestScope.CustomerName}<br>
                    Address: ${requestScope.CustomerAddress}<br>
                    Phone: ${requestScope.CustomerPhone}<br>
                    <hr>
                </div>
                <div class="d-flex justify-content-center">
                    <c:if test="${not empty sessionScope.Cart.items}">
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
                                    <c:forEach var="item" items="${sessionScope.Cart.items}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${item.key.name}</td>
                                            <td>${item.key.price} VND</td>
                                            <td>
                                                ${item.value}
                                            </td>
                                            <td>${item.key.price * item.value} VND</td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="2">
                                            <p>Total Bill</p>
                                        <td colspan="3">
                                            ${sessionScope.TotalBill} VND
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </c:if>
                    </div>
                </div>
                <div class="d-flex justify-content-center">
                    <form action="ProccessPaymentController" method="POST">
                        <input type="hidden" name="txtCustomerName" value="${requestScope.CustomerName}" />
                        <input type="hidden" name="txtCustomerAddress" value="${requestScope.CustomerAddress}" />
                        <input type="hidden" name="txtCustomerPhone" value="${requestScope.CustomerPhone}" />
                        <input type="submit" value="Checkout" class="btn btn-primary"
                               onclick="return confirm('Are you sure you want to continue?');"/>
                    </form>
                </div>
            </c:if>
            <div class="d-flex justify-content-center row">
                <c:if test="${not empty requestScope.AddSuccess}">
                    <p class="m-3">${requestScope.AddSuccess}</p><br>
                    <p class="m-3">Your Order Id is : ${requestScope.OrderId}</p>
                    <script>
                        alert("Checkout successfully");
                    </script>
                    <br>
                </c:if>
            </div>
            <div class="d-flex justify-content-center col">
                <a href="search.jsp" class="m-3">Continue shopping</a><br>
                <a href="cart.jsp" class="m-3">Return cart page</a>
            </div>
    </body>

</html>
