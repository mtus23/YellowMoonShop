<%-- 
    Document   : error
    Created on : Sep 25, 2020, 9:38:59 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Error page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- JS, Popper.js, and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
        <style>
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
                    <c:if test="${sessionScope.user.roleId == 1}">
                        <li class="nav-item">
                            <a class="nav-item" href="listAllCake">List all Cake</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-item" href="listAllCategory">List all Category</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-item" href="listLog">List all Log</a>
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

        <h1>Something went wrong</h1>
        <a href="search.jsp">Return search page</a>
    </body>
</html>
