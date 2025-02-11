USE [master]
GO
/****** Object:  Database [Helmes]    Script Date: 01/12/2020 12:20:41 ******/
CREATE DATABASE [Helmes]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Helmes', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Helmes.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Helmes_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\Helmes_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Helmes] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Helmes].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Helmes] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Helmes] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Helmes] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Helmes] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Helmes] SET ARITHABORT OFF 
GO
ALTER DATABASE [Helmes] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Helmes] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Helmes] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Helmes] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Helmes] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Helmes] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Helmes] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Helmes] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Helmes] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Helmes] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Helmes] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Helmes] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Helmes] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Helmes] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Helmes] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Helmes] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Helmes] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Helmes] SET RECOVERY FULL 
GO
ALTER DATABASE [Helmes] SET  MULTI_USER 
GO
ALTER DATABASE [Helmes] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Helmes] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Helmes] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Helmes] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Helmes] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Helmes] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Helmes', N'ON'
GO
ALTER DATABASE [Helmes] SET QUERY_STORE = OFF
GO
USE [Helmes]
GO
/****** Object:  User [Helmes]    Script Date: 01/12/2020 12:20:41 ******/
CREATE USER [Helmes] FOR LOGIN [Helmes] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[Levels]    Script Date: 01/12/2020 12:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Levels](
	[LevelID] [int] NOT NULL,
	[Label] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[LevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sectors]    Script Date: 01/12/2020 12:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sectors](
	[SectorID] [int] NOT NULL,
	[Label] [varchar](50) NOT NULL,
	[ParentSectorID] [int] NULL,
	[LevelID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SectorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfos]    Script Date: 01/12/2020 12:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfos](
	[InfoID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[TermsAgreed] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InfoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/12/2020 12:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserSectors]    Script Date: 01/12/2020 12:20:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSectors](
	[UserID] [int] NOT NULL,
	[SectorId] [int] NOT NULL,
 CONSTRAINT [pk_UserSectors] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[SectorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Levels] ([LevelID], [Label]) VALUES (1, N'Main')
INSERT [dbo].[Levels] ([LevelID], [Label]) VALUES (2, N'Sub')
INSERT [dbo].[Levels] ([LevelID], [Label]) VALUES (3, N'Detailed')
INSERT [dbo].[Levels] ([LevelID], [Label]) VALUES (4, N'Precise')
GO
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (1, N'Manufacturing', NULL, 1)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (2, N'Service', NULL, 1)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (3, N'Other', NULL, 1)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (5, N'Printing', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (6, N'Food and Beverage', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (7, N'Textile and Clothing', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (8, N'Wood', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (9, N'Plastic and Rubber', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (11, N'Metalworking', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (12, N'Machinery', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (13, N'Furniture', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (18, N'Electronics and Optics', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (19, N'Construction materials', 1, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (21, N'Transport and Logistic', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (22, N'Tourism', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (25, N'Business services', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (28, N'Information Technology and Telecommunications', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (29, N'Energy technology', 3, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (33, N'Environment', 3, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (35, N'Engineering', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (37, N'Creative industries', 3, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (39, N'Milk & dairy products', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (40, N'Meat & meat products', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (42, N'Fish & fish products', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (43, N'Beverages', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (44, N'Clothing', 7, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (45, N'Textile', 7, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (47, N'Wooden houses', 8, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (51, N'Wooden building materials', 8, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (53, N'Plastics welding and processing', 559, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (54, N'Packaging', 9, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (55, N'Blowing', 559, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (57, N'Moulding', 559, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (62, N'Forgings, Fasteners', 542, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (66, N'MIG, TIG, Aluminum welding', 542, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (67, N'Construction of metal structures', 11, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (69, N'Gas, Plasma, Laser cutting', 542, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (75, N'CNC-machining', 542, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (91, N'Machinery  equipment/tools', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (93, N'Metal structures', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (94, N'Machinery components', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (97, N'Maritime', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (98, N'Kitchen', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (99, N'Project furniture', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (101, N'Living room', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (111, N'Air', 21, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (112, N'Road', 21, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (113, N'Water', 21, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (114, N'Rail', 21, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (121, N'Software, Hardware', 28, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (122, N'Telecommunications', 28, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (141, N'Translation services', 2, 2)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (145, N'Labelling and packaging printing', 5, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (148, N'Advertising', 5, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (150, N'Book/Periodicals printing', 5, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (224, N'Manufacture of machinery', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (227, N'Repair and maintenance service', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (230, N'Ship repair and conversion', 97, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (263, N'Houses and buildings', 11, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (267, N'Metal products', 11, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (269, N'Boat/Yacht building', 97, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (271, N'Aluminium and steel workboats', 97, 4)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (337, N'Other (Wood)', 8, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (341, N'Outdoor', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (342, N'Bakery & confectionery products', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (378, N'Sweets & snack food', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (385, N'Bedroom', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (389, N'Bathroom/sauna', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (390, N'Children''s room', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (392, N'Office', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (394, N'Other (Furniture)', 13, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (437, N'Other', 6, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (508, N'Other', 12, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (542, N'Metal works', 11, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (556, N'Plastic goods', 9, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (559, N'Plastic processing technology', 9, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (560, N'Plastic profiles', 9, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (576, N'Programming, Consultancy', 28, 3)
INSERT [dbo].[Sectors] ([SectorID], [Label], [ParentSectorID], [LevelID]) VALUES (581, N'Data processing, Web portals, E-marketing', 28, 3)
GO
SET IDENTITY_INSERT [dbo].[UserInfos] ON 

INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (2, 5, 1)
INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (3, 6, 1)
INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (4, 7, 1)
INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (5, 8, 1)
INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (6, 9, 1)
INSERT [dbo].[UserInfos] ([InfoID], [UserID], [TermsAgreed]) VALUES (7, 10, 1)
SET IDENTITY_INSERT [dbo].[UserInfos] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Name]) VALUES (5, N'jean')
INSERT [dbo].[Users] ([UserID], [Name]) VALUES (6, N'luc')
INSERT [dbo].[Users] ([UserID], [Name]) VALUES (7, N'sa')
INSERT [dbo].[Users] ([UserID], [Name]) VALUES (8, N'Jack')
INSERT [dbo].[Users] ([UserID], [Name]) VALUES (9, N'NewUser')
INSERT [dbo].[Users] ([UserID], [Name]) VALUES (10, N'BusyMan')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (5, 47)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (6, 3)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (7, 5)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (8, 11)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (8, 19)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (9, 263)
INSERT [dbo].[UserSectors] ([UserID], [SectorId]) VALUES (10, 111)
GO
ALTER TABLE [dbo].[Sectors]  WITH CHECK ADD FOREIGN KEY([LevelID])
REFERENCES [dbo].[Levels] ([LevelID])
GO
ALTER TABLE [dbo].[UserInfos]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserSectors]  WITH CHECK ADD FOREIGN KEY([SectorId])
REFERENCES [dbo].[Sectors] ([SectorID])
GO
ALTER TABLE [dbo].[UserSectors]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
USE [master]
GO
ALTER DATABASE [Helmes] SET  READ_WRITE 
GO
