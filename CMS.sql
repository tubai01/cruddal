USE [master]
GO
/****** Object:  Database [CMS]    Script Date: 11/15/2016 10:11:06 PM ******/
CREATE DATABASE [CMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CMS', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CMS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'CMS_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\CMS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [CMS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [CMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CMS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [CMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CMS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [CMS] SET  MULTI_USER 
GO
ALTER DATABASE [CMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [CMS]
GO
/****** Object:  User [Subhrajyoti\subhrajyotic]    Script Date: 11/15/2016 10:11:07 PM ******/
CREATE USER [Subhrajyoti\subhrajyotic] FOR LOGIN [Subhrajyoti\subhrajyotic] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  StoredProcedure [dbo].[CreateNewContents]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CreateNewContents](
@PAGEID bigint,
@TOP varchar(max),
@HEADER varchar(max),
@FOOTER  varchar(max),
@BOTTOM   varchar(max),
@MIDDLE varchar(max)
)

as

begin
Insert into Contents(PAGEID,[TOP],HEADER,FOOTER,BOTTOM,MIDDLE)values(@PAGEID,@TOP,@HEADER,@FOOTER,@BOTTOM,@MIDDLE)
select @@IDENTITY as [Message]

end
GO
/****** Object:  StoredProcedure [dbo].[CreateNewPages]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[CreateNewPages](@PAGENAME varchar(100))
as

begin

if exists(select * from Pages where PAGENAME=ltrim(rtrim(@PAGENAME)))
begin
select *,'Already Exists' as [Message]from Pages where PAGENAME=ltrim(rtrim(@PAGENAME))
end
else
begin
insert into Pages(PAGENAME)values(@PAGENAME)
select  *,@@IDENTITY as [Message] from Pages where PAGEID=@@IDENTITY
end 

end
GO
/****** Object:  StoredProcedure [dbo].[EditPagecontents]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[EditPagecontents](@PAGEID bigint)
as
begin
select * from Contents where PAGEID= @PAGEID
end
GO
/****** Object:  StoredProcedure [dbo].[getPagecontents]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getPagecontents]
as
begin
select * from [Contents]
end
GO
/****** Object:  StoredProcedure [dbo].[getPages]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getPages]
as
begin
select * from Pages
end
GO
/****** Object:  Table [dbo].[Contents]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Contents](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PAGEID] [bigint] NULL,
	[HEADER] [varchar](max) NULL,
	[FOOTER] [varchar](max) NULL,
	[TOP] [varchar](max) NULL,
	[MIDDLE] [varchar](max) NULL,
	[BOTTOM] [varchar](max) NULL,
 CONSTRAINT [PK_Contents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pages]    Script Date: 11/15/2016 10:11:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pages](
	[PAGEID] [bigint] IDENTITY(1,1) NOT NULL,
	[PAGENAME] [varchar](100) NULL,
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[PAGEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
USE [master]
GO
ALTER DATABASE [CMS] SET  READ_WRITE 
GO
