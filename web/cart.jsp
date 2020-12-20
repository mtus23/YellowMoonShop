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
            .nav-item{
                margin-right: 5px;
            }
        </style>
    </head>
    <body>

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
        <c:if test="${sessionScope.user.roleId == 1}">
            <c:redirect url="search.jsp"></c:redirect>
        </c:if>
        <c:if test="${not empty requestScope.updateSuccess}">
            <div class="alert alert-success" role="alert">
                ${requestScope.updateSuccess}
            </div>
        </c:if>
        <c:if test="${not empty requestScope.removeCartSuccess}">
            <div class="alert alert-success" role="alert">
                ${requestScope.removeCartSuccess}
            </div>
        </c:if>
        <div class="container mt-5">
            <div class="d-flex justify-content-center m-1">
                <h3>Your cart</h3>
                <hr>
            </div>
            <div class="d-flex justify-content-center m-1">
                <c:if test="${empty sessionScope.cart.items}">
                    <div class="m-3"> <h3>No items</h3></div>
                </c:if>
            </div>
            <div class="d-flex justify-content-center">
                <c:if test="${not empty sessionScope.cart.items}">
                    <div class="table col m-3">
                        <table border="1">
                            <form action="cart" method="POST">
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
                                    <c:forEach var="item" items="${sessionScope.cart.items}" varStatus="counter">
                                        <tr>
                                            <td>${counter.count}</td>
                                            <td>${item.key.name}</td>
                                            <td>${item.key.price} VND</td>
                                            <td>
                                                <input type="number" min="1" value="${item.value}" max="${item.key.quantity}" name="txtQuantity${item.key.productId}" onchange="updateData(${item.key.productId})" id="txtQuantity${item.key.productId}">
                                            </td>
                                            <td>${item.key.price * item.value} VND</td>
                                            <td> 
                                                <input type="hidden" name="txtProductId" value="${item.key.productId}">
                                                <input type="submit" name="btnAction" value="Remove product" class="btn btn-primary" onclick="return confirm('Are you sure you want to delete this product?');">
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="2">
                                            <p>Total Bill</p>
                                        </td>
                                        <td colspan="2">
                                            ${sessionScope.totalBill} VND
                                        </td>
                                        <td colspan="2">
                                            <input type="submit" name="btnAction" value="Update cart" class="btn btn-primary" ><br>
                                        </td>
                                    </tr>
                                </tbody>
                        </table>
                        </form>
                    </c:if>
                </div>

                <div class="d-flex justify-content-center">
                    <form action="checkOut" method="POST">
                        <div class="form-group row m-3">
                            <label>Name: </label>
                            <input name="txtCustomer" type="text" min="1" max="60" class="form-control"
                                   <c:if test="${not empty sessionScope.user}">
                                       value="${sessionScope.user.name}"
                                   </c:if>
                                   <c:if test="${not empty param.txtCustomer}">
                                       value="${param.txtCustomer}"
                                   </c:if>
                                   required >
                        </div>
                        <div class="form-group row m-3">
                            <label>Address: </label>
                            <input name="txtAddress" type="text" min="1" max="50" class="form-control"
                                   <c:if test="${not empty sessionScope.user}">
                                       value="${sessionScope.user.address}"
                                   </c:if>
                                   <c:if test="${not empty param.txtAddress}">
                                       value="${param.txtAddress}"
                                   </c:if>
                                   required >
                        </div>
                        <div class="form-group row m-3">
                            <label>Phone: </label>
                            <input name="txtPhone" type="text" class="form-control"
                                   <c:if test="${not empty sessionScope.user}">
                                       value="${sessionScope.user.phone}"
                                   </c:if>
                                   <c:if test="${not empty param.txtPhone}">
                                       value="${param.txtPhone}"
                                   </c:if>
                                   id="phoneNumber"
                                   required onblur="checkPhoneNumber()">
                        </div>
                        <div class="form-group row m-3">
                            <c:forEach var="item" items="${sessionScope.cart.items}">
                                <input type="hidden" min="1" value="${item.value}" max="${item.key.quantity}" name="txtQuantity${item.key.productId}" id="txtQuantityHidden${item.key.productId}">
                            </c:forEach>
                            <input class="btn btn-primary" type="submit" value="Checkout" name="btnAction">
                        </div>
                    </form>
                </div>
                
            </div>
            <div class="d-flex justify-content-center row">
                    <c:if test="${not empty requestScope.checkOutError}">
                        <p style="color: red;">${requestScope.checkOutError}</p>
                    </c:if>
                    <c:if test="${not empty requestScope.outOfBoundCakeError}">
                        <div class="alert alert-danger" role="alert">
                            <h4 class="alert-heading">Error! Not enough cake</h4>
                            <c:forEach var="error" items="${requestScope.outOfBoundCakeError}">
                                <p>${error}</p>
                            </c:forEach>
                        </div>
                    </c:if>
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
        function updateData(id) {
            var x = document.getElementById('txtQuantity'+id).value;
            document.getElementById('txtQuantityHidden'+id).value = x;
            console.log();
        }
    </script>
</html>
