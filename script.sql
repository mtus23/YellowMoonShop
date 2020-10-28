USE [master]
GO
/****** Object:  Database [J3LP0011]    Script Date: 10/18/2020 3:37:30 PM ******/
CREATE DATABASE [J3LP0011]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'J3LP0011', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\J3LP0011.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'J3LP0011_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\J3LP0011_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [J3LP0011] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [J3LP0011].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [J3LP0011] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [J3LP0011] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [J3LP0011] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [J3LP0011] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [J3LP0011] SET ARITHABORT OFF 
GO
ALTER DATABASE [J3LP0011] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [J3LP0011] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [J3LP0011] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [J3LP0011] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [J3LP0011] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [J3LP0011] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [J3LP0011] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [J3LP0011] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [J3LP0011] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [J3LP0011] SET  DISABLE_BROKER 
GO
ALTER DATABASE [J3LP0011] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [J3LP0011] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [J3LP0011] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [J3LP0011] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [J3LP0011] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [J3LP0011] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [J3LP0011] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [J3LP0011] SET RECOVERY FULL 
GO
ALTER DATABASE [J3LP0011] SET  MULTI_USER 
GO
ALTER DATABASE [J3LP0011] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [J3LP0011] SET DB_CHAINING OFF 
GO
ALTER DATABASE [J3LP0011] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [J3LP0011] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [J3LP0011] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'J3LP0011', N'ON'
GO
ALTER DATABASE [J3LP0011] SET QUERY_STORE = OFF
GO
USE [J3LP0011]
GO
/****** Object:  User [user]    Script Date: 10/18/2020 3:37:30 PM ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCategory](
	[categoryId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_tblCategory] PRIMARY KEY CLUSTERED 
(
	[categoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLog]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLog](
	[logId] [int] IDENTITY(1,1) NOT NULL,
	[userId] [varchar](50) NULL,
	[productId] [int] NULL,
	[date] [date] NULL,
	[status] [bit] NULL,
 CONSTRAINT [PK_tblLog] PRIMARY KEY CLUSTERED 
(
	[logId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrder]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrder](
	[orderId] [uniqueidentifier] NOT NULL,
	[userId] [varchar](50) NULL,
	[total] [int] NULL,
	[date] [datetime] NULL,
	[phone] [varchar](10) NULL,
	[address] [varchar](50) NULL,
	[payment] [varchar](50) NULL,
	[name] [varchar](50) NULL,
	[paymentStatus] [bit] NULL,
 CONSTRAINT [PK_tblOrder] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderDetail](
	[detailId] [int] IDENTITY(1,1) NOT NULL,
	[orderId] [uniqueidentifier] NULL,
	[productId] [int] NULL,
	[price] [int] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_tblOrderDetail] PRIMARY KEY CLUSTERED 
(
	[detailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[productId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[price] [int] NULL,
	[quantity] [int] NULL,
	[categoryId] [int] NULL,
	[createDate] [date] NULL,
	[expirationDate] [date] NULL,
	[image] [varchar](max) NULL,
	[status] [bit] NULL,
	[description] [varchar](max) NULL,
 CONSTRAINT [PK_tblProduct] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRole]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 10/18/2020 3:37:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[userId] [varchar](50) NOT NULL,
	[name] [nvarchar](60) NULL,
	[phone] [varchar](10) NULL,
	[address] [varchar](50) NULL,
	[roleId] [int] NULL,
	[password] [varchar](64) NULL,
	[status] [bit] NULL,
	[facebookId] [varchar](50) NULL,
	[link] [varchar](100) NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblCategory] ON 

INSERT [dbo].[tblCategory] ([categoryId], [name]) VALUES (1, N'Mlem Mlem')
INSERT [dbo].[tblCategory] ([categoryId], [name]) VALUES (2, N'Ice cream')
INSERT [dbo].[tblCategory] ([categoryId], [name]) VALUES (3, N'Mochi mochi')
INSERT [dbo].[tblCategory] ([categoryId], [name]) VALUES (4, N'matcha')
SET IDENTITY_INSERT [dbo].[tblCategory] OFF
SET IDENTITY_INSERT [dbo].[tblLog] ON 

INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (1, N'admin', 2, CAST(N'2020-10-17' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (2, N'admin', 2, CAST(N'2020-10-17' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (3, N'admin', 7, CAST(N'2020-10-17' AS Date), 1)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (4, N'admin', 8, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (5, N'admin', 8, CAST(N'2020-10-18' AS Date), 1)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (6, N'admin', 1, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (7, N'admin', 1, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (8, N'admin', 1, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (9, N'admin', 1, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (10, N'admin', 1, CAST(N'2020-10-18' AS Date), 1)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (11, N'admin', 2, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (12, N'admin', 2, CAST(N'2020-10-18' AS Date), 1)
SET IDENTITY_INSERT [dbo].[tblLog] OFF
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'ae3cc4d5-6ca7-4400-b118-26dafcd00f2b', N'user', 315000, CAST(N'2020-10-18T15:00:33.507' AS DateTime), N'0123456789', N'user no address', N'cash', N'user', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'2315549b-6118-4252-aeb4-33b63db63c19', N'1543003839216456', 15000, CAST(N'2020-10-18T15:05:23.850' AS DateTime), N'0123456789', N'OwO', N'cash', N'Nguyen Tu', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'05348cb6-c276-4c74-821a-9978edf0c70c', N'1543003839216456', 215000, CAST(N'2020-10-18T15:23:26.583' AS DateTime), N'1234567890', N'OwO', N'cash', N'Nguyen Tu', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'294790b0-54a9-49ed-89ce-a6590428edbc', NULL, 200000, CAST(N'2020-10-18T12:16:06.040' AS DateTime), N'0929188942', N'', N'cash', N'q', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', NULL, 200000, CAST(N'2020-10-18T12:19:46.993' AS DateTime), N'0929188942', N'', N'cash', N'q', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'613cd46b-4a96-4f37-abdc-be041d466da5', N'user', 200000, CAST(N'2020-10-18T14:01:41.210' AS DateTime), N'0123456789', N'user no address', N'cash', N'user', 0)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (1, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (2, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (3, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 3, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (4, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (5, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (6, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 3, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (7, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (8, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (9, N'1e48443c-72a0-4595-a89e-bc4b4afd5d40', 3, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (10, N'613cd46b-4a96-4f37-abdc-be041d466da5', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (11, N'613cd46b-4a96-4f37-abdc-be041d466da5', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (12, N'613cd46b-4a96-4f37-abdc-be041d466da5', 3, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (13, N'613cd46b-4a96-4f37-abdc-be041d466da5', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (14, N'613cd46b-4a96-4f37-abdc-be041d466da5', 3, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (15, N'613cd46b-4a96-4f37-abdc-be041d466da5', 9, 40000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (16, N'613cd46b-4a96-4f37-abdc-be041d466da5', 5, 60000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (17, N'613cd46b-4a96-4f37-abdc-be041d466da5', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (18, N'613cd46b-4a96-4f37-abdc-be041d466da5', 4, 15000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (19, N'613cd46b-4a96-4f37-abdc-be041d466da5', 4, 15000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (20, N'613cd46b-4a96-4f37-abdc-be041d466da5', 9, 40000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (21, N'613cd46b-4a96-4f37-abdc-be041d466da5', 6, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (22, N'613cd46b-4a96-4f37-abdc-be041d466da5', 4, 15000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (23, N'613cd46b-4a96-4f37-abdc-be041d466da5', 5, 60000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (24, N'613cd46b-4a96-4f37-abdc-be041d466da5', 2, 50000, 1)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (1, N'Ice Cream moon cake', 100000, 1, 2, CAST(N'2020-10-01' AS Date), CAST(N'2020-10-18' AS Date), N'https://img.buzzfeed.com/buzzfeed-static/static/2016-02/5/17/enhanced/webdr06/original-4622-1454712678-3.jpg?downsize=700%3A%2A&output-quality=auto&output-format=auto', 1, N'ice cream mlem mlem moon cake')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (2, N'Cat moon cake', 50000, 0, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-18' AS Date), N'https://www.foodline.sg/PageImage/Caterer/Cat-N-the-Fiddle/13114_large.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (3, N'Cat moon cake', 50000, 0, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-31' AS Date), N'https://www.foodline.sg/PageImage/Caterer/Cat-N-the-Fiddle/13114_large.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (4, N'green onion moon cake', 15000, 3, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-31' AS Date), N'https://kenh14cdn.com/2020/8/14/1172349593071117038673975273538172645457402n-15974118098931676887622.jpg', 1, N'good for health')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (5, N'black sugar bubble moon cake', 60000, 3, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://kenh14cdn.com/2020/8/14/screen-shot-2020-08-14-at-203106-1597411944949623966349.png', 1, N'black sugar bubble moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (6, N'Cat moon cake', 50000, 4, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://www.foodline.sg/PageImage/Caterer/Cat-N-the-Fiddle/13114_large.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (7, N'Cat moon cake', 50000, 5, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://kenh14cdn.com/2020/8/14/11738582819616225373070781753365817642725541o-1597411595710504519456-159741161503369450444.png', 0, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (8, N'matcha moon cake', 70000, 10, 4, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-18' AS Date), N'https://i.pinimg.com/736x/f5/ff/80/f5ff80fc90dcbdb24bcffeacd507140b.jpg', 0, N'matcha moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (9, N'matcha moon cake', 40000, 48, 4, CAST(N'2020-10-01' AS Date), CAST(N'2020-11-08' AS Date), N'https://i.pinimg.com/originals/c1/4b/be/c14bbe057187b47bc12f316bb8862cf0.jpg', 1, N'matcha mlem mlem')
SET IDENTITY_INSERT [dbo].[tblProduct] OFF
SET IDENTITY_INSERT [dbo].[tblRole] ON 

INSERT [dbo].[tblRole] ([roleId], [name]) VALUES (1, N'admin')
INSERT [dbo].[tblRole] ([roleId], [name]) VALUES (2, N'user')
SET IDENTITY_INSERT [dbo].[tblRole] OFF
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password], [status], [facebookId], [link]) VALUES (N'1543003839216456', N'Nguyễn Tú', NULL, NULL, 2, NULL, 1, N'1543003839216456', NULL)
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password], [status], [facebookId], [link]) VALUES (N'admin', N'admin', N'0123456789', N'admin no address', 1, N'8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 1, NULL, NULL)
INSERT [dbo].[tblUser] ([userId], [name], [phone], [address], [roleId], [password], [status], [facebookId], [link]) VALUES (N'user', N'user', N'0123456789', N'user no address', 2, N'04f8996da763b7a969b1028ee3007569eaf3a635486ddab211d512c85b9df8fb', 1, NULL, NULL)
ALTER TABLE [dbo].[tblOrder] ADD  CONSTRAINT [DF_tblOrder_orderId]  DEFAULT (newid()) FOR [orderId]
GO
USE [master]
GO
ALTER DATABASE [J3LP0011] SET  READ_WRITE 
GO
