<%-- 
    Document   : login
    Created on : Sep 18, 2020, 2:19:12 AM
    Author     : DELL
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- CSS only -->
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
            </ul>
            <span class="nav-item my-2">
                <c:if test="${empty sessionScope.user}">
                    <a href="login.jsp" class="nav-item my-2"><button class="btn btn-primary">login</button></a>
                </c:if>
            </span>
        </div>
    </nav>
        <c:if test="${not empty requestScope.userNotAuthenticated}">
            <div class="alert alert-danger" role="alert">
                ${requestScope.userNotAuthenticated}
            </div>
        </c:if>
    <body class="text-center">
        <div class="container">
            <div class="row justify-content-center mt-5">
                <aside class="col-sm-4">
                    <div class="card align-center">
                        <article class="card-body">
                            <h4 class="card-title text-center mb-4 mt-1">Login</h4>
                            <hr>
                            <c:if test="${not empty requestScope.loginError}">
                                <p style="color: red">${requestScope.loginError}</p>
                                <hr>
                            </c:if>
                                <form action="login" method="POST">
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-user"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="User ID" type="text" name="txtUserId" value="">
                                    </div> 
                                </div> 
                                <div class="form-group">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"> <i class="fa fa-lock"></i> </span>
                                        </div>
                                        <input class="form-control" placeholder="Password" type="password" name="txtPassword" value="">
                                    </div> 
                                </div> 
                                <div class="form-group">
                                    <input type="submit" class="btn btn-primary btn-block" name="btnAction" value="Login">
                                </div> 
                            </form>
                            <hr>
                            <p class="text-center"><a href="https://www.facebook.com/dialog/oauth?client_id=3350648078375882&redirect_uri=http://localhost:8084/NguyenHoangMinhTu_Lab2/loginFacebook"><button class="btn btn-light btn-block">Login by Facebook</button></a></p>
                            <hr>
                            <a class="text-center" href="search.jsp">Return search page</a>
                        </article>
                    </div>
                </aside>
            </div>
        </div> 
</html>
