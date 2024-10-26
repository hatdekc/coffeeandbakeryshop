CREATE DATABASE [BAKERY_COFFEE_SHOP_v2.2]
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BAKERY_COFFEE_SHOP_v2.2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ARITHABORT OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET  MULTI_USER 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [BAKERY_COFFEE_SHOP_v2.2] SET QUERY_STORE = OFF
GO
USE [BAKERY_COFFEE_SHOP_v2.2]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleAccount](
	[roleID] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT RoleAccount ON;
INSERT INTO RoleAccount (RoleID, roleName)
VALUES (1, 'Admin');
INSERT INTO RoleAccount (RoleID, roleName)
VALUES (2, 'User');
SET IDENTITY_INSERT RoleAccount OFF;
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account] (
	[accID] [int] IDENTITY(1,1) NOT NULL,
	[fullname] [NVARCHAR](255) NOT NULL,
	[email] [VARCHAR](255) NULL,
	[username]	[VARCHAR](255) NULL,
	[password] [VARCHAR](255) NULL,
	[phone] [VARCHAR](50) NULL,
	[statusID] [int] NULL,
	[createdDate] [date] NULL,
	[roleID] [int] NULL,
	constraint FK_RoleAccount foreign key (roleID) references RoleAccount (roleID),
	PRIMARY KEY CLUSTERED 
(
	[accID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
) 
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT Account ON
INSERT INTO Account (AccId, FullName, email, username, Password, phone, statusID , createdDate, roleID)
VALUES (1, N'Pham Cong Nguyen', N'admin@gmail.com', N'admin', 12345, NULL, 1, NULL, 1);
INSERT INTO Account (AccId, FullName, email, username, Password, phone, statusID , createdDate, roleID)
VALUES (2, N'Dang Truong Phat', N'usertest@gmail.com', N'user', 12345, NULL, 1, NULL, 2);
SET IDENTITY_INSERT Account OFF
GO



CREATE TABLE [dbo].[StatusTable](
	[statusID] [int] NOT NULL,
	[statusName] [nvarchar](50) NULL,
	PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
go

INSERT INTO StatusTable (statusID, statusName)
VALUES (1, 'Empty');
INSERT INTO StatusTable (statusID, statusName)
VALUES (2, 'Not Empty');
GO

CREATE TABLE [dbo].[TableNumber](
	[tableID] [int] IDENTITY(1,1) NOT NULL,
	[accID] [int] NULL,
	[statusID] [int] NULL,
	constraint FK_TableNumber_Status foreign key (statusID) references StatusTable (statusID),
	constraint FK_TableNumber_Account foreign key (accID) references Account(accID),
PRIMARY KEY CLUSTERED 
(
	[tableID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[OrderStatus](
	[statusID] [int] NOT NULL,
	[statusName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[statusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[statusName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO OrderStatus(statusID, statusName) VALUES(1, 'Pending')
INSERT INTO OrderStatus(statusID, statusName) VALUES(2, 'Processing')
INSERT INTO OrderStatus(statusID, statusName) VALUES(3, 'Shiping')
INSERT INTO OrderStatus(statusID, statusName) VALUES(4, 'Delivered')
INSERT INTO OrderStatus(statusID, statusName) VALUES(5, 'Canceled')
select * from orderStatus 

CREATE TABLE [dbo].[Order](
	[orderID] [int] IDENTITY(1,1) NOT NULL,
	[accID] [int] NULL,
	[orderDate] [date] NULL,
	[statusID] [int] NULL,
	[tableID] [int] NULL,
	constraint FK_Order_Account foreign key (accID) references Account (accID),
	constraint FK_Order_Table foreign key (tableID) references TableNumber(tableID),
	constraint FK_Order_OrderStatus foreign key (statusID) references OrderStatus(statusID),
PRIMARY KEY CLUSTERED 
(
	[orderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ItemType](
	[typeID] [int] NOT NULL,
	[typeName] [nvarchar] (50) NULL,
PRIMARY KEY CLUSTERED 
(
	[typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO ItemType(typeID, typeName) VALUES(1, 'Drink')
INSERT INTO ItemType(typeID, typeName) VALUES(2, 'Food')

CREATE TABLE StatusItem(
	statusID int PRIMARY KEY,
	statusName varchar(50) NOT NULL,
)

SET ANSI_NULLS ON
GO
INSERT INTO StatusItem (statusID, statusName)
VALUES (1, N'In Stock')
INSERT INTO StatusItem (statusID, statusName)
VALUES (2, N'Out Stock')
GO
select * from StatusItem
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Items](
	[ItemId] [int] NOT NULL,
	[ItemName] [nvarchar](50) NULL,
	[Price] [int] NULL,
	[typeID] [int] NULL,
	[statusID] [int] NULL,
	[Image] [nvarchar](255) NULL,
	constraint FK_Items_Type foreign key (typeID) references ItemType(typeID),
	constraint FK_Items_Status foreign key (statusID) references StatusItem(statusID),
 PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (1, N'Basque Burnt', 20000, 2, 1, N'https://i.postimg.cc/C11d5cvb/Basque-Burnt.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (2, N'Brownie Cake', 22000, 2, 1, N'https://i.postimg.cc/bvFc0Z2x/Brownie.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (3, N'Fruit Panna Cotta', 18000, 2, 1, N'https://i.postimg.cc/NM9hdQ1W/Fruit-Panna-Cotta.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (4, N'Matcha Dessert Cake Box', 30000, 2, 1, N'https://i.postimg.cc/MHVC8t35/Matcha-Dessert-Cake-Box.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (5, N'Redvelvet Cake Box', 20000, 2, 1, N'https://i.postimg.cc/8CCgrRsk/Redvelvet-Cake-Box.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (6, N'Strawberry Fraisier', 22000, 2, 1, N'https://i.postimg.cc/DZt9DR6m/Strawberry-Fraisier.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (7, N'Tiramisu Truyền Thống', 18000, 2, 1, N'https://i.postimg.cc/xTSrPDq4/Tiramisu-Truy-n-Th-ng.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (8, N'Milo Cake Box', 30000, 2, 1, N'https://i.postimg.cc/MK0CPPQK/image.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (9, N'Oreo Creamcheese', 18000, 2, 1, N'https://i.postimg.cc/MK0CPPQK/image.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (10, N'White Chocolate Box', 20000, 2, 1, N'https://i.postimg.cc/kgnkkQQN/image.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (11, N'White Coffee', 20000, 1, 1, N'https://i.postimg.cc/Qtm3BfJM/bac-xiu.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (12, N'CoCoa Ice', 22000, 1, 1, N'https://i.postimg.cc/mkrG77my/ca-cao-da.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (13, N'Cocoa Hot', 18000, 1, 1, N'https://i.postimg.cc/8cng4s3Q/ca-cao-nong.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (14, N'Coffee Express', 20000, 1, 1, N'https://i.postimg.cc/zDdN8Pft/cf-den.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (15, N'Milktea Matcha', 30000, 1, 1, N'https://i.postimg.cc/cCCVv0JD/tra-sua-matcha.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (16, N'Guava Pink Tea', 27000, 1, 1, N'https://i.postimg.cc/76Hvygrr/tra-oi-hong.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (17, N'Peach Tea', 25000, 1, 1, N'https://i.postimg.cc/vmdF3JPB/tra-dao.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (18, N'Fabric Tea', 30000, 1, 1, N'https://i.postimg.cc/VsZx3r72/tra-vai.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (19, N'Black Sugar Pearl Milktea', 28000, 1, 1, N'https://i.postimg.cc/yxG29tg7/tran-chau-duong-den.jpg')
INSERT INTO Items (ItemId, ItemName, Price, typeID, statusID, Image)
VALUES (20, N'Milk Coffee', 20000, 1, 1, N'https://i.postimg.cc/x1mVGf3h/cf-sua.jpg')
go



CREATE TABLE [dbo].[OrderDetail](
	[oDetailID] [int] IDENTITY(1,1) NOT NULL,
	[orderID] [int] NULL,
	[ItemId] [int] NULL,
	[quantity] [int] NULL,
	[totalPrice] [decimal](10, 2) NULL,
	[typeID] [int] NULL,
	constraint FK_OrderDetail_Order foreign key (orderID) references [Order](orderID),
	constraint FK_OrderDetail_Item foreign key (ItemId) references Items(ItemId),
	constraint FK_OrderDetail_Type foreign key (typeID) references ItemType(typeID),
PRIMARY KEY CLUSTERED 
(
	[oDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--ALTER TABLE Items
--ALTER COLUMN Image VARCHAR(255);

--ALTER TABLE dbo.Items
--ALTER COLUMN ItemName NVARCHAR(255) ;