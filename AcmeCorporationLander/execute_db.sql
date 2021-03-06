USE [master]
GO
/****** Object:  Database [AcmeLanderDB]    Script Date: 21/05/2018 20:33:32 ******/
CREATE DATABASE [AcmeLanderDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AcmeLanderDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AcmeLanderDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AcmeLanderDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\AcmeLanderDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AcmeLanderDB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AcmeLanderDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AcmeLanderDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AcmeLanderDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AcmeLanderDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AcmeLanderDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AcmeLanderDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AcmeLanderDB] SET  MULTI_USER 
GO
ALTER DATABASE [AcmeLanderDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AcmeLanderDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AcmeLanderDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AcmeLanderDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AcmeLanderDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AcmeLanderDB] SET QUERY_STORE = OFF
GO
USE [AcmeLanderDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [AcmeLanderDB]
GO
/****** Object:  Table [dbo].[CUSTOMER]    Script Date: 21/05/2018 20:33:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CUSTOMER](
	[FirstName] [nvarchar](15) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Age] [int] NOT NULL,
 CONSTRAINT [PK_CUSTOMER] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SUBMISSION]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SUBMISSION](
	[DrawId] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](15) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[ProductSerialNr] [int] NOT NULL,
 CONSTRAINT [PK_SUBMISSION] PRIMARY KEY CLUSTERED 
(
	[DrawId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SUBMISSION]  WITH CHECK ADD  CONSTRAINT [FK_SUBMISSION] FOREIGN KEY([Email])
REFERENCES [dbo].[CUSTOMER] ([Email])
GO
ALTER TABLE [dbo].[SUBMISSION] CHECK CONSTRAINT [FK_SUBMISSION]
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountMatched]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetCountMatched]
@email NVARCHAR(255), @productNr int
AS
BEGIN
SELECT Count(*) FROM SUBMISSION
WHERE Email = @email AND ProductSerialNr = @productNr
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomers]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetCustomers]
AS
BEGIN
SELECT FirstName, LastName, Email, Age FROM CUSTOMER
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSubmissions]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetSubmissions]
AS
BEGIN
SELECT FirstName, LastName, Email, ProductSerialNr FROM SUBMISSION
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Initial]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_Initial]
AS
BEGIN
Delete SUBMISSION
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('John', 'Andersen', 'j.andersen@gmail.com', 43949439)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('John', 'Andersen', 'j.andersen@gmail.com', 43949439)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('John', 'Andersen', 'j.andersen@gmail.com', 23764728)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Anders', 'Bensen', 'anders.bensen@gmail.com', 85982774)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Elena', 'Tomsen', 'elena.t@gmail.com', 47754969)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Simon', 'Smith', 'simba_smith@gmail.com', 85982774)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Lara', 'Morten', 'lara.morten@gmail.com', 69448899)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Robert', 'Peterson', 'robby.peterson@gmail.com', 73282244)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Ben', 'Nikolovich', 'b.nikolovich@gmail.com', 78242235)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Ashley', 'Camelson', 'a1970camelson@gmail.com', 86654952)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Elena', 'Tomsen', 'elena.t@gmail.com', 47733292)
Insert into SUBMISSION(FirstName, LastName, Email, ProductSerialNr) Values ('Jim', 'Kolev', 'jim_kolev@gmail.com', 82933436)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_InsertSubmission]    Script Date: 21/05/2018 20:33:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_InsertSubmission]
	@FirstName NVARCHAR(15),
	@LastName NVARCHAR(50),
	@Email NVARCHAR(255),
	@ProductSerialNr Int

	AS
	BEGIN
		INSERT INTO SUBMISSION(FirstName, LastName, Email, ProductSerialNr)
		VALUES (@FirstName, @LastName, @Email, @ProductSerialNr)
	END 
GO
USE [master]
GO
ALTER DATABASE [AcmeLanderDB] SET  READ_WRITE 
GO
