<%-- 
    Document   : listCategory
    Created on : Oct 11, 2020, 11:25:13 AM
    Author     : DELL
--%>

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
        <style>
            .nav-item{
                margin-right: 5px;
            }
        </style>
    </head>
    <body>
        <c:if test="${empty sessionScope.user || sessionScope.user.roleId == 2}">
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
                    <li class="nav-item">
                        <a class="nav-item" href="listAllCake">List all Cake</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item" href="listAllCategory">List all Category</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-item" href="listLog">List all Log</a>
                    </li>
                </ul>
                <span class="nav-item my-2">
                    <c:if test="${empty sessionScope.uer}">
                        <a href="login.jsp" class="nav-item my-2"><button class="btn btn-primary">login</button></a>
                    </c:if>  
                    <c:if test="${not empty sessionScope.user}">
                        <a class="nav-item my-2" href="logout"><button class="btn btn-primary">Logout</button></a>
                    </c:if>
                </span>
            </div>
        </nav>

        <div class="container mt-5">
            <c:if test="${not empty requestScope.updateCategoryError}">
                <p style="color:red;">${requestScope.updateCategoryError}</p>
            </c:if>
            <c:if test="${not empty requestScope.listAllCate}">
                <table border="1" class="table">
                    <thead>
                        <tr>
                            <th>Category ID</th>
                            <th>Name</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cate" items="${requestScope.listAllCate}">
                            <tr>
                        <form action="updateCategory" method="POST">
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
                <div class="col">
                    <div class="d-flex justify-content-center">
                        <c:if test="${requestScope.currentPage != 1 && requestScope.numberOfPage != 1}">

                            <c:if test="${requestScope.currentPage != 1}">
                                <c:url var="previousPage" value="listAllCategory">
                                    <c:param name="txtCurrentPage" value="${currentPage - 1}"/>
                                </c:url>
                                <a href="${previousPage}">Previous</a>
                            </c:if>
                            Page ${requestScope.currentPage} / ${requestScope.numberOfPage}
                            <c:if test="${requestScope.currentPage < requestScope.numberOfPage}">
                                <c:url var="nextPage" value="listAllCaregory">
                                    <c:param name="txtCurrentPage" value="${currentPage - 1}"/>
                                </c:url>
                                <a href="${nextPage}">Next</a>
                            </c:if>
                        </c:if>
                        <br>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.listAllCateError}">
                    <p style="color: red;">${requestScope.listAllCateError}</p>
                </c:if>
                <div class="d-flex justify-content-center">
                    <form action="createCategory" method="POST">
                        <div class="form-inline">
                            <label>Create new category:</label>
                            <input class="form-control m-3" type="text" name="txtCategoryNameNew" required
                                   <c:if test="${not empty param.txtCategoryNameNew}">
                                       value="${param.txtCategoryNameNew}"
                                   </c:if>
                                   >
                            <input type="submit" class="btn btn-primary form-control" value="Create">
                        </div>
                    </form>
                </div>
                <div class="d-flex justify-content-center">
                    <c:if test="${not empty requestScope.createCategoryError}">
                        <p style="color: red;">${requestScope.createCategoryError}</p> 
                    </c:if>
                </div>
            </div>
        </div>
    </body>
</html>
