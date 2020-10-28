<%-- 
    Document   : cart
    Created on : Oct 17, 2020, 10:17:28 PM
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
        <title>Cart Page</title>
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
            <div class="d-flex justify-content-center m-1">
                <h3>Your cart</h3>
                <hr>
            </div>
            <div class="d-flex justify-content-center m-1">
                <c:if test="${empty sessionScope.Cart}">
                    <div class="m-3"> <h3>No items</h3></div>
                </c:if>
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
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            <form action="CartController" method="POST">
                                <c:forEach var="item" items="${sessionScope.Cart.items}" varStatus="counter">
                                    <tr>
                                        <td>${counter.count}</td>
                                        <td>${item.key.name}</td>
                                        <td>${item.key.price} VND</td>
                                        <td>
                                            <input type="number" min="1" value="${item.value}" name="txtQuantity${item.key.productId}">
                                        </td>
                                        <td>${item.key.price * item.value} VND</td>
                                        <td><input type="checkbox" name="cbItem" value="${item.key.productId}"></td>
                                    </tr>
                                </c:forEach>
                                <tr>
                                    <td>
                                        <p>Total Bill</p>
                                    </td>
                                    <td>
                                        ${sessionScope.TotalBill} VND
                                    </td>
                                    <td colspan="2">
                                        <input type="submit" name="btnAction" value="Update selected products" class="btn btn-primary" /><br>
                                    </td>
                                    <td colspan="2">
                                        <input type="submit" name="btnAction" value="Remove selected products" class="btn btn-primary" onclick="return confirm('Are you sure you want to delete these products?');"/>
                                    </td>
                                </tr>
                            </form>
                            </tbody>
                        </table>

                    </c:if>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <c:if test="${not empty requestScope.CheckOutError}">
                    <p style="color: red;">${requestScope.CheckOutError}</p>
                </c:if>
                <c:if test="${not empty requestScope.OutOfBoundCakeError}">
                    <c:forEach var="error" items="${requestScope.OutOfBoundCakeError}">
                    <p style="color: red;">${error}</p>
                    </c:forEach>
                </c:if>
            </div>

            <div class="d-flex justify-content-center">
                <form action="CheckOutController" method="POST">
                    <div class="form-group row">

                        <label>Name: </label>
                        <input name="txtCustomer" type="text" min="1" max="60" class="form-control"
                               <c:if test="${not empty sessionScope.User}">
                                   value="${sessionScope.User.name}"
                               </c:if>
                               <c:if test="${not empty param.txtCustomer}">
                                   value="${param.txtCustomer}"
                               </c:if>
                               required />
                    </div>
                    <div class="form-group row">
                        <label>Address: </label>
                        <input name="txtAddress" type="text" min="1" max="50" class="form-control"
                               <c:if test="${not empty sessionScope.User}">
                                   value="${sessionScope.User.address}"
                               </c:if>
                               <c:if test="${not empty param.txtAddress}">
                                   value="${param.txtAddress}"
                               </c:if>
                               required />
                    </div>
                    <div class="form-group row">
                        <label>Phone: </label>
                        <input name="txtPhone" type="text" class="form-control"
                               <c:if test="${not empty sessionScope.User}">
                                   value="${sessionScope.User.phone}"
                               </c:if>
                               <c:if test="${not empty param.txtPhone}">
                                   value="${param.txtPhone}"
                               </c:if>
                               required />
                    </div>
                    <div class="form-group d-flex justify-content-center">
                        <input class="btn btn-primary" type="submit" value="Checkout" onclick="checkPhoneNumber()">
                    </div>
                </form>
            </div>
        </div>
        <div class="d-flex justify-content-center">
            <a href="search.jsp">Continue shopping</a>
        </div>
    </body>
    <script>
        function checkPhoneNumber() {
            var x = document.getElementById("phoneNumber");
            var regex = /^[0-9]\d{9}$/;
            if (!x.value.match(regex))
            {
                alert("Phone number wrong fomat");
                x.value = '';
                return false;
            }
            return true;
        }
    </script>
</html>
