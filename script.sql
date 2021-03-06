USE [master]
GO
/****** Object:  Database [NguyenHoangMinhTu_Lab2]    Script Date: 12/16/2020 1:53:51 PM ******/
CREATE DATABASE [NguyenHoangMinhTu_Lab2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'J3LP0011', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\J3LP0011.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'J3LP0011_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\J3LP0011_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NguyenHoangMinhTu_Lab2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ARITHABORT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET RECOVERY FULL 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET  MULTI_USER 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'NguyenHoangMinhTu_Lab2', N'ON'
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET QUERY_STORE = OFF
GO
USE [NguyenHoangMinhTu_Lab2]
GO
/****** Object:  User [user]    Script Date: 12/16/2020 1:53:52 PM ******/
CREATE USER [user] FOR LOGIN [user] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tblCategory]    Script Date: 12/16/2020 1:53:52 PM ******/
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
/****** Object:  Table [dbo].[tblLog]    Script Date: 12/16/2020 1:53:52 PM ******/
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
/****** Object:  Table [dbo].[tblOrder]    Script Date: 12/16/2020 1:53:52 PM ******/
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
/****** Object:  Table [dbo].[tblOrderDetail]    Script Date: 12/16/2020 1:53:52 PM ******/
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
/****** Object:  Table [dbo].[tblProduct]    Script Date: 12/16/2020 1:53:52 PM ******/
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
/****** Object:  Table [dbo].[tblRole]    Script Date: 12/16/2020 1:53:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRole](
	[roleId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
 CONSTRAINT [PK_tblRole] PRIMARY KEY CLUSTERED 
(
	[roleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 12/16/2020 1:53:52 PM ******/
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
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (10, N'admin', 1, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (11, N'admin', 2, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (12, N'admin', 2, CAST(N'2020-10-18' AS Date), 0)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (13, N'admin', 1, CAST(N'2020-12-16' AS Date), 1)
INSERT [dbo].[tblLog] ([logId], [userId], [productId], [date], [status]) VALUES (14, N'admin', 2, CAST(N'2020-12-16' AS Date), 1)
SET IDENTITY_INSERT [dbo].[tblLog] OFF
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'f6a5b668-f5f3-4948-af2a-167a1e2a4ea1', N'1543003839216456', 400000, CAST(N'2020-10-21T11:32:31.907' AS DateTime), N'1234567890', N'OwO', N'cash', N'Nguyen Tu', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'502975c3-0c8b-4e3a-a1d0-66b7cc838134', N'1543003839216456', 400000, CAST(N'2020-10-21T14:05:58.747' AS DateTime), N'1234567890', N'OwO', N'cash', N'Nguyen Tu', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'606e6fa0-30f5-4f9d-a037-76f89ef6c5bd', NULL, 125000, CAST(N'2020-12-16T13:47:40.977' AS DateTime), N'0929188942', N'Ho Chi Minh City', N'cash', N'Tu Nguyen Hoang Minh', 0)
INSERT [dbo].[tblOrder] ([orderId], [userId], [total], [date], [phone], [address], [payment], [name], [paymentStatus]) VALUES (N'8f48f4a9-6e0d-45d6-a55b-e5ece4fb8450', N'user', 165000, CAST(N'2020-12-16T13:46:46.433' AS DateTime), N'0123456789', N'user no address', N'cash', N'user', 0)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] ON 

INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (26, N'f6a5b668-f5f3-4948-af2a-167a1e2a4ea1', 9, 40000, 4)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (27, N'502975c3-0c8b-4e3a-a1d0-66b7cc838134', 9, 40000, 10)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (28, N'8f48f4a9-6e0d-45d6-a55b-e5ece4fb8450', 4, 15000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (29, N'8f48f4a9-6e0d-45d6-a55b-e5ece4fb8450', 1, 100000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (30, N'8f48f4a9-6e0d-45d6-a55b-e5ece4fb8450', 2, 50000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (31, N'606e6fa0-30f5-4f9d-a037-76f89ef6c5bd', 4, 15000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (32, N'606e6fa0-30f5-4f9d-a037-76f89ef6c5bd', 5, 60000, 1)
INSERT [dbo].[tblOrderDetail] ([detailId], [orderId], [productId], [price], [quantity]) VALUES (33, N'606e6fa0-30f5-4f9d-a037-76f89ef6c5bd', 6, 50000, 1)
SET IDENTITY_INSERT [dbo].[tblOrderDetail] OFF
SET IDENTITY_INSERT [dbo].[tblProduct] ON 

INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (1, N'Ice Cream moon cake', 100000, 0, 2, CAST(N'2020-10-01' AS Date), CAST(N'2020-12-31' AS Date), N'BFV6076_Ice_Cream_Mooncakes_Thumb.jpg', 1, N'ice cream mlem mlem moon cake')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (2, N'Cat moon cake', 50000, 0, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-12-31' AS Date), N'hihi.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (3, N'Cat moon cake', 50000, 0, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-31' AS Date), N'https://www.foodline.sg/PageImage/Caterer/Cat-N-the-Fiddle/13114_large.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (4, N'green onion moon cake', 15000, 1, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-31' AS Date), N'https://kenh14cdn.com/2020/8/14/1172349593071117038673975273538172645457402n-15974118098931676887622.jpg', 1, N'good for health')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (5, N'black sugar bubble moon cake', 60000, 2, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://kenh14cdn.com/2020/8/14/screen-shot-2020-08-14-at-203106-1597411944949623966349.png', 1, N'black sugar bubble moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (6, N'Cat moon cake', 50000, 3, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://www.foodline.sg/PageImage/Caterer/Cat-N-the-Fiddle/13114_large.jpg', 1, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (7, N'Cat moon cake', 50000, 5, 1, CAST(N'2020-10-16' AS Date), CAST(N'2020-10-17' AS Date), N'https://kenh14cdn.com/2020/8/14/11738582819616225373070781753365817642725541o-1597411595710504519456-159741161503369450444.png', 0, N'cat moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (8, N'matcha moon cake', 70000, 10, 4, CAST(N'2020-10-09' AS Date), CAST(N'2020-10-18' AS Date), N'https://i.pinimg.com/736x/f5/ff/80/f5ff80fc90dcbdb24bcffeacd507140b.jpg', 0, N'matcha moon cake mlem mlem ')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (9, N'matcha moon cake', 40000, 24, 4, CAST(N'2020-10-01' AS Date), CAST(N'2020-11-08' AS Date), N'https://i.pinimg.com/originals/c1/4b/be/c14bbe057187b47bc12f316bb8862cf0.jpg', 1, N'matcha mlem mlem')
INSERT [dbo].[tblProduct] ([productId], [name], [price], [quantity], [categoryId], [createDate], [expirationDate], [image], [status], [description]) VALUES (10, N'q', 11, 111, 2, CAST(N'2020-12-16' AS Date), CAST(N'2020-12-31' AS Date), N'hihi.jpg', 1, N'cream')
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
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblProduct] FOREIGN KEY([productId])
REFERENCES [dbo].[tblProduct] ([productId])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblProduct]
GO
ALTER TABLE [dbo].[tblLog]  WITH CHECK ADD  CONSTRAINT [FK_tblLog_tblUser] FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([userId])
GO
ALTER TABLE [dbo].[tblLog] CHECK CONSTRAINT [FK_tblLog_tblUser]
GO
ALTER TABLE [dbo].[tblOrder]  WITH CHECK ADD  CONSTRAINT [FK_tblOrder_tblUser] FOREIGN KEY([userId])
REFERENCES [dbo].[tblUser] ([userId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrder] CHECK CONSTRAINT [FK_tblOrder_tblUser]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblOrder] FOREIGN KEY([orderId])
REFERENCES [dbo].[tblOrder] ([orderId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblOrder]
GO
ALTER TABLE [dbo].[tblOrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblOrderDetail_tblProduct] FOREIGN KEY([productId])
REFERENCES [dbo].[tblProduct] ([productId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblOrderDetail] CHECK CONSTRAINT [FK_tblOrderDetail_tblProduct]
GO
ALTER TABLE [dbo].[tblProduct]  WITH CHECK ADD  CONSTRAINT [FK_tblProduct_tblCategory] FOREIGN KEY([categoryId])
REFERENCES [dbo].[tblCategory] ([categoryId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_tblProduct_tblCategory]
GO
ALTER TABLE [dbo].[tblUser]  WITH CHECK ADD  CONSTRAINT [FK_tblUser_tblRole] FOREIGN KEY([roleId])
REFERENCES [dbo].[tblRole] ([roleId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblUser] CHECK CONSTRAINT [FK_tblUser_tblRole]
GO
USE [master]
GO
ALTER DATABASE [NguyenHoangMinhTu_Lab2] SET  READ_WRITE 
GO
