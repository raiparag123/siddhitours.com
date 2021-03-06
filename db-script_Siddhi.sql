USE [master]
GO
/****** Object:  Database [SiddhiTours]    Script Date: 8/18/2021 10:49:37 PM ******/
CREATE DATABASE [SiddhiTours]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SiddhiTours', FILENAME = N'E:\MSSQL.MSSQLSERVER\DATA\SiddhiTours.mdf' , SIZE = 6464KB , MAXSIZE = 204800KB , FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SiddhiTours_log', FILENAME = N'D:\MSSQL.MSSQLSERVER\DATA\SiddhiTours_log.ldf' , SIZE = 2048KB , MAXSIZE = 102400KB , FILEGROWTH = 1024KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SiddhiTours].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SiddhiTours] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SiddhiTours] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SiddhiTours] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SiddhiTours] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SiddhiTours] SET ARITHABORT OFF 
GO
ALTER DATABASE [SiddhiTours] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SiddhiTours] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SiddhiTours] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SiddhiTours] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SiddhiTours] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SiddhiTours] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SiddhiTours] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SiddhiTours] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SiddhiTours] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SiddhiTours] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SiddhiTours] SET  ENABLE_BROKER 
GO
ALTER DATABASE [SiddhiTours] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SiddhiTours] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SiddhiTours] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SiddhiTours] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SiddhiTours] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SiddhiTours] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SiddhiTours] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SiddhiTours] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [SiddhiTours] SET  MULTI_USER 
GO
ALTER DATABASE [SiddhiTours] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SiddhiTours] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SiddhiTours] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SiddhiTours] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [SiddhiTours]
GO
/****** Object:  User [SiddhiTours]    Script Date: 8/18/2021 10:49:38 PM ******/
CREATE USER [SiddhiTours] FOR LOGIN [SiddhiTours] WITH DEFAULT_SCHEMA=[SiddhiTours]
GO
/****** Object:  User [pop]    Script Date: 8/18/2021 10:49:38 PM ******/
CREATE USER [pop] FOR LOGIN [pop] WITH DEFAULT_SCHEMA=[pop]
GO
/****** Object:  DatabaseRole [gd_execprocs]    Script Date: 8/18/2021 10:49:39 PM ******/
CREATE ROLE [gd_execprocs]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [SiddhiTours]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SiddhiTours]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [SiddhiTours]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SiddhiTours]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SiddhiTours]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [pop]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [pop]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [pop]
GO
ALTER ROLE [db_datareader] ADD MEMBER [pop]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [pop]
GO
/****** Object:  Schema [pop]    Script Date: 8/18/2021 10:49:39 PM ******/
CREATE SCHEMA [pop]
GO
/****** Object:  Schema [SiddhiTours]    Script Date: 8/18/2021 10:49:39 PM ******/
CREATE SCHEMA [SiddhiTours]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_EDIT_POPULAR_DESTINATION]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADD_EDIT_POPULAR_DESTINATION]
	-- Add the parameters for the stored procedure here
	@LOCATIONID varchar(20),
	@TITLE varchar(50),
	@IMAGEPATH varchar(max),
	@POPULARID int,
	@FLAG varchar(5)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	declare @maxID INTEGER;
	declare @imageid integer;
    -- Insert statements for procedure here
	if(upper(@FLAG)='A')
	begin
	insert into IMAGEMASTER(IMAGEPATH,Isactive)values(@IMAGEPATH,1);

	
	set @maxID=(select max(imageid) from imageMaster); 

	insert into PopularDestination(LOCATIONID,TITLE,IMAGEID,ISACTIVE)
	values(@LOCATIONID,@TITLE,@maxID,1)

	select 1 as status;
	end

	if(upper(@FLAG)='E')
	begin
	update  popularDestination set locationid=@LOCATIONID,title=@TITLE where ppId=@POPULARID;
	set @imageid =(select imageid from PopularDestination where ppId=@POPULARID);

	if(upper(@IMAGEPATH)!='')
	begin
	update ImageMaster set ImagePath=@IMAGEPATH where ImageId=@imageid;
	end

	select 1 as status;
	end


END



GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_TOURPACKAGE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADD_TOURPACKAGE]
--execute SP_ADD_TOURPACKAGE(42,4000,"abc","E")
	-- Add the parameters for the stored procedure here
	@PACKAGEID int,
	@PACKAGE bigint,
	@IMAGEPATH varchar(max),
	@FLAG varchar(10)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @IMAGEID integer;
    -- Insert statements for procedure here
	if(upper(@FLAG)='A')
	begin

insert into ImageMaster(ImagePath) values(@IMAGEPATH);
set @IMAGEID=SCOPE_IDENTITY();
insert into TourPackage values(@PACKAGE,@IMAGEID);
end
else
begin
set @IMAGEID=(select imageid from tourpackage where packageid=@PACKAGEID);
if(@IMAGEPATH!='')
begin
update imageMaster set imagepath=@IMAGEPATH where ImageId=@IMAGEID;
end
update TourPackage set PackageValue=@PACKAGE where packageid=@PACKAGEID;

end




END

GO
/****** Object:  StoredProcedure [dbo].[SP_ADMIN_DETAIL]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_ADMIN_DETAIL]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Adminlogin;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_ADMIN_LOGIN]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============password=@Pass=================================
-- Author:		dhwani
-- Create date: 26/05/2018
-- Description:	checkAdminLogin
-- =============================================
CREATE PROCEDURE [dbo].[SP_ADMIN_LOGIN] 
	-- Add the parameters for the stored procedure here
	@USERID varchar(20),
	@PASSWORD varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from AdminLogin where upper(username)=upper(@USERID) and password=@PASSWORD;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_B2BIMAGES]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_B2BIMAGES]
	-- Add the parameters for the stored procedure here
@IMAGEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from businesstourImages where Businessimageid=@IMAGEID;
	select 1 as status;
	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_BUSINESSTRIP]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_BUSINESSTRIP]
	-- Add the parameters for the stored procedure here
	@TOURID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from businesstour where businessid=@TOURID;
	select 1 as status;	--inner join businesstourimages bi on b.businessid=bi.tourid 
	--inner join ImageMaster i on bi.imageid=i.ImageId;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CABIN_PRICE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_DELETE_CABIN_PRICE]
	-- Add the parameters for the stored procedure here
	@CRUISEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Cruise_Cabin_Price where cruiseid=@cruiseId
END


GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CITY]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_CITY]
	-- Add the parameters for the stored procedure here
	
	@CITYID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	--update citymaster set Isactive=0 where cityid=@CITYID;
	delete from citymaster where CityID=@CITYID;
	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_COMPANYNAME]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_DELETE_COMPANYNAME]
	@COMPID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM Cruise_Company_Master WHERE CompanyId = @COMPID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_COUNTRY]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_COUNTRY]
	-- Add the parameters for the stored procedure here
	
	@COUNTRYID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from statemaster where countryid=@COUNTRYID;
	--update countrymaster set Isactive=0 where countryid=@COUNTRYID;
	delete from CountryMaster where CountryID=@COUNTRYID;
	
	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CRUISE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_DELETE_CRUISE]
	@CRUISEID INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE from Cruise_master where cruiseId = @CRUISEID
	DELETE from Cruise_cabin_price where cruiseId = @CRUISEID
	DELETE from Cruise_itinerary_master where cruiseId = @CRUISEID
	DELETE from Cruise_Image_master where cruiseId = @CRUISEID
	DELETE from Cruise_Onboard_Activities where cruiseId = @CRUISEID
	DELETE from Ship_General_Activities where cruiseId = @CRUISEID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CRUISECABINDATE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_DELETE_CRUISECABINDATE] 
	-- Add the parameters for the stored procedure here
	@CRUISEID int,
	@FROM date,
	@TO date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from cruise_cabin_price where cruiseid=@cruiseid and startdate=@from and endDate=@TO;
END


GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_CRUISEIMAGES]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[SP_DELETE_CRUISEIMAGES]
	-- Add the parameters for the stored procedure here
@IMAGEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Cruise_Image_Master where CruiseImgId = @IMAGEID;	
END


GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_HOME_BANNER]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_HOME_BANNER]
	-- Add the parameters for the stored procedure here
	@BANNERID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

   Delete from homebanner where bannerid=@BANNERID

END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_ITENARY]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_ITENARY] 
	-- Add the parameters for the stored procedure here
	
	@ITENARYID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from ItenaryMaster where ItenaryId=@ITENARYID;
	select 1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_POP_DESTINATION]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_DELETE_POP_DESTINATION]
	-- Add the parameters for the stored procedure here
	@POPULARID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  update PopularDestination set IsActive=0 where ppId=@POPULARID;

END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_PORTNAME]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_PORTNAME]
	@PORTID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM Port_Master WHERE PortId = @PORTID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_RENT]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_RENT] 
	-- Add the parameters for the stored procedure here
	@RENTID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from rent where rentid=@RENTID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_STATE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_STATE]
	-- Add the parameters for the stored procedure here
	
	@STATEID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	update STATEMASTER set Isactive=0 where stateid=@STATEID;
	--delete   from STATEMASTER where StateID=@STATEID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TOURPACKAGE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_DELETE_TOURPACKAGE]
	-- Add the parameters for the stored procedure here
	@PACKAGEID bigint
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
delete from tourpackage where packageid=@PACKAGEID;





END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TREND]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_DELETE_TREND]
	-- Add the parameters for the stored procedure here
	
	@TRENDID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
delete from trendingmaster where trendingid=@TRENDID;





END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TRIP]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_TRIP]
	-- Add the parameters for the stored procedure here
	@TRIPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from ItenaryMaster where TripId=@TRIPID;
	delete from TripImageMaster where TripId=@TRIPID;
	delete from TripMaster where TripId=@TRIPID;

	select 1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TRIPIMAGES]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_TRIPIMAGES]
	-- Add the parameters for the stored procedure here
@IMAGEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from tripimagemaster where TripImageID=@IMAGEID;
	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TRIPTYPE]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_DELETE_TRIPTYPE]
	-- Add the parameters for the stored procedure here
	@TYPEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update TripTypeMaster set IsActive=0 where TypeId=@TYPEID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_VISA]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_DELETE_VISA]
	-- Add the parameters for the stored procedure here
	
	@VISAID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
	DELETE FROM Visa WHERE VisaId = @VISAID	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_ABOUTUS]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_ABOUTUS] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select ABOUTCONTENT from aboutus;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_ABOUTUS_FRONT]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_ABOUTUS_FRONT]
		
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 ABOUTCONTENT, IMAGEPATH FROM ABOUTUS ORDER BY ABOUTID DESC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_B2BIMAGES]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_B2BIMAGES]
	-- Add the parameters for the stored procedure here
@TOURID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select TOURID,BUSINESSIMAGEID,IMAGEPATH from businesstourimages bm 
	inner join imagemaster im
	 on bm.imageid=im.imageid 
	where tourid=@TOURID;

	END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_BUSINESSTOUR_DETAIL_FRONT]    Script Date: 8/18/2021 10:49:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_BUSINESSTOUR_DETAIL_FRONT] 
	-- Add the parameters for the stored procedure here
	@BUSINESSID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select b.BUSINESSID,TITLE,COST,LOCATION,INCLUSION,COUNTRY,STATE,CITY,IMAGEPATH 
	from BusinessTour b left join  BusinessTourImages bi 
	on b.BusinessID=bi.tourid  inner join ImageMaster i on bi.ImageId=i.ImageId where b.BusinessID=@BUSINESSID;

	select b.BUSINESSID,TITLE,COST,IMAGEPATH 
	from BusinessTour b left join  BusinessTourImages bi 
	on b.BusinessID=bi.tourid  inner join ImageMaster i on bi.ImageId=i.ImageId where b.BusinessID!=@BUSINESSID;


END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_BUSINESSTOUR_LIST_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_BUSINESSTOUR_LIST_FRONT]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select b.BUSINESSID,TITLE,COST,LOCATION,INCLUSION,COUNTRY,STATE,CITY,IMAGEPATH 
	from BusinessTour b left join (select tourid,imageid,row_number() over (partition by tourid order  by businessimageid desc) as cnt  from  BusinessTourImages) bi 
	on b.BusinessID=bi.tourid and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId order by b.BusinessID desc;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_BUUSINESSTOUR]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_BUUSINESSTOUR]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select b.BUSINESSID ,b.TITLE as BUSINESSTITLE ,b.COST,b.INCLUSION,b.COUNTRY,b.STATE,b.CITY from businessTour b ;
	--inner join businesstourimages bi on b.businessid=bi.tourid 
	--inner join ImageMaster i on bi.imageid=i.ImageId;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CITYLIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CITYLIST] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		Select c.CITYID,s.STATENAME,cn.COUNTRYNAME ,c.CITYNAME,s.STATEID,cn.COUNTRYID
	from citymaster c inner join  statemaster s  on c.stateid=s.stateid
	inner join countrymaster cn 
	on s.countryid=cn.countryid 
	where s.isactive=1 and c.isactive=1 and cn.isactive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_COMPANYLIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_COMPANYLIST]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CompanyId,CompanyName from Cruise_Company_Master ORDER BY CompanyName ASC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_COMPANYNAMES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_COMPANYNAMES]
AS
BEGIN
	SET NOCOUNT ON;
	
	Select CompanyId, UPPER(CompanyName) as NAME FROM Cruise_Company_Master
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CONTACTUS]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CONTACTUS]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ADDRESS_DATA,PHONE1,PHONE2,EMAIL,isnull(ISWHATSAPP1,0) as ISWHATSAPP1,isnull(ISWHATSAPP2,0) as ISWHATSAPP2 ,GOOGLEMAPLINK,FB,INSTAGRAM from contactus;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CONTACTUS_FOOTER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CONTACTUS_FOOTER]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 Email,FB,Instagram,Phone1, Phone2, IsWhatsapp1, IsWhatsapp2  FROM ContactUs ORDER BY contactId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CONTACTUS_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CONTACTUS_FRONT]
		
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 1 Address_Data,Email,GoogleMapLink,FB,Instagram, IsWhatsapp1, Phone1 AS MOBILE1,IsWhatsapp2, Phone2 AS MOBILE2 FROM ContactUs ORDER BY contactId DESC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_COUNTRY_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_COUNTRY_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select COUNTRYID,COUNTRYNAME from CountryMaster where isactive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_COUNTRYLIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_COUNTRYLIST]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNTRYID,COUNTRYNAME from COUNTRYMASTER where ISActive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISE_COMPANY_LIST_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CRUISE_COMPANY_LIST_FRONT]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CompanyId, ImagePath FROM [SiddhiTours].[dbo].Cruise_Company_master	
END


GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISE_DETAIL_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_CRUISE_DETAIL_FRONT] 
	-- Add the parameters for the stored procedure here
	@CRUISEID int,
	@DATE date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select cm.CRUISEID,CRUISENAME,PORTSOURCENAME,PORTDESTINATIONNAME,ALIASFORTRIP as TITLE,NOOFDAYS as DAYS,
	NOOFNIGHTS as NIGHTS,
	INCLUSIONS,EXCLUSIONS,ci.IMAGEPATH,cm.GRATUITYFORADULT as ADULT,GRATUITYFORCHILD as CHILD,TAXPERPERSON as TAX
	 from cruise_master cm left join cruise_image_master ci  on cm.cruiseId=ci.cruiseid where cm.cruiseid=@cruiseId ;

	 --select * from cruise_image_master;
	 --select * from cruise_cabin_price;
	 --select * from Cruise_Cabin_master;


	 --select * from cruise_master;
	 --select * from CRUISE_itinerary_Master;
	 --select * from cruise_onboard_activities;
	 --select * from cruise_onboard_Category;
	 --select * from cruise_onboard_master;




	 select cp.CruiseCabinId as CABINID,cp.cruiseid as CRUISEID,cc.CABINNAME,Cp.CURISEIMGID,
	 isnull(cp.DESCRIPTION,'') as DESCRIPTION,im.IMAGEPATH,
	 max(cp.PRICE) as PRICE,cp.MAINPRICE,STARTDATE,ENDDATE--,cp.* 
	 from cruise_cabin_price cp
	  inner join Cruise_Cabin_master  cc on cp.CruiseCabinId=cc.cabinid inner  join cruise_IMAGE_MASTER im 
	  on cp.CURISEIMGID=im.CRUISEIMGID where cp.CRUISEID=@cruiseId and StartDate=@DATE
	  group by cp.CruiseCabinId,cp.cruiseid,cc.CABINNAME,Cp.CURISEIMGID,DESCRIPTION,
	  im.IMAGEPATH,cp.mainprice,StartDate,ENDDATE order by CruiseCabinId asc ;

	 select ITINERARYID,CRUISEID,DAY,DETAIL,ARRIVAL,DEPARTATURE 
	  from CRUISE_itinerary_Master where CRUISEID=@cruiseId;

	  select com.CONBOARDID,com.CONBOARDNAME,co.ONBOARDCATEGORYID,co.CATEGORYNAME,co.ICON from cruise_onboard_activities ca 
	  inner join cruise_onboard_Category co on ca.ONBOARDCATEGORYID=co.ONBOARDCATEGORYID
	  inner join cruise_onboard_master com on com.conboardid=co.onBoardid where ca.cruiseid=@cruiseId;

	  select sm.SHIPNAME,FAICONNAME,DETAIL from ship_general_activities sga inner join ship_general_master sm 
	  on sga.shipid=sm.shipid where sga.cruiseid=@cruiseid ;

	  End

	


GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISE_LIST_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_CRUISE_LIST_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    -- Insert statements for procedure here

	select cm.CRUISEID,CRUISENAME,ALIASFORTRIP as TITLE,cm.PORTDESTINATIONNAME as LOCATION,bi.IMAGEPATH,NOOFDAYS as DAYS,cm.MainPrice PRICE, 
	CCM.CompanyId,CCM.IMAGEPATH  as COMPANYIMAGE from cruise_Master cm
	LEFT JOIN dbo.Cruise_Company_master CCM 
				ON 	CCM.CompanyId = cm.CompanyId
	left join (select CRUISEID,CRUISEIMGID,IMAGEPATH,row_number() over (partition by CRUISEID order  by CRUISEIMGID desc) 
	as cnt  from  cruise_Image_master) bi 
	on cm.CRUISEID=bi.CRUISEID and bi.cnt=1 
	left join (select min(price) as price,cruiseId from Cruise_Cabin_Price cp group by  cruiseId) cp  
	on cm.CRUISEID=cp.CRUISEID 
	order by cm.CRUISEID desc;

	select distinct startdate as DATE,cm.cruiseid as CRUISEID from cruise_Cabin_Price cp
	 inner join cruise_master  cm on cp.cruiseid=cm.cruiseid where cp.cruisecabinid=1;
	 
	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISEDATABYID]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Chirag Nakum
-- Create date: 04-Aug-2018
-- Description:	Gets Particular cruise data
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_CRUISEDATABYID]
	@CRUISEID INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT	CruiseName, NoOfDays, NoOfNights, AliasForTrip, PortSourceName, PortDestinationName,CompanyId, TaxPerPerson, GratuityForAdult, GratuityForChild, Inclusions, Exclusions,MainPrice
	FROM	Cruise_Master CM
	WHERE CruiseId = @CRUISEID
	
	SELECT CruiseCabinId, StartDate, EndDate, Price, Description, CurCabPriceId,MainPrice,
	DENSE_RANK() OVER ( ORDER By StartDate,enddate) as Id
	FROM Cruise_Cabin_Price
	WHERE CruiseId = @CRUISEID

	SELECT Day, Detail, Arrival, Departature, ItineraryId
	FROM Cruise_Itinerary_Master
	WHERE CruiseId = @CRUISEID

	SELECT OnboardCategoryId 
	FROM Cruise_Onboard_Activities
	WHERE CruiseId = @CRUISEID
		
	SELECT SGM.ShipName, SGA.ShipId, SGA.Detail 
	FROM Ship_General_Master SGM
			INNER JOIN
		 Ship_General_Activities SGA
				ON SGM.ShipId = SGA.ShipId
	WHERE CruiseId = @CRUISEID

	SELECT distinct StartDate, EndDate,MainPrice,CruiseId
	FROM Cruise_Cabin_Price
	WHERE CruiseId = @CRUISEID

END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISEIMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_CRUISEIMAGES]
	-- Add the parameters for the stored procedure here
@CRUISEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT CruiseId, CruiseImgId, ImagePath 
	FROM Cruise_Image_Master
	WHERE CruiseId = @CRUISEID
END




GO
/****** Object:  StoredProcedure [dbo].[SP_FE_CRUISEMASTER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_CRUISEMASTER]

AS
BEGIN
	SET NOCOUNT ON;

	SELECT	CruiseId, CruiseName,AliasForTrip,NoOfDays, NoOfNights
	FROM	Cruise_Master
	ORDER BY InsertedOn, UpdatedOn DESC

END




GO
/****** Object:  StoredProcedure [dbo].[SP_FE_DESTINATION_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_FE_DESTINATION_FRONT]
	-- Add the parameters for the stored procedure here
	as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select PPID,LOCATIONID,TITLE,pd.IMAGEID,im.IMAGEPATH from PopularDestination pd inner join ImageMaster im on pd.ImageId=im.ImageId and pd.IsActive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_DESTINATION_LIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_DESTINATION_LIST]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

   select distinct NAME from (
select countryname as name from CountryMaster where Isactive=1
union all
select statename as name from STATEMASTER where Isactive=1
union all 
select cityname as name from CityMaster where Isactive=1
)as list;

END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_GET_TRIP_TYPES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_GET_TRIP_TYPES]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select TYPEID,upper(TYPENAME) as TYPENAME from TripTypeMaster where IsActive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_GETBANNER_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_GETBANNER_FRONT]
	-- Add the parameters for the stored procedure here
	as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select IMAGEPATH,QUERYSTRING from HomeBanner hm inner join ImageMaster im on hm.IMAGEID=im.ImageId ;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_GETMENU_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FE_GETMENU_FRONT]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select TYPEID,TYPENAME from TripTypeMaster where IsActive=1;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_GETSERVICE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_GETSERVICE_FRONT]
	-- Add the parameters for the stored procedure here
	as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select top 1 r.IMAGEID,im.IMAGEPATH from rent r inner join ImageMaster im on r.ImageId=im.ImageId where r.ImageId is not null;
	select top 1 r.IMAGEID,im.IMAGEPATH from BusinessTourImages r inner join businesstour b on b.businessid=r.tourid
inner join ImageMaster im on r.ImageId=im.ImageId where r.ImageId is not null;

	select top 1 r.IMAGEID,im.IMAGEPATH from visa r inner join ImageMaster im on r.ImageId=im.ImageId where r.ImageId is not null;

	select top 1 im.CruiseImgId as IMAGEID,im.IMAGEPATH from Cruise_Master r inner join Cruise_IMAGE_MASTER im on r.CruiseId=im.CruiseId where im.CruiseId is not null;

END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_GETTOURPACKAGE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_GETTOURPACKAGE_FRONT]
	-- Add the parameters for the stored procedure here
	as
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select IMAGEPATH,PACKAGEVALUE, PACKAGEID from TourPackage hm inner join ImageMaster im on hm.IMAGEID=im.ImageId ;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_HOME_BANNER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_HOME_BANNER]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;

   Select hm.BANNERID,im.IMAGEPATH from homebanner hm inner join ImageMaster im on hm.imageid=im.ImageId;

END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_ITENARY_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_ITENARY_DETAIL] 
	-- Add the parameters for the stored procedure here
	@TOURID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select ITENARYID,DAY,DAYDETAIL,im.IMAGEPATH,TRIPID AS TOURID from ItenaryMaster it 
	
	left join ImageMaster im on it.ImageId=im.ImageId where it.TripId=@TOURID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_MAIL_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_MAIL_DETAIL]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT TOP 1 DisplayName, EMailId FROM [SiddhiTours].MailDetails ORDER BY UpdatedOn DESC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_ONBOARDACTIVITES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_ONBOARDACTIVITES] 
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	CC.OnboardCategoryId, CM.COnboardId, CC.CategoryName
	FROM	Cruise_Onboard_Master CM
				INNER JOIN
			Cruise_Onboard_Category CC
					ON CC.OnboardId = CM.COnboardId
END




GO
/****** Object:  StoredProcedure [dbo].[SP_FE_POP_DESTINATION_LIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_POP_DESTINATION_LIST]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select PPID,im.IMAGEID,im.IMAGEPATH,pd.LOCATIONID,pd.TITLE from PopularDestination pd 
	inner join ImageMaster im on im.ImageId=pd.ImageId where pd.IsActive=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_PORTLIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_PORTLIST]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT PortId,PortName from Port_Master ORDER BY PortName
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_PORTNAMES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_PORTNAMES]
AS
BEGIN
	SET NOCOUNT ON;
	
	Select PortId, PortName as NAME FROM Port_Master ORDER BY UpdatedOn DESC
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_RENT_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FE_RENT_FRONT]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--select * from Rent;
    -- Insert statements for procedure here
	select RENTID,LOCATION,VEHICLETYPE,v.VEHICLENAME,r.VEHICLENAME as BRAND,COST,DESCRIPTION,TERMS,IMAGEPATH 
	from Rent r inner join ImageMaster im on r.ImageId=im.ImageId
	 inner join vehicleMaster v on r.VehicleType=v.VehicleId;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_RENT_LOCATION_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FE_RENT_LOCATION_FRONT]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct LOCATION from Rent;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_RENT_VEHICLE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FE_RENT_VEHICLE_FRONT]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select distinct VEHICLEID,VEHICLENAME from vehicleMaster;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_RENTLIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_RENTLIST]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select RENTID,LOCATION,VEHICLETYPE,VEHICLENAME,COST,DESCRIPTION,TERMS,IMAGEPATH from rent r inner join Imagemaster im
	on r.imageid=im.imageid;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_STATELIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_STATELIST]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select s.STATEID,s.STATENAME,c.COUNTRYNAME ,s.COUNTRYID
	from statemaster s inner join countrymaster c on s.countryid=c.countryid where s.isactive=1 and c.isactive=1;

END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TOKEN_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TOKEN_DETAIL]
	-- Add the parameters for the stored procedure here
	@TOKENID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT createdDate from resetPassword where tokenid=@TOKENID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TOUR_LIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[SP_FE_TOUR_LIST]
	-- Add the parameters for the stored procedure here
	
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
select TRIPID,TRIPTITLE as TITLE from tripmaster where TripStatus=1 ;--and iscompleted=1;







END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TOURPACKAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[SP_FE_TOURPACKAGE]
	-- Add the parameters for the stored procedure here

	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	select PACKAGEID,PACKAGEVALUE,IMAGEPATH from TOURPACKAGE tp inner join ImageMaster im on tp.imageid=im.ImageId;





END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRENDING]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[SP_FE_TRENDING]
	-- Add the parameters for the stored procedure here
	
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
select TRENDINGID,SEQUENCEID,upper(GROUPNAME) as GROUPNAME,PACKAGES from trendingmaster;





END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRENDING_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRENDING_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE 
   @rownum int;
   set @rownum=1; 
 Declare @temp table(
	packages varchar(max)
	
	);

   while  @rownum <= (select max(TrendingId) from TrendingMaster)  
   begin
   declare @packvalue varchar(max);
   set @packvalue=(select packages from TrendingMaster where TrendingId=@rownum);
    insert into @temp  select item from  dbo.SplitString(@packvalue,',');
	set @rownum=@rownum+1;
  END ; 

	--select packages from @temp
	--insert into @temp values(select item from (select dbo.SplitString(packages) from TrendingMaster))


    -- Insert statements for procedure here
	select SEQUENCEID,GROUPNAME,t.TRIPID,t.TRIPTITLE,t.TRIPDAYS,t.TRIPCOST,ti.TRIPIMAGEID,im.IMAGEPATH
		from TrendingMaster tm ,TripMaster t,TripImageMaster ti , ImageMaster im
		where  t.TripTitle in (select packages from @temp )
		and ti.ImageId=(select max(imageid) from TripImageMaster where tripid=t.TripId)
		and ti.ImageID=im.ImageId and t.tripcategory in (select typeid from triptypemaster where isactive=1)
		 order by SequenceId asc

--select * from TripImageMaster;

		
END


GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIP_DETAIL_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIP_DETAIL_FRONT]
	-- Add the parameters for the stored procedure here
@TRIPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPDAYS,t.TRIPCOST,t.TRIPINCLUSION,t.TRIPOVERVIEW,t.TRIPTHEME,t.TRIPLOCATION,t.SEAT,
	t.TRIPDATE,t.TODATE,t.TRIPCATEGORY ,tm.TYPENAME,im.IMAGEPATH,t.COUNTRY,t.STATE,t.CITY,t.TRIPEXCLUSION
	from TripMaster t inner join TripTypeMaster tm on t.TripCategory=tm.TypeId 
	left join TripImageMaster tim on t.TripId=tim.TripId left join ImageMaster im on tim.ImageId=im.ImageId
	 where t.TripId=@TRIPID ;--and 
	--t.IsCompleted=1 ;

	select it.DAY,it.DAYDETAIL,im.IMAGEPATH from ItenaryMaster it left join ImageMaster im on it.ImageId=im.ImageId where it.TripId=@TRIPID order by day asc;

	select t.TRIPID,t.TRIPTITLE,t.TRIPCOST,i.IMAGEPATH
	from TripMaster t left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId 
	where t.tripid!=@TRIPID and  t.tripcategory in (select typeid from triptypemaster where isactive=1) order by t.TripId desc;



END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPIMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPIMAGES]
	-- Add the parameters for the stored procedure here
@TRIPID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select TRIPID,tm.TRIPIMAGEID,IMAGEPATH from TripImageMaster tm inner join ImageMaster im on tm.ImageId=im.ImageId
	where tm.TripId=@TRIPID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPLIST_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPLIST_FRONT]
	-- Add the parameters for the stored procedure here
	@CATEGORYID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPTHEME,t.TRIPDAYS,t.TRIPLOCATION,t.COUNTRY,t.STATE,t.CITY,t.TRIPCOST,i.IMAGEPATH,t.TRIPCATEGORY
	from TripMaster t inner join TripTypeMaster tc on t.TripCategory=tc.TypeId and tc.IsActive=1
	left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId 
	where t.TripCategory=@CATEGORYID  order by t.TripId desc;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPLIST_PACKAGEWISE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPLIST_PACKAGEWISE_FRONT]
	-- Add the parameters for the stored procedure here
	@PACKAGE int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPTHEME,t.TRIPDAYS,t.TRIPLOCATION,t.COUNTRY,t.STATE,t.CITY,t.TRIPCOST,i.IMAGEPATH,t.TRIPCATEGORY
	from TripMaster t inner join TripTypeMaster tc on t.TripCategory=tc.TypeId and tc.IsActive=1 
	left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId where t.TripCost<=@PACKAGE order by t.TripId desc;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPLIST_SEARCHWISE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPLIST_SEARCHWISE_FRONT]
	-- Add the parameters for the stored procedure here
	@SEARCH varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Declare @LOCATION varchar(max);
	--set @LOCATION=(select locationid from popularDestination where title=@TITLE);
	--set @LOCATION='Mumb';




    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPTHEME,t.TRIPDAYS,t.TRIPLOCATION,t.COUNTRY,t.STATE,t.CITY,t.TRIPCOST,i.IMAGEPATH,t.TRIPCATEGORY
	from TripMaster t inner join TripTypeMaster tc on t.TripCategory=tc.TypeId and tc.IsActive=1 
	left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  
	from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId 
	where upper(t.TRIPLOCATION) like '%'+@SEARCH+'%' order by t.TripId desc;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPLIST_TITLEWISE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPLIST_TITLEWISE_FRONT]
	-- Add the parameters for the stored procedure here
	@TITLE varchar(100)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Declare @LOCATION varchar(max);
	set @LOCATION=(select locationid from popularDestination where title=@TITLE);
	--set @LOCATION='Mumb';




    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPTHEME,t.TRIPDAYS,t.TRIPLOCATION,t.COUNTRY,t.STATE,t.CITY,t.TRIPCOST,i.IMAGEPATH,t.TRIPCATEGORY
	from TripMaster t inner join TripTypeMaster tc on t.TripCategory=tc.TypeId and tc.IsActive=1 
	left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  
	from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId 
	where upper(t.TRIPLOCATION) like '%'+@location+'%' order by t.TripId desc;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPLIST_WITHOUTCASE_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_TRIPLIST_WITHOUTCASE_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Declare @LOCATION varchar(max);
	--set @LOCATION=(select locationid from popularDestination where title=@TITLE);
	--set @LOCATION='Mumb';




    -- Insert statements for procedure here
	select t.TRIPID,t.TRIPTITLE,t.TRIPTHEME,t.TRIPDAYS,t.TRIPLOCATION,t.COUNTRY,t.STATE,t.CITY,t.TRIPCOST,i.IMAGEPATH,t.TRIPCATEGORY
	from TripMaster t inner join TripTypeMaster tc on t.TripCategory=tc.TypeId and tc.IsActive=1 
	left join (select TripId,imageid,row_number() over (partition by TRIPID order  by TRIPIMAGEID desc) as cnt  
	from  TRIPIMAGEMASTER) bi 
	on t.TRIPID=bi.TripId and bi.cnt=1 inner join ImageMaster i on bi.ImageId=i.ImageId 
	--where upper(t.TRIPLOCATION) like '%'+@SEARCH+'%' 
	order by t.TripId desc;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPMASTER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPMASTER]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT tm.TRIPID,tm.TRIPTITLE,ti.TYPENAME as  TRIPCATEGORY,tm.TRIPCOST,tm.TRIPDATE as FROMDATE,tm.TRIPEXCLUSION,tm.TRIPINCLUSION,tm.TODATE,
	tm.TRIPLOCATION,tm.TRIPOVERVIEW,CASE when TripStatus=1 then 'ACTIVE' else 'INACTIVE' end as STATUS,
	tm.TRIPCOST,tm.SEAT,Tm.TRIPDAYS ,REPLACE(tm.TRIPTHEME,' ','')  as TRIPTHEME,tm.COUNTRY,tm.STATE,tm.CITY,ti.TYPEID
	from TripMaster tm 
	inner join   TripTypeMaster ti on tm.TripCategory=ti.TypeId
	--left join ImageMaster im on ti.TripImageID=im.ImageId
	 --where tm.IsCompleted=1;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_TRIPTHEME]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_TRIPTHEME] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select THEMEID,THEMENAME from thememaster;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_VEHICLEMASTER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_FE_VEHICLEMASTER]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select VEHICLEID,VEHICLENAME from VEHICLEMASTER;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_FE_VISA_COUNTRY_LIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_FE_VISA_COUNTRY_LIST]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 SELECT COUNTRYID,COUNTRYNAME from COUNTRYMASTER where countryid not in (select countryid from visa) and isactive=1;
END


GO
/****** Object:  StoredProcedure [dbo].[SP_FE_VISA_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_FE_VISA_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select VISAID,v.COUNTRYID,cm.COUNTRYNAME,COST,DocumentRequirment as DOC,v.IMAGEID,im.IMAGEPATH from visa v 
	inner join CountryMaster cm on v.CountryId=cm.CountryID inner join ImageMaster im on v.ImageId=im.ImageId
END



GO
/****** Object:  StoredProcedure [dbo].[SP_FE_VISALIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_FE_VISALIST]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT V.VisaId,V.CountryId, C.CountryName, V.Cost, V.DocumentRequirment
	FROM VISA V
			INNER JOIN
		 CountryMaster C
				ON V.CountryId = C.CountryID
END




GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_B2B]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_B2B]
	-- Add the parameters for the stored procedure here
	@TITLE varchar(max),
	@COST int,
	@LOCATION varchar(max),
	@INCLUSION varchar(max),
	@COUNTRY varchar(20),
	@STATE varchar(20),
	@CITY varchar(20)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--declare @IMAGEID integer;
	--declare @BUSINESSID integer;
    -- Insert statements for procedure here
	--insert into ImageMaster(ImagePath) values(@IMAGEPATH);
	--set @IMAGEID=SCOPE_IDENTITY();
	insert into BusinessTour(Title,Cost,Location,Inclusion,isactive,Country,State,City)
	values(@TITLE,@COST,@LOCATION,@INCLUSION,1,@COUNTRY,@STATE,@CITY);
	
	select 1 as status,SCOPE_IDENTITY() as id;	
	--set @BUSINESSID=SCOPE_IDENTITY();
	--insert into businesstourImages(TourID,imageid) values(@BUSINESSID,@IMAGEID); 
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_BUSINESS_IMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_BUSINESS_IMAGES]
	-- Add the parameters for the stored procedure here
	@BUSINESSID int,
	@IMAGEPATH varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @IMAGEID integer;
 -- Insert statements for procedure here
	insert into ImageMaster(ImagePath) values(@IMAGEPATH);
    -- Insert statements for procedure here
	set @IMAGEID=SCOPE_IDENTITY();
	insert into businessTourImages(tourid,imageid)values(@BUSINESSID,@IMAGEID);

	select 1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CABIN_IMAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_INSERT_CABIN_IMAGE]
		@CRUISEID INT,
	    @CABINID INT,
		@IMAGEPATH VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Cruise_Image_Master(ImagePath)
	VALUES(@IMAGEPATH)

	UPDATE Cruise_Cabin_Price SET CuriseImgId = SCOPE_IDENTITY() WHERE CruiseId = @CRUISEID AND CruiseCabinId = @CABINID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CABIN_PRICE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_CABIN_PRICE]
		@CRUISEID INT,
	    @CABINTYPE INT,
        @STARTDATE DATETIME,
        @ENDDATE DATETIME,
		@PRICE DECIMAL(18,2),
		@MAINPRICE DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Cruise_Cabin_Price(CruiseId,CruiseCabinId,StartDate,EndDate,Price,MainPrice)
	VALUES(@CRUISEID,@CABINTYPE,@STARTDATE,@ENDDATE,@PRICE,@MAINPRICE)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CITY]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_CITY]
	-- Add the parameters for the stored procedure here
	@STATE int,
	@CITY varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from citymaster where UPPER(cityname)=UPPER(@CITY) and stateid=@STATE and Isactive=1) 
	begin
	select 0 as status;
	end
	else
	begin
	insert into citymaster(cityname,stateid,isactive)values(@CITY,@STATE,1);

	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_COMPANYNAME]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_COMPANYNAME] 
	-- Add the parameters for the stored procedure here
	@COMPANYNAME varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT CompanyId FROM Cruise_Company_master WHERE CompanyName = @COMPANYNAME)
		BEGIN
			SELECT 0 AS STATUS, 0 AS ID
		END
	ELSE
		BEGIN
			INSERT INTO Cruise_Company_Master(CompanyName,InsertedOn,UpdatedOn)values(@COMPANYNAME,GETDATE(),GETDATE());
			SELECT 1 AS STATUS, SCOPE_IDENTITY() AS ID
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_COUNTRY]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_COUNTRY]
	-- Add the parameters for the stored procedure here
	@COUNTRY varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from countrymaster where upper(countryname)=upper(@COUNTRY) and Isactive=1)
	begin
	select 0 as status;
	end
	else
	begin
	Insert into countrymaster(CountryName,Isactive)values(@COUNTRY,1);
	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CRUISE_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_CRUISE_DETAIL]
	    @TITLE varchar(500),
        @NODAYS INT,
        @NONIGHTS INT,
		@ALIASNAME varchar(500),
		@COMPANY INT,
		@TAX INT,
		@GADULT INT,
		@GCHILD INT,
        @PORTSOURCENAME VARCHAR(500),
        @PORTDESTINATIONNAME VARCHAR(500),
		@INCLUSION varchar(max),
		@EXCLUSION varchar(max)--,
		--@MAINPRICE DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Cruise_Master(CruiseName,NoOfDays,NoOfNights,AliasForTrip,CompanyId,PortSourceName,PortDestinationName,TaxPerPerson,GratuityForAdult,GratuityForChild,Inclusions,Exclusions,InsertedOn,UpdatedOn)--,MainPrice)
	VALUES(@TITLE,@NODAYS,@NONIGHTS,@ALIASNAME,@COMPANY,@PORTSOURCENAME,@PORTDESTINATIONNAME,@TAX,@GADULT,@GCHILD,@INCLUSION,@EXCLUSION,GETDATE(),GETDATE())--,@MAINPRICE)

	select SCOPE_IDENTITY() as id,1 as status;
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_CRUISE_IMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SP_INSERT_CRUISE_IMAGES]
	-- Add the parameters for the stored procedure here
	@CRUISEID int,
	@IMAGEPATH varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Cruise_Image_Master(CruiseId,ImagePath)values(@CRUISEID, @IMAGEPATH);
END


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_HOME_BANNER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_HOME_BANNER]
	-- Add the parameters for the stored procedure here
	@STRING varchar(100),
	@IMAGEPATH varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	declare @IMAGEID integer;
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into ImageMaster (imagepath)values(@IMAGEPATH);
	set @IMAGEID=SCOPE_IDENTITY();

	insert into HomeBanner(querystring,imageid)values(@STRING,@IMAGEID);

END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ITENARY_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_ITENARY_DETAIL] 
	-- Add the parameters for the stored procedure here
	@TOURID int,
	@DAY int,
	@DETAIL varchar(max)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @TOTALDAYS integer;
	declare @itenaryDays integer;
	set @TOTALDAYS=(select TripDays from TripMaster where TripId=@TOURID)
    -- Insert statements for procedure here
	--Insert into ImageMaster(ImagePath)values(@IMAGEPATH);
	--set @IMAGEID=SCOPE_IDENTITY();
	
	insert into ItenaryMaster(TripId,Day,DayDetail)values(@TOURID,@DAY,@DETAIL);
	select 1 as status,SCOPE_IDENTITY() as id;

	set @itenaryDays=(select count(*) from ItenaryMaster where TripId=@TOURID);
	if(@TOTALDAYS=@itenaryDays)
	begin
	update TripMaster set isItenary=1 where TripId=@TOURID;
	end

END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ITINEARY_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_ITINEARY_DETAIL]
		@CRUISEID INT,
	    @DAY INT,
		@DETAIL VARCHAR(MAX),
		@ARRIVAL VARCHAR(MAX),
		@DEPART VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO Cruise_Itinerary_Master(CruiseId,Day,Detail,Arrival,Departature)
	VALUES(@CRUISEID,@DAY,@DETAIL,@ARRIVAL,@DEPART)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_ONBOARD_ACTIVITIES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_ONBOARD_ACTIVITIES]
		@CRUISEID INT,
	    @ONBOARDCATEGORYID INT,
		@FLAG VARCHAR(1) = ''
AS
BEGIN
	SET NOCOUNT ON;

	IF(@FLAG = 'U')
		BEGIN
			DELETE FROM Cruise_Onboard_Activities WHERE CruiseId = @CRUISEID AND OnboardCategoryId = @ONBOARDCATEGORYID
		END

	INSERT INTO Cruise_Onboard_Activities(CruiseId, OnboardCategoryId)
	VALUES(@CRUISEID,@ONBOARDCATEGORYID)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_PortName]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create PROCEDURE [dbo].[SP_INSERT_PortName]
	-- Add the parameters for the stored procedure here
	@PORTNAME varchar(500)
AS
BEGIN
	
	SET NOCOUNT ON;
	    
	IF EXISTS (select PortId from Port_Master WHERE UPPER(PortName)=UPPER(@PORTNAME))
		BEGIN
			SELECT 0 as status;
		END
	ELSE
		BEGIN
			INSERT INTO Port_Master(PortName,InsertedOn,UpdatedOn)values(@PORTNAME,GETDATE(),GETDATE());		
			SELECT 1 as status;
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_RENT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_RENT]
	-- Add the parameters for the stored procedure here
	@LOCATION varchar(100),
	@TYPE varchar(100),
	@NAME varchar(100),
	@COST int,
	@DESCRIPTION varchar(max),
	@TERMS varchar(max)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into Rent(location,VehicleType,VehicleName,Cost,Description,Terms)
	values(@LOCATION,@TYPE,@NAME,@COST,@DESCRIPTION,@TERMS);

	select 1 as status,SCOPE_IDENTITY() as id;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_RESET_TOKEN]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_RESET_TOKEN]
	-- Add the parameters for the stored procedure here
	@TOKENID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT into resetPassword(TOKENID,createdDate)values(@TOKENID,getdate());
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_SHIPINFO]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_INSERT_SHIPINFO]
		@CRUISEID INT,
	    @SHIPID INT,
	    @DETAIL VARCHAR(250),
		@FLAG VARCHAR(1) = ''
AS
BEGIN
	SET NOCOUNT ON;

	IF(@FLAG = 'U')
		BEGIN
			DELETE FROM Ship_General_Activities WHERE CruiseId = @CRUISEID AND ShipId = @SHIPID
		END
	INSERT INTO Ship_General_Activities(CruiseId, ShipId, Detail)
	VALUES(@CRUISEID, @SHIPID,@DETAIL)
END

GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_STATE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_STATE] 
	-- Add the parameters for the stored procedure here
@STATE varchar(50),
@COUNTRY bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from statemaster where upper(statename)=upper(@state) and countryid=@COUNTRY and Isactive=1)
	begin
	select 0 as status;
	end
	else 
	begin
	insert into STATEMASTER(statename,Countryid,isactive)values(@STATE,@COUNTRY,1);
	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRENDING]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_INSERT_TRENDING]
	-- Add the parameters for the stored procedure here
@SEQUENCE int,
@GROUPNAME varchar(100),
@PACKAGE varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	insert into trendingmaster(SequenceId,Groupname,Packages)
	values(@SEQUENCE,@GROUPNAME,@PACKAGE);
   
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRIP_IMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_TRIP_IMAGES]
	-- Add the parameters for the stored procedure here
	@TRIPID int,
	@IMAGEPATH varchar(max)
AS
BEGIN
declare @maxid integer;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into ImageMaster(ImagePath)values(@IMAGEPATH);
	
	insert into TripImageMaster(TripId,ImageId)values(@TRIPID,SCOPE_IDENTITY());
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRIPMASTER_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE  PROCEDURE [dbo].[SP_INSERT_TRIPMASTER_DETAIL]
	-- Add the parameters for the stored procedure here
	    @TITLE varchar(100),
        @LOCATION varchar(100),
        @COST varchar(20),
		@TOUR varchar(50),
        @TOURSEAT int,
        @TOURDATE date,
	@THEME varchar(max),
	@OVERVIEW varchar(max),
	@INCLUSION varchar(max),
	@STATUS bit,
	@EXCLUSION varchar(max),
	@TODATE datetime,
	@DAYS int,
	@COUNTRY varchar(50),
	@STATE varchar(50),
	@CITY varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into TripMaster(TripTitle,TripLocation,TripCost,TripCategory,seat,TripDate,Triptheme,
	TripOverview,TripInclusion,TripExclusion,TripStatus,ToDate,TripDays,Country,state,city)
	values(@TITLE,@LOCATION,@COST,@TOUR,@TOURSEAT,@TOURDATE,@THEME,@OVERVIEW,@INCLUSION,@EXCLUSION,@STATUS,@TODATE,@DAYS,@COUNTRY,@STATE,@CITY);

	select max(tripid) as id,1 as status from TripMaster;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRIPMASTER_TAB1]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_TRIPMASTER_TAB1]
	-- Add the parameters for the stored procedure here
	    @TITLE varchar(100),
        @LOCATION varchar(100),
        @COST varchar(20),
		@TOUR varchar(50),
        @TOURSEAT int,
        @TOURDATE date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into TripMaster(TripTitle,TripLocation,TripCost,TripCategory,seat,TripDate)
	values(@TITLE,@LOCATION,@COST,@TOUR,@TOURSEAT,@TOURDATE);

	select SCOPE_IDENTITY() as id,1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRIPMASTER_TAB2]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_INSERT_TRIPMASTER_TAB2]
	-- Add the parameters for the stored procedure here
	  @TRIPID int,
	  @THEME varchar(100),
	  @OVERVIEW varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update TripMaster set TripOverview=@OVERVIEW ,Triptheme =@THEME where TripId=@TRIPID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_TRIPTYPE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_INSERT_TRIPTYPE] 
	-- Add the parameters for the stored procedure here
	@TRIPTYPE varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into TripTypeMaster(TypeName,IsActive,CreatedDate)values(@TRIPTYPE,1,getdate());
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_VISA_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_INSERT_VISA_DETAIL]
	@CountryId INT,
	@Cost INT,
	@DocReq VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Visa(CountryId,Cost,DocumentRequirment,InsertedOn)
	VALUES(@CountryId,@Cost,@DocReq, GETDATE())

	SELECT SCOPE_IDENTITY() AS ID
END



GO
/****** Object:  StoredProcedure [dbo].[SP_INSERT_VISA_IMAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[SP_INSERT_VISA_IMAGE]
	@VisaId INT,
	@ImgPath VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ImgId INT = 0

	INSERT INTO ImageMaster(ImagePath)
	VALUES(@ImgPath)

	SELECT @ImgId = SCOPE_IDENTITY()

	IF @ImgId > 0
		BEGIN
			UPDATE Visa SET ImageId = @ImgId WHERE VisaId = @VisaId
			SELECT 1 AS STATUS
		END	
	 ELSE
		BEGIN
			SELECT 0 AS STATUS
		END
END



GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_IMAGES]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_RENT_IMAGES]
	-- Add the parameters for the stored procedure here
	@IMAGEPATH varchar(max),
	@RENTID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @imageid  integer;
    -- Insert statements for procedure here
	insert into ImageMaster(ImagePath)values(@IMAGEPATH);
	set @imageid=(select SCOPE_IDENTITY());

	update rent set imageid=@imageid where rentid=@RENTID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ABOUTUS]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_ABOUTUS]
	-- Add the parameters for the stored procedure here
	@CONTENT varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	truncate table aboutus;
	insert into aboutus(aboutcontent)values(@CONTENT);
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ABOUTUS_IMAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_ABOUTUS_IMAGE]
	@IMGPATH VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE ABOUTUS 
	SET ImagePath = @IMGPATH
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ADMIN_PASSWORD]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_ADMIN_PASSWORD]
	-- Add the parameters for the stored procedure here
	@PASSWORD varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update Adminlogin set Password=@PASSWORD;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_B2B]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_B2B]
	-- Add the parameters for the stored procedure here
	@TOURID int,
	@TITLE varchar(max),
	@COST int,
	@COUNTRY varchar(50),
	@STATE varchar(50),
	@CITY varchar(50),
	@LOCATION varchar(max),
	@INCLUSION varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update BusinessTour 
	set Title=@TITLE,Cost=@COST,COUNTRY=@COUNTRY,State=@STATE,city=@CITY,Location=@LOCATION,Inclusion=@INCLUSION
	where BusinessId=@TOURID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CABIN_DESCRIPTION]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_UPDATE_CABIN_DESCRIPTION]
	@CRUISEID INT,
	@CABINID INT,
	@DESCRIPTION VARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Cruise_Cabin_Price 
	SET Description = @DESCRIPTION
	WHERE CruiseId = @CRUISEID
		  AND CruiseCabinId = @CABINID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CABIN_PRICE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_CABIN_PRICE]
		@CRUISEID INT,
	    @CABINTYPE INT,
        @STARTDATE DATETIME,
        @ENDDATE DATETIME,
		@PRICE DECIMAL(18,2),
		@CURCABPRICEID INT,
		@MAINPRICE DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON;

	IF(@CURCABPRICEID = 0)
		BEGIN
			INSERT INTO Cruise_Cabin_Price(CruiseId,CruiseCabinId,StartDate,EndDate,Price,MainPrice)
			VALUES(@CRUISEID,@CABINTYPE,@STARTDATE,@ENDDATE,@PRICE,@MainPrice)
		END
	ELSE
		BEGIN
			UPDATE Cruise_Cabin_Price
			SET StartDate = @STARTDATE, EndDate = @ENDDATE, Price = @PRICE,MainPrice=@MAINPRICE
			WHERE CurCabPriceId = @CURCABPRICEID
		END	
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CITY]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_CITY]
	-- Add the parameters for the stored procedure here
	
	
	@CITYID bigint,
	@CITYNAME varchar(50),
	@STATEID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from citymaster where upper(cityname)=upper(@cityname) and Isactive=1)
	begin
	select 0 as status;
	end
	else
	begin
	update citymaster set stateid=@STATEID,CITYNAME=@CITYNAME where cityid=@CITYID;
	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_COMPANYIMAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UPDATE_COMPANYIMAGE]
	@COMPID INT,
	@PATH varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	UPDATE Cruise_Company_Master set imagePath= @PATH, UpdatedOn = GETDATE() where CompanyId = @COMPID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_COMPANYNAME]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_COMPANYNAME]
	@COMPID int,@NAME varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT CompanyId FROM Cruise_Company_master WHERE CompanyId <> @COMPID AND CompanyName = @NAME)
		BEGIN
			SELECT 0 AS STATUS
		END
	ELSE
		BEGIN
			UPDATE Cruise_Company_Master set CompanyName = @NAME, UpdatedOn = GETDATE() where CompanyId = @COMPID
			SELECT 1 AS STATUS
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CONTACTUS]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_CONTACTUS]
	-- Add the parameters for the stored procedure here
	@ADDRESS varchar(max),
	@MOBILE1 varchar(20),
	@MOBILE2 varchar(20),
	@EMAIL varchar(100),
	@GOOGLE varchar(100),
	@FB varchar(100),
	@INSTAGRAM varchar(100),
	@WHATSAPP1 bit,
	@WHATSAPP2 bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @count_val INTEGER;
	set @count_val=(select count(*) from contactus)
    -- Insert statements for procedure here
	if( @count_val = 0)

	begin
		insert into contactus(Address_data,phone1,phone2,googlemaplink,fb,instagram,email,iswhatsapp1,iswhatsapp2)
	values(@ADDRESS,@MOBILE1,@MOBILE2,@GOOGLE,@FB,@INSTAGRAM,@EMAIL,@WHATSAPP1,@WHATSAPP2);
	end
	else
	begin
	update contactus 
	set address_data=@ADDRESS,phone1=@MOBILE1,phone2=@MOBILE2,
	googlemaplink=@GOOGLE,fb=@FB,instagram=@INSTAGRAM,email=@EMAIL,iswhatsapp1=@WHATSAPP1,iswhatsapp2=@WHATSAPP2;

	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_COUNTRY]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_COUNTRY]
	-- Add the parameters for the stored procedure here
	@COUNTRYNAME varchar(50),
	@COUNTRYID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from countrymaster where upper(countryname)=upper(@COUNTRYNAME) and Isactive=1)
	begin
	select 0 as status;
	end
	else
	begin
	update countrymaster set countryname=@COUNTRYNAME where countryid=@COUNTRYID;
	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_CRUISE_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_CRUISE_DETAIL]
		@CRUISEID INT,
	    @TITLE varchar(500),
        @NODAYS INT,
        @NONIGHTS INT,
		@ALIASNAME varchar(500),
		@COMPANY INT,
		@TAX INT,
		@GADULT INT,
		@GCHILD INT,
        @PORTSOURCENAME VARCHAR(500),
        @PORTDESTINATIONNAME VARCHAR(500),
		@INCLUSION varchar(max),
		@EXCLUSION varchar(max)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE Cruise_Master SET CruiseName = @TITLE,NoOfDays = @NODAYS, NoOfNights = @NONIGHTS, AliasForTrip = @ALIASNAME, CompanyId = @COMPANY, PortSourceName = @PORTSOURCENAME, PortDestinationName = @PORTDESTINATIONNAME,TaxPerPerson = @TAX, GratuityForAdult = @GADULT, GratuityForChild = @GCHILD, Inclusions = @INCLUSION, Exclusions = @EXCLUSION, UpdatedOn = GETDATE()
	WHERE CruiseId = @CRUISEID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ITENARY_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_UPDATE_ITENARY_DETAIL] 
	-- Add the parameters for the stored procedure here
	
	@ITENARYID int,
	
	@DETAIL varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
update itenaryMaster set daydetail=@DETAIL where itenaryId=@ITENARYID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ITENARY_IMAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_UPDATE_ITENARY_IMAGE] 
	-- Add the parameters for the stored procedure here
	@ITENARYID int,
	@IMAGEPATH varchar(max)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	Declare @IMAGEID integer
    -- Insert statements for procedure here
	Insert into ImageMaster(ImagePath)values(@IMAGEPATH);
	set @IMAGEID=SCOPE_IDENTITY();

	update ItenaryMaster set ImageId=@IMAGEID where ItenaryId=@ITENARYID;

	
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_ITINEARY_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[SP_UPDATE_ITINEARY_DETAIL]
		@CRUISEID INT,
	    @DAY INT,
		@DETAIL VARCHAR(MAX),
		@ARRIVAL VARCHAR(MAX),
		@DEPART VARCHAR(MAX),
		@ITINERARYID INT
AS
BEGIN
	SET NOCOUNT ON;

	IF @ITINERARYID = 0
		BEGIN
			INSERT INTO Cruise_Itinerary_Master(CruiseId,Day,Detail,Arrival,Departature)
			VALUES(@CRUISEID,@DAY,@DETAIL,@ARRIVAL,@DEPART)
		END
	ELSE
		BEGIN
			UPDATE Cruise_Itinerary_Master 
			SET Day = @DAY, Detail = @DETAIL, Arrival = @ARRIVAL, Departature = @DEPART
			WHERE ItineraryId = @ITINERARYID
		END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_MAIL_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_MAIL_DETAIL]
	@DISPLAYNAME varchar(100),@EMAILID varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT MailId FROM [SiddhiTours].MailDetails)
		BEGIN
			UPDATE [SiddhiTours].MailDetails SET EMailId = @EMAILID, DisplayName = @DISPLAYNAME, UpdatedOn = GETDATE()
		END
	ELSE
		BEGIN
			INSERT INTO [SiddhiTours].MailDetails VALUES(@EMAILID,@DISPLAYNAME,GETDATE(),GETDATE())
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_PORTNAME]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_PORTNAME]
	@PORTID int,@NAME varchar(500)
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT PortId FROM Port_Master WHERE PortId <> @PORTID AND PortName = @NAME)
		BEGIN
			SELECT 0 AS STATUS
		END
	ELSE
		BEGIN
			UPDATE Port_Master set PortName = @NAME, UpdatedOn = GETDATE() where PortId = @PORTID
			SELECT 1 AS STATUS
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_RENT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_RENT]
	-- Add the parameters for the stored procedure here
	@LOCATION varchar(100),
	@TYPE varchar(100),
	@NAME varchar(100),
	@COST int,
	@DESCRIPTION varchar(max),
	@TERMS varchar(max),
	@RENTID int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
update rent 
set location=@LOCATION,vehicletype=@TYPE,Vehiclename=@NAME,Cost=@COST,description=@DESCRIPTION,terms=@TERMS where rentid=@RENTID;

select 1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_STATE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_STATE]
	-- Add the parameters for the stored procedure here
	
	@COUNTRYID bigint,
	@STATENAME varchar(50),
	@STATEID bigint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if exists(select * from statemaster where upper(statename)=upper(@STATENAME))
	begin
	select 0 as status;
	end
	else
	begin
	update statemaster set statename=@STATENAME,countryid=@COUNTRYID where stateid=@STATEID;
	select 1 as status;
	end
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TOURPACKAGE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_TOURPACKAGE]
	-- Add the parameters for the stored procedure here
	@PACKAGEID int,
	@PACKAGE bigint,
	@IMAGEPATH varchar(max)
	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @IMAGEID integer;
    -- Insert statements for procedure here
	set @IMAGEID=(select imageid from tourpackage where packageid=@PACKAGEID);

	if(upper(@IMAGEPATH)!='')
	begin
update ImageMaster set ImagePath=@IMAGEPATH where ImageId=@IMAGEID;
	end

 


END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TREND]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_TREND] 
	-- Add the parameters for the stored procedure here
	@TRENDID int,
	@TREND int,
	@GRP varchar(100),
	@PACKAGE varchar(max),
	@OLDID int,
	@OLDSEQ int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(@OLDID<>0 and @OLDSEQ<>0)
	begin
	update trendingmaster
	set sequenceid=(select sequenceid from trendingmaster where trendingid=@TRENDID)
	where trendingid=@OLDID;
	end
	update trendingmaster
	set sequenceid=@TREND,groupname=@GRP,packages=@PACKAGE where trendingid=@TRENDID;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TRIPMASTER_DETAIL]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create  PROCEDURE [dbo].[SP_UPDATE_TRIPMASTER_DETAIL]
	-- Add the parameters for the stored procedure here
	    @TITLE varchar(100),
        @LOCATION varchar(100),
        @COST varchar(20),
		@TOUR varchar(50),
        @TOURSEAT int,
        @TOURDATE date,
	@THEME varchar(max),
	@OVERVIEW varchar(max),
	@INCLUSION varchar(max),
	@STATUS bit,
	@EXCLUSION varchar(max),
	@TODATE datetime,
	@DAYS int,
	@COUNTRY varchar(50),
	@STATE varchar(50),
	@CITY varchar(50),
	@TOURID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Update TripMaster set  TripTitle=@TITLE,TripLocation=@LOCATION,TripCost=@COST,TripCategory=@TOUR,seat=@TOURSEAT,
	TripDate=@TOURDATE,Triptheme=@THEME,
	TripOverview=@OVERVIEW,TripInclusion=@INCLUSION,TripExclusion=@EXCLUSION,TripStatus=@STATUS,ToDate=@TODATE,
	TripDays=@DAYS,COUNTRY=@COUNTRY,state=@STATE,city=@CITY where TripId=@TOURID
	

	select SCOPE_IDENTITY() as id,1 as status;
END



GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TRIPTYPE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SP_UPDATE_TRIPTYPE]
	-- Add the parameters for the stored procedure here
	@TYPEID int,@TYPENAME varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	UPDATE TripTypeMaster set TypeName=@TYPENAME where TypeId=@TYPEID;
END



GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_DELETE_CABIN_PRICE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_DELETE_CABIN_PRICE]
	-- Add the parameters for the stored procedure here
	@CRUISEID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from Cruise_Cabin_Price where cruiseid=@cruiseId
END


GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_DELETE_CRUISE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_DELETE_CRUISE]
	@CRUISEID INT
AS
BEGIN
	SET NOCOUNT ON;

	DELETE from Cruise_master where cruiseId = @CRUISEID
	DELETE from Cruise_cabin_price where cruiseId = @CRUISEID
	DELETE from Cruise_itinerary_master where cruiseId = @CRUISEID
	DELETE from Cruise_Image_master where cruiseId = @CRUISEID
	DELETE from Cruise_Onboard_Activities where cruiseId = @CRUISEID
	DELETE from Ship_General_Activities where cruiseId = @CRUISEID
END


GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_DELETE_CRUISECABINDATE]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_DELETE_CRUISECABINDATE] 
	-- Add the parameters for the stored procedure here
	@CRUISEID int,
	@FROM date,
	@TO date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from cruise_cabin_price where cruiseid=@cruiseid and startdate=@from and endDate=@TO;
END


GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_FE_CRUISE_DETAIL_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_FE_CRUISE_DETAIL_FRONT] 
	-- Add the parameters for the stored procedure here
	@CRUISEID int,
	@DATE date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select cm.CRUISEID,CRUISENAME,PORTSOURCENAME,PORTDESTINATIONNAME,ALIASFORTRIP as TITLE,NOOFDAYS as DAYS,
	NOOFNIGHTS as NIGHTS,
	INCLUSIONS,EXCLUSIONS,ci.IMAGEPATH,cm.GRATUITYFORADULT as ADULT,GRATUITYFORCHILD as CHILD,TAXPERPERSON as TAX
	 from cruise_master cm left join cruise_image_master ci  on cm.cruiseId=ci.cruiseid where cm.cruiseid=@cruiseId ;

	 --select * from cruise_image_master;
	 --select * from cruise_cabin_price;
	 --select * from Cruise_Cabin_master;


	 --select * from cruise_master;
	 --select * from CRUISE_itinerary_Master;
	 --select * from cruise_onboard_activities;
	 --select * from cruise_onboard_Category;
	 --select * from cruise_onboard_master;




	 select cp.CruiseCabinId as CABINID,cp.cruiseid as CRUISEID,cc.CABINNAME,Cp.CURISEIMGID,
	 isnull(cp.DESCRIPTION,'') as DESCRIPTION,im.IMAGEPATH,
	 max(cp.PRICE) as PRICE,cp.MAINPRICE,STARTDATE,ENDDATE--,cp.* 
	 from cruise_cabin_price cp
	  inner join Cruise_Cabin_master  cc on cp.CruiseCabinId=cc.cabinid inner  join cruise_IMAGE_MASTER im 
	  on cp.CURISEIMGID=im.CRUISEIMGID where cp.CRUISEID=@cruiseId and StartDate=@DATE
	  group by cp.CruiseCabinId,cp.cruiseid,cc.CABINNAME,Cp.CURISEIMGID,DESCRIPTION,
	  im.IMAGEPATH,cp.mainprice,StartDate,ENDDATE order by CruiseCabinId asc ;

	 select ITINERARYID,CRUISEID,DAY,DETAIL,ARRIVAL,DEPARTATURE 
	  from CRUISE_itinerary_Master where CRUISEID=@cruiseId;

	  select com.CONBOARDID,com.CONBOARDNAME,co.ONBOARDCATEGORYID,co.CATEGORYNAME,co.ICON from cruise_onboard_activities ca 
	  inner join cruise_onboard_Category co on ca.ONBOARDCATEGORYID=co.ONBOARDCATEGORYID
	  inner join cruise_onboard_master com on com.conboardid=co.onBoardid where ca.cruiseid=@cruiseId;

	  select sm.SHIPNAME,FAICONNAME,DETAIL from ship_general_activities sga inner join ship_general_master sm 
	  on sga.shipid=sm.shipid where sga.cruiseid=@cruiseid ;

	  End

	


GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_FE_CRUISE_LIST_FRONT]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_FE_CRUISE_LIST_FRONT]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    -- Insert statements for procedure here

	select cm.CRUISEID,CRUISENAME,ALIASFORTRIP as TITLE,cm.PORTDESTINATIONNAME as LOCATION,bi.IMAGEPATH,NOOFDAYS as DAYS,cm.MainPrice PRICE, 
	CCM.CompanyId,CCM.IMAGEPATH  as COMPANYIMAGE from cruise_Master cm
	LEFT JOIN dbo.Cruise_Company_master CCM 
				ON 	CCM.CompanyId = cm.CompanyId
	left join (select CRUISEID,CRUISEIMGID,IMAGEPATH,row_number() over (partition by CRUISEID order  by CRUISEIMGID desc) 
	as cnt  from  cruise_Image_master) bi 
	on cm.CRUISEID=bi.CRUISEID and bi.cnt=1 
	left join (select min(price) as price,cruiseId from Cruise_Cabin_Price cp group by  cruiseId) cp  
	on cm.CRUISEID=cp.CRUISEID 
	order by cm.CRUISEID desc;

	select distinct startdate as DATE,cm.cruiseid as CRUISEID from cruise_Cabin_Price cp
	 inner join cruise_master  cm on cp.cruiseid=cm.cruiseid where cp.cruisecabinid=1;
	 
	
END

GO
/****** Object:  StoredProcedure [SiddhiTours].[SP_FE_VISA_COUNTRY_LIST]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [SiddhiTours].[SP_FE_VISA_COUNTRY_LIST]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 SELECT COUNTRYID,COUNTRYNAME from COUNTRYMASTER where countryid not in (select countryid from visa) and isactive=1;
END


GO
/****** Object:  UserDefinedFunction [dbo].[SplitString]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SplitString]
(    
      @Input NVARCHAR(MAX),
      @Character CHAR(1)
)
RETURNS @Output TABLE (
      Item NVARCHAR(1000)
)
AS
BEGIN
      DECLARE @StartIndex INT, @EndIndex INT
 
      SET @StartIndex = 1
      IF SUBSTRING(@Input, LEN(@Input) - 1, LEN(@Input)) <> @Character
      BEGIN
            SET @Input = @Input + @Character
      END
 
      WHILE CHARINDEX(@Character, @Input) > 0
      BEGIN
            SET @EndIndex = CHARINDEX(@Character, @Input)
           
            INSERT INTO @Output(Item)
            SELECT SUBSTRING(@Input, @StartIndex, @EndIndex - 1)
           
            SET @Input = SUBSTRING(@Input, @EndIndex + 1, LEN(@Input))
      END
 
      RETURN
END



GO
/****** Object:  Table [dbo].[ABOUTUS]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ABOUTUS](
	[ABOUTID] [int] IDENTITY(1,1) NOT NULL,
	[ABOUTCONTENT] [varchar](max) NULL,
	[ImagePath] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[ABOUTID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Adminlogin]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Adminlogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](100) NULL,
	[Password] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BusinessTour]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BusinessTour](
	[BusinessID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](max) NULL,
	[Cost] [int] NULL,
	[Location] [varchar](max) NULL,
	[Inclusion] [varchar](max) NULL,
	[Isactive] [bit] NULL,
	[Country] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BusinessTourImages]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessTourImages](
	[BusinessImageID] [int] IDENTITY(1,1) NOT NULL,
	[TourId] [int] NULL,
	[ImageId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BusinessImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CityMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CityMaster](
	[CityID] [bigint] IDENTITY(1,1) NOT NULL,
	[CityName] [varchar](50) NULL,
	[StateId] [bigint] NULL,
	[Isactive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CityID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactUs]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactUs](
	[contactId] [int] IDENTITY(1,1) NOT NULL,
	[Address_Data] [varchar](max) NULL,
	[Phone1] [varchar](20) NULL,
	[Phone2] [varchar](20) NULL,
	[GoogleMapLink] [varchar](200) NULL,
	[FB] [varchar](100) NULL,
	[Instagram] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[IsWhatsapp1] [bit] NULL,
	[IsWhatsapp2] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[contactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CountryMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CountryMaster](
	[CountryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](50) NULL,
	[Isactive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Cabin_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Cabin_Master](
	[CabinId] [int] IDENTITY(1,1) NOT NULL,
	[CabinName] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Cabin_Price]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Cabin_Price](
	[CurCabPriceId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[CruiseCabinId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Price] [decimal](18, 2) NULL,
	[CuriseImgId] [int] NULL,
	[Description] [varchar](max) NULL,
	[MainPrice] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Company_master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Company_master](
	[CompanyId] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](500) NULL,
	[InsertedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[ImagePath] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[CompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Image_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Image_Master](
	[CruiseImgId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[ImagePath] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Itinerary_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Itinerary_Master](
	[ItineraryId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[Day] [int] NULL,
	[Detail] [varchar](max) NULL,
	[Arrival] [varchar](max) NULL,
	[Departature] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Master](
	[CruiseId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseName] [varchar](500) NULL,
	[Inclusions] [varchar](max) NULL,
	[Exclusions] [varchar](max) NULL,
	[PortSourceName] [varchar](500) NULL,
	[PortDestinationName] [varchar](500) NULL,
	[AliasForTrip] [varchar](500) NULL,
	[NoOfDays] [int] NULL,
	[NoOfNights] [int] NULL,
	[InsertedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
	[CompanyId] [int] NULL,
	[TaxPerPerson] [int] NULL,
	[GratuityForAdult] [int] NULL,
	[GratuityForChild] [int] NULL,
	[MainPrice] [decimal](18, 2) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Onboard_Activities]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cruise_Onboard_Activities](
	[CurOnActId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[OnboardCategoryId] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cruise_Onboard_Category]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Onboard_Category](
	[OnboardCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[OnboardId] [int] NULL,
	[CategoryName] [varchar](200) NULL,
	[Icon] [nvarchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Cruise_Onboard_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cruise_Onboard_Master](
	[COnboardId] [int] IDENTITY(1,1) NOT NULL,
	[COnboardName] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Curise_Date_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Curise_Date_Master](
	[CruiseDateId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Price] [decimal](18, 2) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HomeBanner]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HomeBanner](
	[BannerId] [int] IDENTITY(1,1) NOT NULL,
	[QueryString] [varchar](100) NULL,
	[IMAGEID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BannerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ImageMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImageMaster](
	[ImageId] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [varchar](max) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ItenaryMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ItenaryMaster](
	[ItenaryId] [bigint] IDENTITY(1,1) NOT NULL,
	[TripId] [bigint] NULL,
	[Day] [bigint] NULL,
	[DayDetail] [varchar](max) NULL,
	[ImageId] [int] NULL,
 CONSTRAINT [PK__ItenaryM__ADFA50FF8DC945FB] PRIMARY KEY CLUSTERED 
(
	[ItenaryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PopularDestination]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PopularDestination](
	[ppId] [int] IDENTITY(1,1) NOT NULL,
	[LocationId] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[ImageId] [int] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK__PopularD__41E54FE977E1C2BB] PRIMARY KEY CLUSTERED 
(
	[ppId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Port_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Port_Master](
	[PortId] [int] IDENTITY(1,1) NOT NULL,
	[PortName] [varchar](500) NULL,
	[InsertedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[PortId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Rent]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Rent](
	[RentId] [int] IDENTITY(1,1) NOT NULL,
	[Location] [varchar](max) NULL,
	[VehicleType] [int] NULL,
	[VehicleName] [varchar](max) NULL,
	[Cost] [int] NULL,
	[Description] [varchar](max) NULL,
	[Terms] [varchar](max) NULL,
	[ImageId] [int] NULL,
 CONSTRAINT [PK__Rent__783D47F5B2632E0E] PRIMARY KEY CLUSTERED 
(
	[RentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ResetPassword]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResetPassword](
	[ResetId] [int] IDENTITY(1,1) NOT NULL,
	[TokenId] [int] NULL,
	[CreatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ResetId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Ship_General_Activities]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ship_General_Activities](
	[ShipGenId] [int] IDENTITY(1,1) NOT NULL,
	[CruiseId] [int] NULL,
	[ShipId] [int] NULL,
	[Detail] [varchar](250) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Ship_General_Master]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Ship_General_Master](
	[ShipId] [int] IDENTITY(1,1) NOT NULL,
	[ShipName] [varchar](200) NULL,
	[FAIconName] [varchar](200) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[STATEMASTER]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[STATEMASTER](
	[StateID] [bigint] IDENTITY(1,1) NOT NULL,
	[StateName] [varchar](50) NULL,
	[CountryId] [bigint] NULL,
	[Isactive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[StateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ThemeMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ThemeMaster](
	[ThemeId] [int] IDENTITY(1,1) NOT NULL,
	[ThemeName] [varchar](50) NULL,
	[ThemeIcon] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ThemeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TourPackage]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TourPackage](
	[PackageId] [int] IDENTITY(1,1) NOT NULL,
	[PackageValue] [bigint] NULL,
	[ImageId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrendingMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrendingMaster](
	[TrendingId] [int] IDENTITY(1,1) NOT NULL,
	[SequenceId] [int] NULL,
	[Groupname] [varchar](100) NULL,
	[Packages] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[TrendingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TripImageMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TripImageMaster](
	[TripImageID] [int] IDENTITY(1,1) NOT NULL,
	[ImageId] [int] NULL,
	[TripId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[TripImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TripMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TripMaster](
	[TripId] [bigint] IDENTITY(1,1) NOT NULL,
	[TripTitle] [varchar](50) NULL,
	[TripLocation] [varchar](100) NULL,
	[TripCategory] [varchar](20) NULL,
	[TripCost] [varchar](20) NULL,
	[TripDate] [date] NULL,
	[TripInclusion] [varchar](max) NULL,
	[TripExclusion] [varchar](max) NULL,
	[TripStatus] [bit] NULL,
	[IsCompleted] [bit] NULL,
	[TripOverview] [varchar](max) NULL,
	[Seat] [int] NULL,
	[TripTheme] [varchar](100) NULL,
	[ToDate] [date] NULL,
	[TripDays] [int] NULL,
	[Country] [varchar](100) NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[IsItenary] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TripId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TripTypeMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TripTypeMaster](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedDate] [date] NOT NULL,
 CONSTRAINT [PK_TRIPTYPEMASTER] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[vehicleMaster]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[vehicleMaster](
	[VehicleId] [int] IDENTITY(1,1) NOT NULL,
	[VehicleName] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Visa]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Visa](
	[VisaId] [int] IDENTITY(1,1) NOT NULL,
	[CountryId] [int] NULL,
	[Cost] [int] NULL,
	[DocumentRequirment] [varchar](max) NULL,
	[ImageId] [int] NULL,
	[InsertedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[VisaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [SiddhiTours].[MailDetails]    Script Date: 8/18/2021 10:49:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [SiddhiTours].[MailDetails](
	[MailId] [int] IDENTITY(1,1) NOT NULL,
	[EMailId] [varchar](500) NULL,
	[DisplayName] [varchar](100) NULL,
	[InsertedOn] [datetime] NULL,
	[UpdatedOn] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[MailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ABOUTUS] ON 

INSERT [dbo].[ABOUTUS] ([ABOUTID], [ABOUTCONTENT], [ImagePath]) VALUES (1, N'<p>.efasd,/.nsvklmsvsdopmvpodsmvposdmpofd smpojmepO\JMPOSDMOSDMV;LMFHB'';DFLH[]\LASMFD;KLMVD''LPKMFQEOJM;LXDVKSDP[JQ m;lsdkp[''sdgklam;lsmesjkposdn;,.bv'';pp[kqwomdsa;lgdsp[''kgdsolmsg;la[\p''[pgksdm;lsd,''p0p[3go[erjopwe[]q2;dmdsl;bm;lsdfm;lasdm;lemktg pojhb;lkfsdml;grd gfmasjerwqoinrg;lkawnkl;sdgn,.msdmknbjbgfyjhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;]</p><p>jhjjhkj\</p><p><br></p><p>ikhjklhklhkm&nbsp;</p><p><br></p><p>jklnklj</p>', N'/Images//CompressedAboutusImages/20210510020638_12c5c69e6eb47a72b91f0e6c41e202d9.jpg')
SET IDENTITY_INSERT [dbo].[ABOUTUS] OFF
SET IDENTITY_INSERT [dbo].[Adminlogin] ON 

INSERT [dbo].[Adminlogin] ([id], [Username], [Password]) VALUES (1, N'Siddhitours', N'Siddhi@2018')
SET IDENTITY_INSERT [dbo].[Adminlogin] OFF
SET IDENTITY_INSERT [dbo].[BusinessTour] ON 

INSERT [dbo].[BusinessTour] ([BusinessID], [Title], [Cost], [Location], [Inclusion], [Isactive], [Country], [State], [City]) VALUES (8, N'Dubai Tour', 45000, N'Dubai', N'<p><b>Inclusion</b><br><ul><li>Driver''s allowance, Road tax and Fuel charges</li><li>Pick and Drop at time of arrival/departure</li><li>Sightseeing by private car</li><li>Parking and Toll tax</li><li>Wi-Fi</li><li>All tours and transfers by Personal Car is included</li></ul><p>

<b>Exclusion</b>&nbsp;<br></p>



<ul><li>5% GST</li><li>Alcoholic / Non- Alcoholic beverages</li><li>Expenses caused by factors beyond our control like rail and flight delays, roadblocks, vehicle mal-functions, political disturbances etc.</li><li>All personal expenses</li><li>Travel insurance</li><li>Camera fee</li><li>Tips, laundry &amp; phone call</li><li>Any Airfare / Train fare</li><li>Entrance fees to monuments and museum</li></ul>

<br></p>', 1, N'Dubai', N'0', N'0')
INSERT [dbo].[BusinessTour] ([BusinessID], [Title], [Cost], [Location], [Inclusion], [Isactive], [Country], [State], [City]) VALUES (9, N'India', 13000, N'India', N'<p><b>Inclusion</b><br></p><ul><li>Driver''s allowance, Road tax and Fuel charges</li><li>Pick and Drop at time of arrival/departure</li><li>Sightseeing by private car</li><li>Parking and Toll tax</li><li>Wi-Fi</li><li>All tours and transfers by Personal Car is included</li></ul><p>

<b>Exclusion</b>&nbsp;<br></p>



<ul><li>5% GST</li><li>Alcoholic / Non- Alcoholic beverages</li><li>Expenses caused by factors beyond our control like rail and flight delays, roadblocks, vehicle mal-functions, political disturbances etc.</li><li>All personal expenses</li><li>Travel insurance</li><li>Camera fee</li><li>Tips, laundry &amp; phone call</li><li>Any Airfare / Train fare</li><li>Entrance fees to monuments and museum</li></ul>

<br><p></p>', 1, N'India', N'0', N'0')
INSERT [dbo].[BusinessTour] ([BusinessID], [Title], [Cost], [Location], [Inclusion], [Isactive], [Country], [State], [City]) VALUES (13, N'Japan Business Tour', 200000, N'Seoul,SouthKorea', N'<p>

<p><b>Include criteria</b>:</p><ul><li>Minimum outcomes: coronary deaths &amp; non-fatal myocardial infarction</li><li>Appropriate measures of Framingham variables (Age, sex, LDL, HDL, total cholesterol, diabetes, smoking status, hypertension)</li><li>Cohort, nested case-control, cardiovascular trial follow-up study (or systematic review or meta-analysis of these study types) that measures a novel risk factor and estimates its predictive value after adjusting for Framingham variables</li></ul><p><b>Exclude criteria</b>:</p><ul><li>No data</li><li>Population or sub-population with known coronary disease or coronary disease equivalent (e.g., diabetes)</li><li>Does not include minimum outcomes</li><li>Does not measure Framingham variables appropriately</li><li>Wrong study design/article format</li></ul>

<br></p>', 1, N'SouthKorea', N'Seoul', N'0')
SET IDENTITY_INSERT [dbo].[BusinessTour] OFF
SET IDENTITY_INSERT [dbo].[BusinessTourImages] ON 

INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (1, 3, 2)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (2, 4, 1012)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (3, 5, 1013)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (4, 6, 1014)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (5, 7, 1022)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (6, 8, 1062)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (7, 8, 1063)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (8, 8, 1064)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (9, 9, 1065)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (10, 9, 1066)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (11, 9, 1067)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (12, 10, 1073)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (13, 10, 1074)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (14, 11, 1099)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (15, 12, 1129)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (16, 13, 1143)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (17, 13, 1144)
INSERT [dbo].[BusinessTourImages] ([BusinessImageID], [TourId], [ImageId]) VALUES (18, 9, 1145)
SET IDENTITY_INSERT [dbo].[BusinessTourImages] OFF
SET IDENTITY_INSERT [dbo].[CityMaster] ON 

INSERT [dbo].[CityMaster] ([CityID], [CityName], [StateId], [Isactive]) VALUES (3, N'Hydrabad', 4, 1)
INSERT [dbo].[CityMaster] ([CityID], [CityName], [StateId], [Isactive]) VALUES (4, N'Leh', 14, 1)
INSERT [dbo].[CityMaster] ([CityID], [CityName], [StateId], [Isactive]) VALUES (5, N'Port blair', 15, 1)
SET IDENTITY_INSERT [dbo].[CityMaster] OFF
SET IDENTITY_INSERT [dbo].[ContactUs] ON 

INSERT [dbo].[ContactUs] ([contactId], [Address_Data], [Phone1], [Phone2], [GoogleMapLink], [FB], [Instagram], [Email], [IsWhatsapp1], [IsWhatsapp2]) VALUES (1, N'<p>b/29,Eksar Neel Kamal,Eksar Road Borivali West</p><p>Mumbai, Maharashtra </p>', N'9757236881', N'9820201629', N'[]', N'http://facebook.com/siddhitours', N'http://Instagram.com/siddhi_tours', N'booking@siddhitours.com', 1, 1)
SET IDENTITY_INSERT [dbo].[ContactUs] OFF
SET IDENTITY_INSERT [dbo].[CountryMaster] ON 

INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (4, N'Australia', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (5, N'Indonesia', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (6, N'India', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (7, N'Dubai', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (8, N'Srilnka', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (9, N'SouthKorea', 1)
INSERT [dbo].[CountryMaster] ([CountryID], [CountryName], [Isactive]) VALUES (10, N'Singapore', 1)
SET IDENTITY_INSERT [dbo].[CountryMaster] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Cabin_Master] ON 

INSERT [dbo].[Cruise_Cabin_Master] ([CabinId], [CabinName]) VALUES (1, N'Interior')
INSERT [dbo].[Cruise_Cabin_Master] ([CabinId], [CabinName]) VALUES (2, N'Oceanview')
INSERT [dbo].[Cruise_Cabin_Master] ([CabinId], [CabinName]) VALUES (3, N'Balcony')
INSERT [dbo].[Cruise_Cabin_Master] ([CabinId], [CabinName]) VALUES (4, N'Suite')
SET IDENTITY_INSERT [dbo].[Cruise_Cabin_Master] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Cabin_Price] ON 

INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (182, 27, 1, CAST(0x0000A9D200000000 AS DateTime), CAST(0x0000A9D400000000 AS DateTime), CAST(20600.00 AS Decimal(18, 2)), 103, N'<p>

Size, Layout and Furniture may vary from that shown (within the same stateroom category)

<br></p>', 20600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (183, 27, 2, CAST(0x0000A9D200000000 AS DateTime), CAST(0x0000A9D400000000 AS DateTime), CAST(26200.00 AS Decimal(18, 2)), 104, N'<p>

Size, Layout and Furniture may vary from that shown (within the same stateroom category)

<br></p>', 20600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (184, 27, 3, CAST(0x0000A9D200000000 AS DateTime), CAST(0x0000A9D400000000 AS DateTime), CAST(29450.00 AS Decimal(18, 2)), 105, N'<p>

Size, Layout and Furniture may vary from that shown (within the same stateroom category)

<br></p>', 20600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (185, 27, 4, CAST(0x0000A9D200000000 AS DateTime), CAST(0x0000A9D400000000 AS DateTime), CAST(37650.00 AS Decimal(18, 2)), 106, N'<p>

Size, Layout and Furniture may vary from that shown (within the same stateroom category)

<br></p>', 20600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (186, 28, 1, CAST(0x0000AD2600000000 AS DateTime), CAST(0x0000AD2800000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (187, 28, 2, CAST(0x0000AD2600000000 AS DateTime), CAST(0x0000AD2800000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (188, 28, 3, CAST(0x0000AD2600000000 AS DateTime), CAST(0x0000AD2800000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (189, 28, 4, CAST(0x0000AD2600000000 AS DateTime), CAST(0x0000AD2800000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (190, 28, 1, CAST(0x0000AD2400000000 AS DateTime), CAST(0x0000AD2600000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (191, 28, 2, CAST(0x0000AD2400000000 AS DateTime), CAST(0x0000AD2600000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (192, 28, 3, CAST(0x0000AD2400000000 AS DateTime), CAST(0x0000AD2600000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (193, 28, 4, CAST(0x0000AD2400000000 AS DateTime), CAST(0x0000AD2600000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (194, 28, 1, CAST(0x0000AD2D00000000 AS DateTime), CAST(0x0000AD2F00000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (195, 28, 2, CAST(0x0000AD2D00000000 AS DateTime), CAST(0x0000AD2F00000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (196, 28, 3, CAST(0x0000AD2D00000000 AS DateTime), CAST(0x0000AD2F00000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (197, 28, 4, CAST(0x0000AD2D00000000 AS DateTime), CAST(0x0000AD2F00000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (198, 28, 1, CAST(0x0000AD3400000000 AS DateTime), CAST(0x0000AD3600000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (199, 28, 2, CAST(0x0000AD3400000000 AS DateTime), CAST(0x0000AD3600000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (200, 28, 3, CAST(0x0000AD3400000000 AS DateTime), CAST(0x0000AD3600000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (201, 28, 4, CAST(0x0000AD3400000000 AS DateTime), CAST(0x0000AD3600000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (202, 28, 1, CAST(0x0000ADA700000000 AS DateTime), CAST(0x0000ADA900000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (203, 28, 2, CAST(0x0000ADA700000000 AS DateTime), CAST(0x0000ADA900000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (204, 28, 3, CAST(0x0000ADA700000000 AS DateTime), CAST(0x0000ADA900000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (205, 28, 4, CAST(0x0000ADA700000000 AS DateTime), CAST(0x0000ADA900000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (206, 28, 1, CAST(0x0000ADB500000000 AS DateTime), CAST(0x0000ADB700000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (207, 28, 2, CAST(0x0000ADB500000000 AS DateTime), CAST(0x0000ADB700000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (208, 28, 3, CAST(0x0000ADB500000000 AS DateTime), CAST(0x0000ADB700000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (209, 28, 4, CAST(0x0000ADB500000000 AS DateTime), CAST(0x0000ADB700000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (210, 28, 1, CAST(0x0000ADD100000000 AS DateTime), CAST(0x0000ADD300000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (211, 28, 2, CAST(0x0000ADD100000000 AS DateTime), CAST(0x0000ADD300000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (212, 28, 3, CAST(0x0000ADD100000000 AS DateTime), CAST(0x0000ADD300000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (213, 28, 4, CAST(0x0000ADD100000000 AS DateTime), CAST(0x0000ADD300000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (214, 28, 1, CAST(0x0000ADED00000000 AS DateTime), CAST(0x0000ADEF00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (215, 28, 2, CAST(0x0000ADED00000000 AS DateTime), CAST(0x0000ADEF00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (216, 28, 3, CAST(0x0000ADED00000000 AS DateTime), CAST(0x0000ADEF00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (217, 28, 4, CAST(0x0000ADED00000000 AS DateTime), CAST(0x0000ADEF00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (218, 28, 1, CAST(0x0000AE0900000000 AS DateTime), CAST(0x0000AE0B00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (219, 28, 2, CAST(0x0000AE0900000000 AS DateTime), CAST(0x0000AE0B00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (220, 28, 3, CAST(0x0000AE0900000000 AS DateTime), CAST(0x0000AE0B00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (221, 28, 4, CAST(0x0000AE0900000000 AS DateTime), CAST(0x0000AE0B00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (222, 28, 1, CAST(0x0000AE2500000000 AS DateTime), CAST(0x0000AE2700000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (223, 28, 2, CAST(0x0000AE2500000000 AS DateTime), CAST(0x0000AE2700000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (224, 28, 3, CAST(0x0000AE2500000000 AS DateTime), CAST(0x0000AE2700000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (225, 28, 4, CAST(0x0000AE2500000000 AS DateTime), CAST(0x0000AE2700000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (226, 28, 1, CAST(0x0000AE4100000000 AS DateTime), CAST(0x0000AE4300000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (227, 28, 2, CAST(0x0000AE4100000000 AS DateTime), CAST(0x0000AE4300000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (228, 28, 3, CAST(0x0000AE4100000000 AS DateTime), CAST(0x0000AE4300000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (229, 28, 4, CAST(0x0000AE4100000000 AS DateTime), CAST(0x0000AE4300000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (230, 28, 1, CAST(0x0000AE5D00000000 AS DateTime), CAST(0x0000AE5F00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (231, 28, 2, CAST(0x0000AE5D00000000 AS DateTime), CAST(0x0000AE5F00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (232, 28, 3, CAST(0x0000AE5D00000000 AS DateTime), CAST(0x0000AE5F00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (233, 28, 4, CAST(0x0000AE5D00000000 AS DateTime), CAST(0x0000AE5F00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (234, 28, 1, CAST(0x0000AE7900000000 AS DateTime), CAST(0x0000AE7B00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 115, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (235, 28, 2, CAST(0x0000AE7900000000 AS DateTime), CAST(0x0000AE7B00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 116, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (236, 28, 3, CAST(0x0000AE7900000000 AS DateTime), CAST(0x0000AE7B00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 117, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.

?</b><b></b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (237, 28, 4, CAST(0x0000AE7900000000 AS DateTime), CAST(0x0000AE7B00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 118, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (238, 29, 1, CAST(0x0000AD2B00000000 AS DateTime), CAST(0x0000AD2D00000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (239, 29, 2, CAST(0x0000AD2B00000000 AS DateTime), CAST(0x0000AD2D00000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (240, 29, 3, CAST(0x0000AD2B00000000 AS DateTime), CAST(0x0000AD2D00000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (241, 29, 4, CAST(0x0000AD2B00000000 AS DateTime), CAST(0x0000AD2D00000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (242, 29, 1, CAST(0x0000AD3200000000 AS DateTime), CAST(0x0000AD3400000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (243, 29, 2, CAST(0x0000AD3200000000 AS DateTime), CAST(0x0000AD3400000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (244, 29, 3, CAST(0x0000AD3200000000 AS DateTime), CAST(0x0000AD3400000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (245, 29, 4, CAST(0x0000AD3200000000 AS DateTime), CAST(0x0000AD3400000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (246, 29, 1, CAST(0x0000AD3900000000 AS DateTime), CAST(0x0000AD3B00000000 AS DateTime), CAST(9600.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (247, 29, 2, CAST(0x0000AD3900000000 AS DateTime), CAST(0x0000AD3B00000000 AS DateTime), CAST(14200.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (248, 29, 3, CAST(0x0000AD3900000000 AS DateTime), CAST(0x0000AD3B00000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (249, 29, 4, CAST(0x0000AD3900000000 AS DateTime), CAST(0x0000AD3B00000000 AS DateTime), CAST(35100.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 9600)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (250, 29, 1, CAST(0x0000ADAE00000000 AS DateTime), CAST(0x0000ADB000000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (251, 29, 2, CAST(0x0000ADAE00000000 AS DateTime), CAST(0x0000ADB000000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (252, 29, 3, CAST(0x0000ADAE00000000 AS DateTime), CAST(0x0000ADB000000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (253, 29, 4, CAST(0x0000ADAE00000000 AS DateTime), CAST(0x0000ADB000000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (254, 29, 1, CAST(0x0000ADBC00000000 AS DateTime), CAST(0x0000ADBE00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (255, 29, 2, CAST(0x0000ADBC00000000 AS DateTime), CAST(0x0000ADBE00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (256, 29, 3, CAST(0x0000ADBC00000000 AS DateTime), CAST(0x0000ADBE00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (257, 29, 4, CAST(0x0000ADBC00000000 AS DateTime), CAST(0x0000ADBE00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (258, 29, 1, CAST(0x0000ADCA00000000 AS DateTime), CAST(0x0000ADCC00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (259, 29, 2, CAST(0x0000ADCA00000000 AS DateTime), CAST(0x0000ADCC00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (260, 29, 3, CAST(0x0000ADCA00000000 AS DateTime), CAST(0x0000ADCC00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (261, 29, 4, CAST(0x0000ADCA00000000 AS DateTime), CAST(0x0000ADCC00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (262, 29, 1, CAST(0x0000ADD800000000 AS DateTime), CAST(0x0000ADDA00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (263, 29, 2, CAST(0x0000ADD800000000 AS DateTime), CAST(0x0000ADDA00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (264, 29, 3, CAST(0x0000ADD800000000 AS DateTime), CAST(0x0000ADDA00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (265, 29, 4, CAST(0x0000ADD800000000 AS DateTime), CAST(0x0000ADDA00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (266, 29, 1, CAST(0x0000ADE600000000 AS DateTime), CAST(0x0000ADE800000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (267, 29, 2, CAST(0x0000ADE600000000 AS DateTime), CAST(0x0000ADE800000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (268, 29, 3, CAST(0x0000ADE600000000 AS DateTime), CAST(0x0000ADE800000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (269, 29, 4, CAST(0x0000ADE600000000 AS DateTime), CAST(0x0000ADE800000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (270, 29, 1, CAST(0x0000ADF400000000 AS DateTime), CAST(0x0000ADF600000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (271, 29, 2, CAST(0x0000ADF400000000 AS DateTime), CAST(0x0000ADF600000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (272, 29, 3, CAST(0x0000ADF400000000 AS DateTime), CAST(0x0000ADF600000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (273, 29, 4, CAST(0x0000ADF400000000 AS DateTime), CAST(0x0000ADF600000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (274, 29, 1, CAST(0x0000AE0200000000 AS DateTime), CAST(0x0000AE0400000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (275, 29, 2, CAST(0x0000AE0200000000 AS DateTime), CAST(0x0000AE0400000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (276, 29, 3, CAST(0x0000AE0200000000 AS DateTime), CAST(0x0000AE0400000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (277, 29, 4, CAST(0x0000AE0200000000 AS DateTime), CAST(0x0000AE0400000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (278, 29, 1, CAST(0x0000AE1000000000 AS DateTime), CAST(0x0000AE1200000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (279, 29, 2, CAST(0x0000AE1000000000 AS DateTime), CAST(0x0000AE1200000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (280, 29, 3, CAST(0x0000AE1000000000 AS DateTime), CAST(0x0000AE1200000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
GO
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (281, 29, 4, CAST(0x0000AE1000000000 AS DateTime), CAST(0x0000AE1200000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (282, 29, 1, CAST(0x0000AE1E00000000 AS DateTime), CAST(0x0000AE2000000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (283, 29, 2, CAST(0x0000AE1E00000000 AS DateTime), CAST(0x0000AE2000000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (284, 29, 3, CAST(0x0000AE1E00000000 AS DateTime), CAST(0x0000AE2000000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (285, 29, 4, CAST(0x0000AE1E00000000 AS DateTime), CAST(0x0000AE2000000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (286, 29, 1, CAST(0x0000AE2C00000000 AS DateTime), CAST(0x0000AE2E00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (287, 29, 2, CAST(0x0000AE2C00000000 AS DateTime), CAST(0x0000AE2E00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (288, 29, 3, CAST(0x0000AE2C00000000 AS DateTime), CAST(0x0000AE2E00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (289, 29, 4, CAST(0x0000AE2C00000000 AS DateTime), CAST(0x0000AE2E00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (290, 29, 1, CAST(0x0000AE3A00000000 AS DateTime), CAST(0x0000AE3C00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (291, 29, 2, CAST(0x0000AE3A00000000 AS DateTime), CAST(0x0000AE3C00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (292, 29, 3, CAST(0x0000AE3A00000000 AS DateTime), CAST(0x0000AE3C00000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (293, 29, 4, CAST(0x0000AE3A00000000 AS DateTime), CAST(0x0000AE3C00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (294, 29, 1, CAST(0x0000AE4800000000 AS DateTime), CAST(0x0000AE4A00000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (295, 29, 2, CAST(0x0000AE4800000000 AS DateTime), CAST(0x0000AE4A00000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (296, 29, 3, CAST(0x0000AE4800000000 AS DateTime), CAST(0x0000AE4A00000000 AS DateTime), CAST(19700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (297, 29, 4, CAST(0x0000AE4800000000 AS DateTime), CAST(0x0000AE4A00000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (298, 29, 1, CAST(0x0000AE5600000000 AS DateTime), CAST(0x0000AE5800000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (299, 29, 2, CAST(0x0000AE5600000000 AS DateTime), CAST(0x0000AE5800000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (300, 29, 3, CAST(0x0000AE5600000000 AS DateTime), CAST(0x0000AE5800000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (301, 29, 4, CAST(0x0000AE5600000000 AS DateTime), CAST(0x0000AE5800000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (302, 29, 1, CAST(0x0000AE6400000000 AS DateTime), CAST(0x0000AE6600000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (303, 29, 2, CAST(0x0000AE6400000000 AS DateTime), CAST(0x0000AE6600000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (304, 29, 3, CAST(0x0000AE6400000000 AS DateTime), CAST(0x0000AE6600000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (305, 29, 4, CAST(0x0000AE6400000000 AS DateTime), CAST(0x0000AE6600000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (306, 29, 1, CAST(0x0000AE7200000000 AS DateTime), CAST(0x0000AE7400000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (307, 29, 2, CAST(0x0000AE7200000000 AS DateTime), CAST(0x0000AE7400000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (308, 29, 3, CAST(0x0000AE7200000000 AS DateTime), CAST(0x0000AE7400000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (309, 29, 4, CAST(0x0000AE7200000000 AS DateTime), CAST(0x0000AE7400000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (310, 29, 1, CAST(0x0000AE8000000000 AS DateTime), CAST(0x0000AE8200000000 AS DateTime), CAST(12000.00 AS Decimal(18, 2)), 126, N'<p>

<b>Stay in this finely designed interior cabin embellished with twin beds, minimalistic furnishing and an ensuite bathroom. The stay option offers the guests a budget-friendly and memorable experience while on the cruise that can accommodate up to 4 individuals.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (311, 29, 2, CAST(0x0000AE8000000000 AS DateTime), CAST(0x0000AE8200000000 AS DateTime), CAST(16400.00 AS Decimal(18, 2)), 127, N'<p>

<b>As the name suggests, stay in the ocean view cabin rooms where you can witness the soothing ocean views from the window and enjoy with your loved ones. The cabin is equipped with one double bed and two single beds that can accommodate up to a maximum of 4 people conveniently.</b>

<br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (312, 29, 3, CAST(0x0000AE8000000000 AS DateTime), CAST(0x0000AE8200000000 AS DateTime), CAST(24700.00 AS Decimal(18, 2)), 128, N'<p>

<b>Experience staying in the lavish balcony cabin with an attached balcony from where you can behold the soothing ocean blues. This stay option is embellished with a modernly designed interior and a double bed to accommodate up to 3 people with an ensuite bathroom that makes sure the guests enjoy their stay while on the cruise.</b><br></p>', 12000)
INSERT [dbo].[Cruise_Cabin_Price] ([CurCabPriceId], [CruiseId], [CruiseCabinId], [StartDate], [EndDate], [Price], [CuriseImgId], [Description], [MainPrice]) VALUES (313, 29, 4, CAST(0x0000AE8000000000 AS DateTime), CAST(0x0000AE8200000000 AS DateTime), CAST(49700.00 AS Decimal(18, 2)), 129, N'<p>

<b>Stay in this special suite designed with modern aesthetics and amenities that includes a double bed, a seating space where you can sit and watch the television or enjoy the ocean views from. The room can accommodate a maximum of up to 3 guests.</b>

<br></p>', 12000)
SET IDENTITY_INSERT [dbo].[Cruise_Cabin_Price] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Company_master] ON 

INSERT [dbo].[Cruise_Company_master] ([CompanyId], [CompanyName], [InsertedOn], [UpdatedOn], [ImagePath]) VALUES (6, N'DREAM CRUISE  ', CAST(0x0000A94E006AEC7D AS DateTime), CAST(0x0000A95F0031E0E5 AS DateTime), N'/Images//CompressedCompanyImages/20180918030134_download (1).png')
INSERT [dbo].[Cruise_Company_master] ([CompanyId], [CompanyName], [InsertedOn], [UpdatedOn], [ImagePath]) VALUES (7, N'COSTA ', CAST(0x0000A95400005625 AS DateTime), CAST(0x0000A95F0031421C AS DateTime), N'/Images//CompressedCompanyImages/20180918025911_download.jpg')
INSERT [dbo].[Cruise_Company_master] ([CompanyId], [CompanyName], [InsertedOn], [UpdatedOn], [ImagePath]) VALUES (8, N'STAR CRUISE ', CAST(0x0000A9CA017E88FA AS DateTime), CAST(0x0000A9CA017E93C8 AS DateTime), N'/Images//CompressedCompanyImages/20190103231247_1200px-Star_cruises_logo.svg.png')
INSERT [dbo].[Cruise_Company_master] ([CompanyId], [CompanyName], [InsertedOn], [UpdatedOn], [ImagePath]) VALUES (9, N'CORDELIA CRUISE', CAST(0x0000AD1E015CECC0 AS DateTime), CAST(0x0000AD1E015CF3EE AS DateTime), N'/Images//CompressedCompanyImages/20210504211024_Cordelia Final Logo-01.png')
SET IDENTITY_INSERT [dbo].[Cruise_Company_master] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Image_Master] ON 

INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (59, NULL, N'/Images//CompressedCabinImages/20180901065435_M66-Guest-Cabin.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (60, NULL, N'/Images//CompressedCabinImages/20180901065436_PACIFIC-DAWN-cabin-choices-square.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (64, NULL, N'/Images//CompressedCabinImages/20180902020412_043.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (6, NULL, N'/Images/CompressedCruiseImages/20180811120752_Screenshot_2015-11-14-01-19-25.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (7, NULL, N'/Images/CompressedCruiseImages/20180811120752_Screenshot_2015-11-14-01-19-25.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (8, NULL, N'/Images/CompressedCruiseImages/20180811120752_Screenshot_2015-11-14-01-19-25.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (9, NULL, N'/Images/CompressedCruiseImages/20180811120752_Screenshot_2015-11-14-01-19-25.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (10, NULL, N'/Images//CompressedCabinImages/20180813181725_700x475_MainImage_Dawn.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (11, NULL, N'/Images//CompressedCabinImages/20180813181735_700x475_MainImage_Dawn.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (12, NULL, N'/Images//CompressedCabinImages/20180813181737_700x475_MainImage_Dawn.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (78, NULL, N'/Images//CompressedCabinImages/20181018073002_160803103121_home_fig-01_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (17, NULL, N'/Images//CompressedCabinImages/20180815060513_image2.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (18, NULL, N'/Images//CompressedCabinImages/20180815060515_image3.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (23, NULL, N'/Images//CompressedCabinImages/20180816001815_image1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (24, NULL, N'/Images//CompressedCabinImages/20180816001818_image2.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (25, NULL, N'/Images//CompressedCabinImages/20180816001824_image3.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (79, NULL, N'/Images//CompressedCabinImages/20181018073149_bangkok-pattaya-tour.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (29, NULL, N'/Images//CompressedCabinImages/20180815115224_image2.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (30, NULL, N'/Images//CompressedCabinImages/20180815115225_image3.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (66, NULL, N'/Images//CompressedCabinImages/20180902020423_maxresdefault.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (94, NULL, N'/Images//CompressedCabinImages/20181018083704_abc.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (82, NULL, N'/Images//CompressedCabinImages/20181018074110_170228050731_legoland_japan_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (35, NULL, N'/Images//CompressedCabinImages/20180823071807_Dubai-xlarge.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (36, NULL, N'/Images//CompressedCabinImages/20180823071809_51B3SqO6NFL._SX425_.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (43, NULL, N'/Images//CompressedCabinImages/20180824215719_enquiry-bg.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (45, NULL, N'/Images//CompressedCabinImages/20180824215723_black1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (48, NULL, N'/Images//CompressedCabinImages/20180901064407_images1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (85, NULL, N'/Images//CompressedCabinImages/20181018202718_160803103121_home_fig-01_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (86, NULL, N'/Images//CompressedCabinImages/20181018202724_cruise-broke-hero.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (89, NULL, N'/Images//CompressedCabinImages/20181018205836_170228050731_legoland_japan_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (90, NULL, N'/Images//CompressedCabinImages/20181018205845_abc.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (96, NULL, N'/Images//CompressedCabinImages/20181019082214_download.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (97, NULL, N'/Images//CompressedCabinImages/20181019102524_160803103121_home_fig-01_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (100, 27, N'/Images//CompressedCruiseImages/20190103234932_2mn sin.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (99, NULL, N'/Images//CompressedCabinImages/20181020084521_160803103121_home_fig-01_c.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (101, 27, N'/Images//CompressedCruiseImages/20190103234944_2n sin.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (102, 27, N'/Images//CompressedCruiseImages/20190103234951_2sin.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (103, NULL, N'/Images//CompressedCabinImages/20190103235006_gdr-iss-inside-stateroom-en 2 night singapore.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (104, NULL, N'/Images//CompressedCabinImages/20190103235013_wdr_oss_oceanview-stateroom_dk09_01.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (13, NULL, N'/Images//CompressedCabinImages/20180813181738_700x475_MainImage_Dawn.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (15, NULL, N'/Images//CompressedCabinImages/20180815060509_image1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (16, NULL, N'/Images//CompressedCabinImages/20180815060511_image2.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (88, NULL, N'/Images//CompressedCabinImages/20181018202800_ausnz-201711131903550445.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (92, NULL, N'/Images//CompressedCabinImages/20181018210325_bangkok-pattaya-tour.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (26, NULL, N'/Images//CompressedCabinImages/20180816001828_image3.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (28, NULL, N'/Images//CompressedCabinImages/20180815115223_image1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (31, NULL, N'/Images//CompressedCabinImages/20180815115227_image1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (58, NULL, N'/Images//CompressedCabinImages/20180901065433_images1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (37, NULL, N'/Images//CompressedCabinImages/20180823071812_holiday-package.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (38, NULL, N'/Images//CompressedCabinImages/20180823071817_dubai-in-24-hours-panel-desktop.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (76, NULL, N'/Images//CompressedCabinImages/20181018071055_abc.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (49, NULL, N'/Images//CompressedCabinImages/20180901064409_PACIFIC-DAWN-cabin-choices-square.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (42, NULL, N'/Images//CompressedCabinImages/20180824215718_enquiry-bg1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (46, NULL, N'/Images//CompressedCabinImages/20180901064359_PACIFIC-DAWN-cabin-choices-square.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (47, NULL, N'/Images//CompressedCabinImages/20180901064403_M66-Guest-Cabin.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (61, NULL, N'/Images//CompressedCabinImages/20180901065438_images1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (65, NULL, N'/Images//CompressedCabinImages/20180902020416_98ca978b5caae38cb7a66ad3d3bd5372.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (67, NULL, N'/Images//CompressedCabinImages/20180902020437_043.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (44, NULL, N'/Images//CompressedCabinImages/20180824215721_company.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (91, NULL, N'/Images//CompressedCabinImages/20181018210321_abc.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (81, NULL, N'/Images//CompressedCabinImages/20181018073749_cruise-broke-hero.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (84, NULL, N'/Images//CompressedCabinImages/20181018074537_cruise-broke-hero.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (87, NULL, N'/Images//CompressedCabinImages/20181018202757_abc.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (106, NULL, N'/Images//CompressedCabinImages/20190103235023_image004.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (95, NULL, N'/Images//CompressedCabinImages/20181018083705_cruise-broke-hero.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (105, NULL, N'/Images//CompressedCabinImages/20190103235018_image005.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (107, 28, N'/Images//CompressedCruiseImages/20210504224910_Cordelia Cruises - Mock Up Creative - 22.12.2020.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (108, 28, N'/Images//CompressedCruiseImages/20210504224927_Cordelia Cruises - Ship.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (111, 28, N'/Images//CompressedCruiseImages/20210504225142_Cordelia interiors1 (1).jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (112, 28, N'/Images//CompressedCruiseImages/20210504225221_Food.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (113, 28, N'/Images//CompressedCruiseImages/20210504225226_thumbnail (2) (1).jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (116, NULL, N'/Images//CompressedCabinImages/20210504225239_Ocean View Stateroom.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (119, 29, N'/Images//CompressedCruiseImages/20210505025141_Cordelia Cruises - Mock Up Creative - 22.12.2020.png')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (121, 29, N'/Images//CompressedCruiseImages/20210505025227_Cordelia interior.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (122, 29, N'/Images//CompressedCruiseImages/20210505025303_eee.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (123, 29, N'/Images//CompressedCruiseImages/20210505025306_Goa.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (124, 29, N'/Images//CompressedCruiseImages/20210505025311_thumbnail (2) (1).jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (126, NULL, N'/Images//CompressedCabinImages/20210505025322_Interior stateroom.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (127, NULL, N'/Images//CompressedCabinImages/20210505025325_Ocean View Stateroom.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (129, NULL, N'/Images//CompressedCabinImages/20210505025348_Cordelia Cruises - Chairman''s Suite.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (109, 28, N'/Images//CompressedCruiseImages/20210504225017_Cordelia Cruises 1.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (110, 28, N'/Images//CompressedCruiseImages/20210504225058_Cordelia interiors pic.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (114, 28, N'/Images//CompressedCruiseImages/20210504225230_thumbnail (6).jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (115, NULL, N'/Images//CompressedCabinImages/20210504225235_Interior stateroom.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (117, NULL, N'/Images//CompressedCabinImages/20210504225244_Cordelia Cruises - Balcony (1).jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (118, NULL, N'/Images//CompressedCabinImages/20210504225307_Cordelia Cruises - Chairman''s Suite.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (120, 29, N'/Images//CompressedCruiseImages/20210505025146_Cordelia exterior.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (125, 29, N'/Images//CompressedCruiseImages/20210505025314_Trincomalee 2.jpg')
INSERT [dbo].[Cruise_Image_Master] ([CruiseImgId], [CruiseId], [ImagePath]) VALUES (128, NULL, N'/Images//CompressedCabinImages/20210505025327_Cordelia Cruises - Balcony.jpg')
SET IDENTITY_INSERT [dbo].[Cruise_Image_Master] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Itinerary_Master] ON 

INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (37, 27, 1, N'Singapore, Singapore - Depart ', N'@ 09:00PM', N'')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (38, 27, 2, N' Bintan Island, Indonesia - Arrival', N'@ 09:00PM', N'@ 07:00PM')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (39, 27, 3, N' Singapore, Singapore - Arrival ', N'@ 10:00AM', N'')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (40, 28, 1, N'WELCOME ONBOARD :-Embark on this spectacular cruise holiday from Mumbai, the melting pot, and home to three UNESCO World Heritage Sites. Check-into your room and get ready for an experience of a lifetime, onboard the Empress.', N'10:00', N'')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (41, 28, 2, N'DAY AT SEA :- Unlimited experiences await you in the middle of the ocean as you cruise through the high seas. Enjoy delicacies from various cuisines around the world and rejuvenate your senses at our spa, with a view like no other. Try your luck at the casino, or enjoy world-class entertainment shows on board. But there is nothing like a stroll on the deck with your loved ones; moments that you’ll cherish forever.', N'', N'')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (42, 28, 3, N'ARRIVE IN MUMBAI :- Disembark at our home port, only to come again soon!', N'', N'19:00')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (43, 29, 1, N'WELCOME ONBOARD   Set sail to dive into a weekend of fun, frolic and extravaganza. An experience that will take you breath away with the serenity of the ocean. Board the Empress from Mumbai, and enjoy the party at The Dome with some good food and music.', N'12:00', N'18:00')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (44, 29, 2, N'EXPLORE GOA  Arrive in Goa, the most popular destination for weekend getaways in a new avatar! Enjoy the unmatched combination of sun, sand and seafood with some shore excursions. Spend your evening on the cruise enjoying the different activities and entertainment shows. Don’t forget to try your luck at the casino.', N'12:00', N'18:00')
INSERT [dbo].[Cruise_Itinerary_Master] ([ItineraryId], [CruiseId], [Day], [Detail], [Arrival], [Departature]) VALUES (45, 29, 3, N'Arrive In Mumbai   Disembark at our home port - Mumbai, the heart of the country, which showcases some of the grandest colonial-era architecture around the globe and India’s premier restaurants and nightlife.', N'', N'12:00')
SET IDENTITY_INSERT [dbo].[Cruise_Itinerary_Master] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Master] ON 

INSERT [dbo].[Cruise_Master] ([CruiseId], [CruiseName], [Inclusions], [Exclusions], [PortSourceName], [PortDestinationName], [AliasForTrip], [NoOfDays], [NoOfNights], [InsertedOn], [UpdatedOn], [CompanyId], [TaxPerPerson], [GratuityForAdult], [GratuityForChild], [MainPrice]) VALUES (27, N'Singapore-Binta-Singapore', N'<p>

</p><ul><li>TV for in-cabin entertainment</li><li>Complimentary toiletries</li><li>In cabin safe</li><li>Full breakfast</li><li>Buffet lunch</li><li>Buffet dinner</li><li>Musical stage shows and entertainment</li><li>Special guest entertainers</li><li>Latest release movies (in cabin and on big screen)</li></ul>

<p><br></p><p></p>', N'<p>

</p><ul><li>Alcoholic Beverages</li><li>VISA, Airfare &amp; land transport</li><li>Fine Dinning in a few specialty restaurants</li><li>Shore Excursions</li><li>Spa &amp; Saloon</li><li>Purchases that are personal in nature</li></ul>

<br><p></p>', N'', N'', N'Singapore-Bintan (Friday Dep)', 3, 2, CAST(0x0000A9CA01889F49 AS DateTime), CAST(0x0000A9CD001F67B0 AS DateTime), 6, 3600, 2100, 1500, NULL)
INSERT [dbo].[Cruise_Master] ([CruiseId], [CruiseName], [Inclusions], [Exclusions], [PortSourceName], [PortDestinationName], [AliasForTrip], [NoOfDays], [NoOfNights], [InsertedOn], [UpdatedOn], [CompanyId], [TaxPerPerson], [GratuityForAdult], [GratuityForChild], [MainPrice]) VALUES (28, N'MUMBAI - HIGH SEA - MUMBAI', N'<p>

</p><ul><li><b>TV for in-cabin entertainment</b></li><li><b>Complimentary toiletries</b></li><li><b>In cabin safe</b></li><li><b>Full breakfast</b></li><li><b>Buffet lunch</b></li><li><b>Buffet dinner</b></li><li><b>Musical stage shows and entertainment</b></li><li><b>Special guest entertainers</b></li><li><b>Latest release movies (in cabin and on big screen)</b></li></ul><b>

</b><br><p></p>', N'<p>

</p><ul><li><b>Alcoholic Beverages</b></li><li><b>VISA, Airfare &amp; land transport</b></li><li><b>Fine Dinning in a few specialty restaurants</b></li><li><b>Shore Excursions</b></li><li><b>Spa &amp; Saloon</b></li><li><b>Purchases that are personal in nature</b></li></ul><b>

</b><br><p></p>', N'MUMBAI', N'MUMBAI', N'CRUISE WEEKENDER', 3, 2, CAST(0x0000AD1E0178038A AS DateTime), CAST(0x0000AD1F002376ED AS DateTime), 9, 1200, 900, 900, NULL)
INSERT [dbo].[Cruise_Master] ([CruiseId], [CruiseName], [Inclusions], [Exclusions], [PortSourceName], [PortDestinationName], [AliasForTrip], [NoOfDays], [NoOfNights], [InsertedOn], [UpdatedOn], [CompanyId], [TaxPerPerson], [GratuityForAdult], [GratuityForChild], [MainPrice]) VALUES (29, N'MUMBAI - GOA - MUMBAI', N'<p><b>

<ul><li><b>TV for in-cabin entertainment</b></li><li><b>Complimentary toiletries</b></li><li><b>In cabin safe</b></li><li><b>Full breakfast</b></li><li><b>Buffet lunch</b></li><li><b>Buffet dinner</b></li><li><b>Musical stage shows and entertainment</b></li><li><b>Special guest entertainers</b></li><li><b>Latest release movies (in cabin and on big screen)</b></li></ul><b><br>

</b></b><br></p>', N'<p><b>

<ul><li><b>Alcoholic Beverages</b></li><li><b>VISA, Airfare &amp; land transport</b></li><li><b>Fine Dinning in a few specialty restaurants</b></li><li><b>Shore Excursions</b></li><li><b>Spa &amp; Saloon</b></li><li><b>Purchases that are personal in nature</b></li></ul><b><br>

</b></b><br></p>', N'MUMBAI', N'MUMBAI', N'SUNDOWNER TO GOA', 3, 2, CAST(0x0000AD1F002F2320 AS DateTime), CAST(0x0000AD1F002F2320 AS DateTime), 9, 1200, 900, 900, NULL)
SET IDENTITY_INSERT [dbo].[Cruise_Master] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Activities] ON 

INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (472, 27, 1)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (473, 27, 2)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (475, 27, 5)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (476, 27, 6)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (477, 27, 7)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (478, 27, 8)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (474, 27, 4)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (511, 28, 1)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (512, 28, 2)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (513, 28, 3)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (514, 28, 4)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (515, 28, 5)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (516, 28, 6)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (517, 28, 7)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (518, 28, 8)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (519, 29, 1)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (520, 29, 2)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (521, 29, 3)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (522, 29, 4)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (523, 29, 5)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (524, 29, 6)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (525, 29, 7)
INSERT [dbo].[Cruise_Onboard_Activities] ([CurOnActId], [CruiseId], [OnboardCategoryId]) VALUES (526, 29, 8)
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Activities] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Category] ON 

INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (1, 1, N'Plays & Shows Night Clubs', N'/Icon/show.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (2, 1, N'Casinos for the Night Lifers', N'/Icon/Casino.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (3, 1, N'Sports & Recreation Activities', N'/Icon/Sports.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (4, 2, N'Art & Craft', N'/Icon/Art.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (5, 2, N'Kids themes parks & play areas', N'/Icon/Game.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (6, 2, N'Beverage & Dining', N'/Icon/Beverage.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (7, 3, N'Shopping', N'/Icon/Shopping.png')
INSERT [dbo].[Cruise_Onboard_Category] ([OnboardCategoryId], [OnboardId], [CategoryName], [Icon]) VALUES (8, 3, N'SPA', N'/Icon/spa.png')
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Category] OFF
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Master] ON 

INSERT [dbo].[Cruise_Onboard_Master] ([COnboardId], [COnboardName]) VALUES (1, N'Entertainment')
INSERT [dbo].[Cruise_Onboard_Master] ([COnboardId], [COnboardName]) VALUES (2, N'Kids Entertainment')
INSERT [dbo].[Cruise_Onboard_Master] ([COnboardId], [COnboardName]) VALUES (3, N'Lifestyle')
SET IDENTITY_INSERT [dbo].[Cruise_Onboard_Master] OFF
SET IDENTITY_INSERT [dbo].[HomeBanner] ON 

INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (36, N'../Frontendpages/Trip.aspx?Search=Select', 1165)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (37, N'../Frontendpages/Trip.aspx?Search=Select', 1166)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (38, N'../Frontendpages/Trip.aspx?Search=Select', 1167)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (39, N'../Frontendpages/Trip.aspx?Search=Select', 1168)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (40, N'../Frontendpages/Trip.aspx?Search=Select', 1169)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (42, N'../Frontendpages/Trip.aspx?Search=Select', 1171)
INSERT [dbo].[HomeBanner] ([BannerId], [QueryString], [IMAGEID]) VALUES (43, N'../Frontendpages/Trip.aspx?Search=Select', 1172)
SET IDENTITY_INSERT [dbo].[HomeBanner] OFF
SET IDENTITY_INSERT [dbo].[ImageMaster] ON 

INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1, N'/Images/HomeBanner/20180716195754_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (2, N'/Images/CompressedBusinessImages/20180716200522_DSC_0020.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (3, N'/Images/CompressedTripImages/20180716202507_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (4, N'/Images/CompressedTripImages/20180716203910_DSC_0019.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1003, N'/Images/CompressedTripImages/20180731102244_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1004, N'/Images/CompressedTripImages/20180731102335_DSC_0008.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1005, N'/Images/CompressedItenaryImages/20180731102457_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1006, N'/Images/CompressedTripImages/20180731103012_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1007, N'/Images/CompressedTripImages/20180731103609_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1008, N'/Images/CompressedItenaryImages/20180731103713_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1009, N'/Images/CompressedPopularDestination/20180731104039_DSC_0003.JPG', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1010, N'/Images/HomeBanner/20180731104119_DSC_0020.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1011, N'/Images/VisaCompressed/20180731104309_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1012, N'/Images/CompressedBusinessImages/20180731104421_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1013, N'/Images/CompressedBusinessImages/20180731104507_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1014, N'/Images/CompressedBusinessImages/20180731105423_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1015, N'/Images/CompressedRentImages/20180731111752_DSC_0003.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1016, N'/Images/CompressedBusinessImages/20180803131730_d2.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1017, N'/Images/CompressedBusinessImages/20180803131703_d2.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1018, N'/Images/CompressedBusinessImages/20180803131903_d5.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1019, N'/Images/VisaCompressed/20180806225229_Eid Mubarak Image 2017 (2).jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1020, N'/Images/CompressedRentImages/20180806225347_Eid Mubarak Image 2017 (2).jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1021, N'/Images/CompressedRentImages/20180806225856_BS Card_Back.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1022, N'/Images/CompressedBusinessImages/20180806230114_BS Card_Back.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1023, N'/Images/VisaCompressed/20180806230346_images (16).jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1024, N'/Images/VisaCompressed/20180807095421_d3   1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1025, N'/Images/VisaCompressed/20180807222751_d3   1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1026, N'/Images/VisaCompressed/20180807222904_d3   1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1027, N'/Images/VisaCompressed/20180807223136_d3   1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1028, N'/Images/VisaCompressed/20180807224800_d31.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1029, N'/Images/CompressedRentImages/20180807235915_d31.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1030, N'/Images/CompressedRentImages/20180808002113_d31.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1031, N'/Images/CompressedRentImages/20180808002630_d5.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1032, N'/Images/CompressedTripImages/20180809062535_31100594634_d78c4c8e48_z.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1033, N'/Images/CompressedTripImages/20180809062545_31566859490_32a7c91bdc_b.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1034, N'/Images/CompressedItenaryImages/20180809062629_31100594634_d78c4c8e48_z.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1035, N'/Images/CompressedItenaryImages/20180809062703_vastu.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1036, N'/Images/CompressedItenaryImages/20180809062747_vastu.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1037, N'/20180820000243_2011hondacbr250r2_1600x0w.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1038, N'/Images/CompressedTripImages/20180821212714_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1039, N'/Images/CompressedTripImages/20180821212726_Dubai-xlarge.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1040, N'/Images/CompressedTripImages/20180821212732_welcome-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1041, N'/Images/CompressedItenaryImages/20180821212808_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1042, N'/Images/CompressedItenaryImages/20180821212840_holiday-package.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1043, N'/Images/CompressedItenaryImages/20180821212916_welcome-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1044, N'/Images/CompressedItenaryImages/20180821213013_Dubai-xlarge.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1045, N'/Images/CompressedTripImages/20180821214408_400px-Hyderabad_from_Char_Minar.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1046, N'/Images/CompressedTripImages/20180821214417_best-of-hyderabad-as.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1047, N'/Images/CompressedTripImages/20180821214421_Hyderabad-city-e1508867439150.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1048, N'/Images/CompressedTripImages/20180821214425_yourstory-hyderabad.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1049, N'/Images/CompressedItenaryImages/20180821214607_400px-Hyderabad_from_Char_Minar.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1050, N'/Images/CompressedItenaryImages/20180821214620_Dubai-xlarge.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1051, N'/Images/CompressedPopularDestination/20180821214706_dubai-in-24-hours-panel-desktop.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1052, N'/Images/CompressedPopularDestination/20180821214728_best-of-hyderabad-as.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1053, N'/Images/HomeBanner/20180821214943_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1054, N'/Images/HomeBanner/20180821214959_Hyderabad-city-e1508867439150.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1055, N'/Images/CompressedBusinessImages/20180821215117_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1056, N'/Images/CompressedBusinessImages/20180821215130_best-of-hyderabad-as.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1057, N'/Images/CompressedBusinessImages/20180821215232_welcome-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1058, N'/Images/VisaCompressed/20180821220744_in.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1059, N'/Images/VisaCompressed/20180821221117_in.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1060, N'/Images/VisaCompressed/20180821221131_images(1).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1061, N'/Images/VisaCompressed/20180821221146_images.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1062, N'/Images/CompressedBusinessImages/20180821221343_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1063, N'/Images/CompressedBusinessImages/20180821221345_Dubai-xlarge.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1064, N'/Images/CompressedBusinessImages/20180821221347_welcome-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1065, N'/Images/CompressedBusinessImages/20180821221416_dubai-in-24-hours-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1066, N'/Images/CompressedBusinessImages/20180821221418_Dubai-xlarge.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1067, N'/Images/CompressedBusinessImages/20180821221420_welcome-panel-desktop.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1068, N'/Images/CompressedItenaryImages/20180821221752_925736360s.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1069, N'/Images/HomeBanner/20180821223446_holiday-package.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1070, N'/Images/CompressedRentImages/20180821224443_51B3SqO6NFL._SX425_.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1071, N'/Images/CompressedPopularDestination/20180823063936_wel10.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1072, N'/Images/HomeBanner/20180823064610_cruise-broke-hero.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1073, N'/Images/CompressedBusinessImages/20180824004155_image1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1074, N'/Images/CompressedBusinessImages/20180824004202_image2.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1075, N'/Images/CompressedTripImages/20180824005321_image3.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1076, N'/Images/HomeBanner/20180823140105_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1077, N'/Images/HomeBanner/20180823140116_download.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1078, N'/Images/HomeBanner/20180823140222_download.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1079, N'/Images/HomeBanner/20180823140426_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1080, N'/Images/HomeBanner/20180823140444_download.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1081, N'/Images/HomeBanner/20180823140455_88881_38b57522.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1082, N'/Images/HomeBanner/20180823140922_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1083, N'/Images/HomeBanner/20180823141002_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1084, N'/Images/HomeBanner/20180823141023_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1085, N'/Images/HomeBanner/20180823141216_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1086, N'/Images/CompressedTripImages/20180824180502_about-bg.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1087, N'/Images/CompressedTripImages/20180824180511_about-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1088, N'/Images/CompressedTripImages/20180824180530_asd.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1089, N'/Images/CompressedTripImages/20180824180554_asdad.JPG', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1090, N'/Images/CompressedItenaryImages/20180824180716_company.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1091, N'/Images/CompressedItenaryImages/20180824180802_contact-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1092, N'/Images/CompressedItenaryImages/20180824181003_facetime.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1093, N'/Images/CompressedPopularDestination/20180824181138_enquiry-bg1.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1094, N'/Images/HomeBanner/20180824181323_contact-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1095, N'/Images/HomeBanner/20180824181333_enquiry-bg.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1096, N'/Images/CompressedRentImages/20180824181729_director.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1097, N'/Images/CompressedRentImages/20180824181920_enquiry-bg.jpg', NULL)
GO
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1098, N'/Images/VisaCompressed/20180824182115_c2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1099, N'/Images/CompressedBusinessImages/20180824182327_galvanise.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1100, N'/Images/CompressedTripImages/20180824185755_88881_38b57522.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1101, N'/Images/CompressedRentImages/20180824214536_about-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1102, N'/Images/CompressedTripImages/20180825102241_2.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1103, N'/Images/CompressedTripImages/20180824221241_d8.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1104, N'/Images/CompressedItenaryImages/20180824221300_d6.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1105, N'/Images/CompressedTripImages/20180824221438_about-bg.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1106, N'/Images/CompressedTripImages/20180824221439_about-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1107, N'/Images/CompressedItenaryImages/20180824221455_enquiry-bg.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1108, N'/Images/CompressedItenaryImages/20180824221533_about-bg1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1109, N'/Images/HomeBanner/20180826045434_1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1110, N'/Images/CompressedTripImages/20180829002146_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1111, N'/Images/CompressedTripImages/20180829002153_icon_star.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1112, N'/Images/CompressedItenaryImages/20180829002214_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1113, N'/Images/CompressedItenaryImages/20180829002230_icon_star.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1114, N'/Images/CompressedItenaryImages/20180829003306_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1115, N'/Images/CompressedItenaryImages/20180829003536_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1116, N'/Images/CompressedItenaryImages/20180829003702_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1117, N'/Images/CompressedItenaryImages/20180829004003_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1118, N'/Images/CompressedItenaryImages/20180829004016_icon_clock.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1119, N'/Images/CompressedItenaryImages/20180829004124_icon_star.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1120, N'/Images/CompressedItenaryImages/20180829004238_icon_star.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1121, N'/Images/CompressedTripImages/20180829103529_download(2).jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1122, N'/Images/CompressedTripImages/20180829103602_download(1).jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1123, N'/Images/CompressedItenaryImages/20180829103644_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1124, N'/Images/CompressedItenaryImages/20180829103729_88881_38b57522.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1125, N'/Images/CompressedItenaryImages/20180829103743_download.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1126, N'/Images/CompressedPopularDestination/20180829103819_trolley-tours-of-key-west.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1127, N'/Images/CompressedBusinessImages/20180829104032_images.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1128, N'/Images/VisaCompressed/20180829110127_images.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1129, N'/Images/CompressedBusinessImages/20180829110637_88881_38b57522.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1130, N'/Images/CompressedRentImages/20180829110737_39ff12c389c14fde26b5fe840ed79867--business-powerpoint-templates-ppt.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1131, N'/Images/HomeBanner/20180901054108_84659.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1132, N'/Images/HomeBanner/20180901054118_download (3).jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1133, N'/Images/HomeBanner/20180901054125_images.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1134, N'/Images/HomeBanner/20180901054340_download.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1135, N'/Images/HomeBanner/20180901054440_ausnz-201711131903550445.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1136, N'/Images/HomeBanner/20180901054618_tajmahel-1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1137, N'/Images/CompressedBusinessImages/20180901054836_bangkok-pattaya-tour.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1138, N'/Images/CompressedBusinessImages/20180901055343_malaysia-thailand-cheapest-tour-package.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1139, N'/Images/CompressedBusinessImages/20180901060124_JeruMountZion-001.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1140, N'/Images/CompressedBusinessImages/20180901060249_about_us.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1141, N'/Images/VisaCompressed/20180901061005_abc.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1142, N'/Images/VisaCompressed/20180901061100_Sydney_large.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1143, N'/Images/CompressedBusinessImages/20180901061657_160803103121_home_fig-01_c.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1144, N'/Images/CompressedBusinessImages/20180901061703_170228050731_legoland_japan_c.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1145, N'/Images/CompressedBusinessImages/20180901061758_ausnz-201711131903550445.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1146, N'/Images/CompressedRentImages/20180901062209_ebay659352.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1147, N'/Images/CompressedRentImages/20180901062547_download1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1148, N'/Images/HomeBanner/20180901071248_84659.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1149, N'/Images/HomeBanner/20180901071313_tajmahel-1.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1150, N'/Images/HomeBanner/20180901071344_ausnz-201711131903550445.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1151, N'/Images/CompressedItenaryImages/20180920221055_20171220_202837.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1152, N'/Images/CompressedItenaryImages/20180920221240_20171219_173404.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1153, N'/Images/CompressedTripImages/20190526142656_3Singapore.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1154, N'/Images/CompressedItenaryImages/20190526143143_Singapore-small-700x464.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1155, N'/Images/CompressedItenaryImages/20190526143405_05082013143613_comp.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1156, N'/Images/CompressedItenaryImages/20190526143541_Universal_Studios_Singapore.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1157, N'/Images/CompressedItenaryImages/20190527110815_IMG_20170528_191459462.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1158, N'/Images/CompressedItenaryImages/20190527110937_IMG_20170529_160134053.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1159, N'/Images/HomeBanner/20190527111144_IMG-20170530-WA0009.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1160, N'/Images/HomeBanner/20190527111210_IMG_20170528_190344444.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1161, N'/Images/HomeBanner/20190527111224_IMG-20170528-WA0117.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1162, N'/Images/HomeBanner/20190527112356_WhatsApp Image 2019-05-17 at 22.31.55.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1163, N'/Images/HomeBanner/20190527112530_IMG-20170529-WA0025.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1164, N'/Images/HomeBanner/20190527112704_WhatsApp Image 2019-05-17 at 22.31.55.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1165, N'/Images/HomeBanner/20190527112715_IMG-20170526-WA0024.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1166, N'/Images/HomeBanner/20190527112752_IMG_20181221_112628.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1167, N'/Images/HomeBanner/20190527112841_IMG_20181219_123930.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1168, N'/Images/HomeBanner/20190527113321_IMG-20170529-WA0072.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1169, N'/Images/HomeBanner/20190527113352_IMG_20181219_100700.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1170, N'/Images/HomeBanner/20190527113415_WhatsApp Image 2019-05-17 at 22.31.55.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1171, N'/Images/HomeBanner/20190527114254_25299386_1928593433836175_7799447541822731143_n.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1172, N'/Images/HomeBanner/20190527114300_26219683_1941821659180019_4389795269077461192_n.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1173, N'/Images/HomeBanner/20190527190055_india.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1174, N'/Images/CompressedTripImages/20190527190405_india.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1175, N'/Images/CompressedItenaryImages/20190527190547_india.jpeg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1176, N'/Images/CompressedPopularDestination/20190528101253_IMG_20170529_160134053.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1177, N'/Images/CompressedPopularDestination/20190528101349_xpressimage(3).png', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1178, N'/Images/CompressedTripImages/20190528101649_IMG-20170529-WA0072.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1179, N'/Images/HomeBanner/20190831003122_trolley-tours-of-key-west.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1180, N'/Images/HomeBanner/20190831003215_2011hondacbr250r2_1600x0w.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1181, N'/Images/CompressedTripImages/20210313025030_feat_prod.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1182, N'/Images/CompressedItenaryImages/20210313025101_GA-man-in-yellow-CMYK.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1183, N'/Images/CompressedTripImages/20210425225550_20171217_151510.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1184, N'/Images/CompressedTripImages/20210425225610_20171217_151925.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1185, N'/Images/CompressedTripImages/20210425225624_20171217_151926.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1186, N'/Images/CompressedTripImages/20210425225639_20171217_195540.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1187, N'/Images/CompressedTripImages/20210425225654_20171217_195626.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1188, N'/Images/CompressedTripImages/20210425225713_20171217_195702.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1189, N'/Images/CompressedTripImages/20210425225729_20171217_200141.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1190, N'/Images/CompressedTripImages/20210425225746_20171217_200143.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1191, N'/Images/CompressedItenaryImages/20210425233638_Untitleddesign(1).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1192, N'/Images/CompressedItenaryImages/20210425233729_Untitleddesign(2).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1193, N'/Images/CompressedItenaryImages/20210425235138_FIGHTTOLEH.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1194, N'/Images/CompressedItenaryImages/20210425235835_FIGHTTOLEH.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1195, N'/Images/CompressedItenaryImages/20210426235331_Untitleddesign(3).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1196, N'/Images/CompressedItenaryImages/20210426235428_FIGHTTOLEH.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1197, N'/Images/CompressedItenaryImages/20210427003154_FIGHTTOLEH(2).png', NULL)
GO
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1198, N'/Images/HomeBanner/20210427020159_FIGHT TO LEH (2) - Copy.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1199, N'/Images/HomeBanner/20210427020225_FIGHT TO LEH (3).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1200, N'/Images/HomeBanner/20210427020232_FIGHT TO LEH (3).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1201, N'/Images/HomeBanner/20210427020332_FIGHT TO LEH (2) - Copy.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1202, N'/Images/CompressedTripImages/20210427020954_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1203, N'/Images/CompressedTripImages/20210427021005_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1204, N'/Images/CompressedTripImages/20210427021013_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1205, N'/Images/CompressedTripImages/20210427021019_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1206, N'/Images/CompressedTripImages/20210427021029_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1207, N'/Images/CompressedTripImages/20210427021038_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1208, N'/Images/CompressedTripImages/20210427021043_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1209, N'/Images/CompressedTripImages/20210427022623_Untitleddesign(2).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1210, N'/Images/CompressedTripImages/20210427022626_Untitleddesign(1).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1211, N'/Images/CompressedItenaryImages/20210427022640_FIGHTTOLEH(3).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1212, N'/Images/CompressedItenaryImages/20210427022654_FIGHTTOLEH.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1213, N'/Images/CompressedTripImages/20210427044055_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1214, N'/Images/CompressedTripImages/20210427044059_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1215, N'/Images/CompressedTripImages/20210427044103_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1216, N'/Images/CompressedTripImages/20210427044108_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1217, N'/Images/CompressedTripImages/20210427044113_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1218, N'/Images/CompressedTripImages/20210427044118_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1219, N'/Images/CompressedTripImages/20210427044124_10.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1220, N'/Images/CompressedItenaryImages/20210427045241_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1221, N'/Images/CompressedItenaryImages/20210427045441_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1222, N'/Images/CompressedItenaryImages/20210427045525_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1223, N'/Images/CompressedItenaryImages/20210427045902_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1224, N'/Images/CompressedItenaryImages/20210427045958_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1225, N'/Images/CompressedItenaryImages/20210427050203_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1226, N'/Images/CompressedTripImages/20210427051128_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1227, N'/Images/CompressedTripImages/20210427051131_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1228, N'/Images/CompressedTripImages/20210427051134_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1229, N'/Images/CompressedTripImages/20210427051137_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1230, N'/Images/CompressedTripImages/20210427051141_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1231, N'/Images/CompressedTripImages/20210427051143_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1232, N'/Images/CompressedTripImages/20210427051146_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1233, N'/Images/CompressedTripImages/20210427051149_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1234, N'/Images/CompressedTripImages/20210427051153_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1235, N'/Images/CompressedTripImages/20210427051158_10.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1236, N'/Images/CompressedItenaryImages/20210427051331_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1237, N'/Images/CompressedItenaryImages/20210427051426_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1238, N'/Images/CompressedItenaryImages/20210427051503_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1239, N'/Images/CompressedItenaryImages/20210427051529_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1240, N'/Images/CompressedItenaryImages/20210427052857_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1241, N'/Images/CompressedItenaryImages/20210427052936_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1242, N'/Images/CompressedTripImages/20210427054723_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1243, N'/Images/CompressedTripImages/20210427054726_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1244, N'/Images/CompressedTripImages/20210427054728_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1245, N'/Images/CompressedTripImages/20210427054731_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1246, N'/Images/CompressedTripImages/20210427054734_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1247, N'/Images/CompressedTripImages/20210427054737_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1248, N'/Images/CompressedTripImages/20210427054740_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1249, N'/Images/CompressedTripImages/20210427054743_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1250, N'/Images/CompressedTripImages/20210427054746_10.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1251, N'/Images/CompressedTripImages/20210427054748_HighlightsofLadakh.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1252, N'/Images/CompressedItenaryImages/20210427054854_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1253, N'/Images/CompressedItenaryImages/20210427054944_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1254, N'/Images/CompressedItenaryImages/20210427055125_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1255, N'/Images/CompressedItenaryImages/20210427055540_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1256, N'/Images/CompressedItenaryImages/20210427055643_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1257, N'/Images/CompressedItenaryImages/20210427055817_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1258, N'/Images/CompressedItenaryImages/20210427055909_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1259, N'/Images/CompressedTripImages/20210428030714_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1260, N'/Images/CompressedTripImages/20210428030721_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1261, N'/Images/CompressedTripImages/20210428030725_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1262, N'/Images/CompressedTripImages/20210428030729_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1263, N'/Images/CompressedTripImages/20210428030733_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1264, N'/Images/CompressedTripImages/20210428030738_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1265, N'/Images/CompressedTripImages/20210428030743_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1266, N'/Images/CompressedTripImages/20210428030747_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1267, N'/Images/CompressedTripImages/20210428030750_11.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1268, N'/Images/CompressedTripImages/20210428030754_12.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1269, N'/Images/CompressedTripImages/20210428030759_13.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1270, N'/Images/CompressedTripImages/20210428030803_ANDAMAN&NICOBAR.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1271, N'/Images/CompressedItenaryImages/20210428031037_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1272, N'/Images/CompressedItenaryImages/20210428031214_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1273, N'/Images/CompressedItenaryImages/20210428031508_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1274, N'/Images/CompressedTripImages/20210428032239_1.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1275, N'/Images/CompressedTripImages/20210428032243_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1276, N'/Images/CompressedTripImages/20210428032245_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1277, N'/Images/CompressedTripImages/20210428032248_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1278, N'/Images/CompressedTripImages/20210428032251_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1279, N'/Images/CompressedTripImages/20210428032254_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1280, N'/Images/CompressedTripImages/20210428032257_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1281, N'/Images/CompressedTripImages/20210428032300_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1282, N'/Images/CompressedTripImages/20210428032302_11.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1283, N'/Images/CompressedTripImages/20210428032305_12.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1284, N'/Images/CompressedTripImages/20210428032308_13.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1285, N'/Images/CompressedItenaryImages/20210428035534_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1286, N'/Images/CompressedItenaryImages/20210428035605_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1287, N'/Images/CompressedItenaryImages/20210428035637_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1288, N'/Images/CompressedItenaryImages/20210428040344_DepartLeh.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1289, N'/Images/CompressedItenaryImages/20210428040535_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1290, N'/Images/CompressedItenaryImages/20210428040649_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1291, N'/Images/CompressedTripImages/20210428041741_2.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1292, N'/Images/CompressedTripImages/20210428041744_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1293, N'/Images/CompressedTripImages/20210428041746_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1294, N'/Images/CompressedTripImages/20210428041749_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1295, N'/Images/CompressedTripImages/20210428041752_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1296, N'/Images/CompressedTripImages/20210428041755_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1297, N'/Images/CompressedTripImages/20210428041758_8.png', NULL)
GO
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1298, N'/Images/CompressedTripImages/20210428041800_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1299, N'/Images/CompressedTripImages/20210428041805_10.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1300, N'/Images/CompressedTripImages/20210428041811_11.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1301, N'/Images/CompressedTripImages/20210428041813_12.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1302, N'/Images/CompressedTripImages/20210428041816_13.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1303, N'/Images/CompressedTripImages/20210428041819_ANDAMAN&NICOBAR.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1304, N'/Images/CompressedItenaryImages/20210428042056_8.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1305, N'/Images/CompressedItenaryImages/20210428042141_3.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1306, N'/Images/CompressedItenaryImages/20210428042225_4.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1307, N'/Images/CompressedItenaryImages/20210428042332_5.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1308, N'/Images/CompressedItenaryImages/20210428042446_6.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1309, N'/Images/CompressedItenaryImages/20210428042556_7.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1310, N'/Images/CompressedItenaryImages/20210428042650_9.png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1311, N'/Images/CompressedTripImages/20210428120008_Untitleddesign(4).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1312, N'/Images/HomeBanner/20210428121224_Untitled design (4).png', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1313, N'/Images/HomeBanner/20210505032540_Trincomalee 2.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1314, N'/Images/CompressedPopularDestination/20210505032708_Trincomalee2.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1315, N'/Images/CompressedPopularDestination/20210505032731_Galle2.jpg', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1316, N'/Images/CompressedPopularDestination/20210505032810_3.png', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1317, N'/Images/CompressedPopularDestination/20210505032857_6.png', 1)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1318, N'/Images/HomeBanner/20210510013401_5f217d681ffd2-Kasol Sight Seeing Tour.jpg', NULL)
INSERT [dbo].[ImageMaster] ([ImageId], [ImagePath], [IsActive]) VALUES (1319, N'/Images/CompressedItenaryImages/20210616224609_Chairman''sSuite.Livingroom.jpg', NULL)
SET IDENTITY_INSERT [dbo].[ImageMaster] OFF
SET IDENTITY_INSERT [dbo].[ItenaryMaster] ON 

INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (42, 10036, 1, N'<p><b>?













 Arrival in 
Leh</b></p><p><b>After arrival at Leh Airport, 
you would be transferred to 
hotel for check-in. Today 
you are free for leisure &amp; 
aclimatization. This way you 
can explore the Leh town and 
also become familiar with the 
high altitude climate. late 
afternoon visit Shanti Stupa 
and Leh Palace .Overnight 
stay at Leh.</b></p>', 1220)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (43, 10036, 2, N'<p><b></b></p>

 <b>Leh to ?Khardungla&nbsp;&nbsp;</b><div><b>After breakfast . Enroute 
visit Khardung-la-pass, the 
highest motorable road in 
the world at 18,380ft. It is 
situated to the north of 
Ladakh between the 
Karakoram and Ladakh 
ranges of the Himalayas. 
evening visit hall of fame 
Magnetic hill, Gurduwara 
Pattar Sahib and Sangam. 
Overnight stay at Leh</b>

<p><b></b></p></div>', 1221)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (44, 10036, 3, N'<p>

<b>Leh to Pangong Lake&nbsp;</b></p><p><b>&nbsp;After breakfast, drive to 
Pangong Lake, east to the Leh 
after crossing Changla Pass 
(17500ft) and driving via 
Durbuk and Tangtse villages in 
the Changthang region of 
Ladakh and perhaps one of the 
most amazing lakes in Asia 
which changes its color 4 – 5 
times a day. Evening back to 
leh . At evening enjoy the 
breathtaking view of Pangong 
Lake. Overnight at the Camp at Pangong Lake.</b>

<br></p>', 1225)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (45, 10036, 4, N'<p><b></b></p>

 <b></b><b></b><b>Leh City Tour&nbsp;&nbsp;</b><div><b>&nbsp;Early morning enjoy the 
picturesque view of Sun rise 
on lake. After Breakfast 
drive back to Leh, enroute 
visit Shey palace and 3 idiot 
school overnight at Leh. 
Evening free for leisure &amp; own 
activities. Overnight stay at 
Leh.</b>

<div><b></b>

<div><b></b>

<p><b></b></p></div></div></div>', 1223)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (46, 10036, 5, N'<p><b></b></p>

 <b></b><b></b><b></b>

<b>Depart Leh&nbsp;</b><div><b>After Breakfast, check out from the 
Hotel &amp; you would be transferred 
to Leh Airport. Your memorable 
tour to beautiful Ladakh concludes 
here.</b>

<div><b></b>

<div><b></b>

<div><b></b>

<p><b></b></p></div></div></div></div>', 1224)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (47, 10037, 1, N'<p><b>

Arrival to Leh&nbsp;</b></p><p><b>After arrival at Leh Airport, 
you would be transferred to 
hotel for check-in. Today 
you are free for leisure &amp; 
aclimatization. This way you 
can explore the Leh town and 
also become familiar with the 
high altitude climate. late 
afternoon visit Shanti Stupa
and Leh Palace . Overnight 
stay at Leh.

</b><br></p>', 1236)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (48, 10037, 2, N'<p><b>

City tour&nbsp;</b></p><p><b>&nbsp;After breakfast leave for half 
day excursion to Hall of 
Fame, Gurudwara Pathar 
Sahib, Magnetic Hill &amp; 
Sangam View where Indus &amp; 
Zanskar river meet. 
Afternoon you would be 
driven back to hotel. In the 
evening enjoy a sunset at 
Shanti Stupa. Overnight 
stay at Leh.

</b><br></p>', 1237)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (49, 10037, 3, N'<p><b>

Leh to Nubra Valley</b></p><p><b>After breakfast you would be 
driven to Nubra Valley. 
Enroute visit Khardung-lapass, the highest motorable 
road in the world at 18,380ft. 
Nubra Valley is popularly 
known as Ldorma or the 
valley of flowers. It is 
situated to the north of 
Ladakh between the 
Karakoram and Ladakh ranges of the Himalayas. Arrive at Hunder &amp; check in at Hotel/Camps. Later 
visit Diskit Village &amp; enjoy the Camel ride on sand dunes. Dinner and overnight stay at Hotel/Camp.

</b><br></p>', 1238)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (50, 10037, 4, N'<p><b>

Nubra 
to Pangong Lake&nbsp;</b></p><p><b>After breakfast, drive to 
Pangong Lake, east to 
the Leh after crossing 
Changla Pass (17500ft) 
and driving via Durbuk 
and Tangtse villages in 
the Changthang region of 
Ladakh and perhaps one 
of the most amazing 
lakes in Asia which 
changes its color 4 – 5 
times a day. Evening 
back to leh . At evening 
enjoy the breathtaking view of Pangong Lake. Overnight at the Camp at Pangong Lake.

</b><br></p>', 1239)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (51, 10037, 5, N'<p><b>Leh City Tour</b></p><p><b>Early morning enjoy the 
picturesque view of Sun rise on 
lake. After Breakfast drive back 
to Leh, enroute visit Hemis, Shey 
and Thiksey monasteries and 3 
idiot school overnight at Leh. 
Evening free for leisure &amp; own 
activities. Overnight stay at Leh.

</b><br></p>', 1240)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (52, 10037, 6, N'<p><b></b></p>



<b>Depart Leh</b><div><b>After Breakfast, check out from the 
Hotel &amp; you would be transferred 
to Leh Airport. Your memorable 
tour to beautiful Ladakh concludes 
here.

?</b><b></b><p><b>

</b><br></p></div>', 1241)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (53, 10038, 1, N'<p><b>Arrival to Leh</b></p><p><b>After arrival at Leh Airport, 
you would be transferred to 
hotel for check-in. Today 
you are free for leisure &amp; 
aclimatization. This way 
you can explore the Leh 
town and also become 
familiar with the high 
altitude climate. late 
afternoon visit Shanti Stupa
and Leh Palace . Overnight 
stay at Leh.

</b><br></p>', 1252)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (54, 10038, 2, N'<b>

City tour</b><div><b>After breakfast leave for half 
day excursion to Hall of 
Fame, Gurudwara Pathar 
Sahib, Magnetic Hill &amp; 
Sangam View where Indus &amp; 
Zanskar river meet. 
Afternoon you would be 
driven back to hotel. In the 
evening enjoy a sunset at 
Shanti Stupa. Overnight 
stay at Leh.</b></div>', 1253)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (55, 10038, 3, N'<b>

 Leh to Nubra Valley&nbsp;</b><div><b>After breakfast you would be 
driven to Nubra Valley. 
Enroute visit Khardung-lapass, the highest motorable 
road in the world at 18,380ft. 
Nubra Valley is popularly 
known as Ldorma or the 
valley of flowers. It is 
situated to the north of 
Ladakh between the Karakoram and Ladakh ranges of the Himalayas. Arrive at Hunder &amp; check in at&nbsp;hotel/Camps. Later visit Diskit Village &amp; enjoy the Camel ride on sand dunes. Dinner and overnight 
stay at Hotel/Camp.




</b><br></div>', 1254)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (56, 10038, 4, N'<b>

Nubra to
Pangong Lake&nbsp;</b><div><b>After breakfast, drive to 
Pangong Lake, east to the Leh 
after crossing Changla Pass 
(17500ft) and driving via 
Durbuk and Tangtse villages in 
the Changthang region of 
Ladakh and perhaps one of the 
most amazing lakes in Asia 
which changes its color 4 – 5 
times a day. Evening back to 
leh . At evening enjoy the 
breathtaking view of Pangong
Lake. Overnight at the Camp at Pangong Lake.


</b><br></div>', 1255)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (57, 10038, 5, N'<div><b>

Pangong Lake to Tsomoriri Lake</b></div><div><b>After breakfast, drive to 
Tsomoriri lake (14000 ft 
abov sea level) by passing 
Chumathang (Hot Spring) 
along the Indus river. 
Tsomoriri Arr. 1600 Hrs.

Afterwards take a walk around the Lake to enjoy the scenic beauty. Overnight at Korzok Village.




</b><br></div>', 1256)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (58, 10038, 6, N'<p><b>?Leh City Tour</b></p><p><b>Early morning enjoy the 
picturesque view of Sun rise on 
lake. After Breakfast drive back 
to Leh, enroute visit Hemis, Shey 
and Thiksey monasteries and 3 
idiot school overnight at Leh. 
Evening free for leisure &amp; own 
activities. Overnight stay at Leh.</b></p>', 1257)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (59, 10038, 7, N'<p><b>



Depart Leh&nbsp;</b></p><p><b>After Breakfast, check out from the 
Hotel &amp; you would be transferred 
to Leh Airport. Your memorable 
tour to beautiful.


</b><br></p>', 1258)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (63, 10040, 1, N'<p><b>

<p><b>Arrival at Port Blair &amp; City Tour</b></p><p><b>Pick up from the airport and drop at hotel, After lunch trip to Carbyn Cove beach, Historical Cellular Jail and evening Light &amp; Sound show in Cellular Jail. Return to hotel.</b></p>

</b><br></p>', 1285)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (64, 10040, 2, N'<p><b>

<p>

<p><b>Port Blair to  Havelock Island</b></p><p><b>After breakfast leave for Havelock Island in cruise boat, Pickup from jetty and drop to resort. After Lunch trip to Radhanagar beach. Return to hotel</b></p>

<br></p></b></p>', 1286)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (65, 10040, 3, N'<p><b>

<p>

<p><b>Havelock Island to Sightseeing</b></p><p><b>After breakfast, a trip to elephant Beach with Complimentary snorkeling/Speed boat ride beach.Evening return to the resort.</b><b><br></b>

<br></p></p></b></p>', 1287)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (66, 10040, 5, N'<p><b>

<p>

<p>

 Port blair to North bay + Rose island</p><p>

<b>After breakfast leave for port blair in cruise boat, Pickup from jetty and drop to resort. After lunch v</b>isit North 
island + Rose island. Evening 
return to Hotel 

<br></p></p></b></p>', 1288)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (67, 10040, 4, N'<p><b>

<p>

<p>

Havelock Island to Port Blair.</p><p>After breakfast, check out 
from resort at 9 am, leave for 
Port blair by cruise boat reach 
Port Blair by 12 pm and check 
in at hotel, After lunch visit 
Chidyatapu . Return to hotel.</p></p></b></p>', 1289)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (68, 10040, 6, N'<p><b>

<p>

<p>

</p>Back to Home Town.</p><p>As per your Flight schedule, you 
will be transferred to Port Blair 
Airport.We await for your next 
visit. BonVoyage. Service ends</p><p><p></p></p></b></p>', 1290)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (69, 10041, 1, N'<p><b><p><b><b>Arrival at Port Blair.</b></b></p><p><b><b>Pick up from the airport and drop at hotel, After lunch trip to Carbyn Cove beach, Historical Cellular Jail and evening Light &amp; Sound show in Cellular Jail. Return to hotel.</b></b></p>

</b><br></p>', 1304)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (70, 10041, 2, N'<p><p><b>

Port Blair to Havelock 
Island.</b></p><p><b>After breakfast leave for Havelock Island 
in cruise boat, Pickup from jetty and drop 
to resort. After Lunch trip to Radhanagar 
beach. Return to hotel</b></p><b><p><br></p></b></p>', 1305)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (71, 10041, 3, N'<p>

<p><b><b>Havelock Island to Sightseeing.</b></b></p><p><b><b>After breakfast, a trip to elephant Beach with Complimentary snorkeling/Speed boat ride beach.Evening return to the resort.</b></b></p></p>', 1306)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (72, 10041, 4, N'<p><b>Havelock Island to Neil 
Island.</b></p><p><b>After breakfast, check out from 
resort at 9 am, leave for Neil 
island by cruise Reach Neil island
by 12 pm and check in at hotel, 
After lunch visit Bharatpur Beach 
&amp; Laxmanpur Beach . Return to 
hotel.

</b><br></p>', 1307)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (73, 10041, 5, N'<p><b></b><b>Port 
Blair City Tour.</b></p><p><b>After breakfast, check out from 
resort at 9 am, leave for Port 
blair by cruise boat reach Port 
Blair by 12 pm and check in at 
hotel, After lunch visit
Chidyatapu . Return to hotel.</b></p><p><b>

</b></p>', 1308)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (74, 10041, 6, N'<p><b></b><b>

Baratang Island &amp; 
Limestone Tour.</b></p><p><b>After breakfast, visit to Baratang
Island and visit Limestone Caves 
by boat. Limestone Caves is a 
marvel of nature. This rare set 
of caves houses both stalactites 
&amp; stalagmites in the same 
cave. Return to hotel.</b></p><p><b>

</b></p>', 1309)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (75, 10041, 7, N'<p><b></b><b>

</b></p>

<b>Back to Home Town.</b><div><span style="font-weight: bold;">As per your Flight schedule, you will be transferred to Port Blair Airport.We await for your next visit. BonVoyage. Service ends</span><p><b></b></p><p><b>

</b></p></div>', 1310)
INSERT [dbo].[ItenaryMaster] ([ItenaryId], [TripId], [Day], [DayDetail], [ImageId]) VALUES (76, 10042, 1, N'<p><p><b>On arrival pick up from Airport or Railway station</b><b>. </b><b>Depart for Rampur</b><b>. </b><b>On the way visit Pinjore Garden,
Timber Trail</b><b>. </b><b>On arrival check in hotel</b><b>.</b><b> Later Visit Local Market</b><b>. </b><b>Dinner &amp; Overnight stay at
Hotel</b><b>.</b><b></b></p>





<p><br></p></p>', 1319)
SET IDENTITY_INSERT [dbo].[ItenaryMaster] OFF
SET IDENTITY_INSERT [dbo].[PopularDestination] ON 

INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (1, N'Canada', N'Kerala', 1009, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (2, N'Dubai', N'Dubai', 1051, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (3, N'Hydrabad', N'Hydrabad', 1052, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (4, N'Andra', N'Andra Pradesh', 1071, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (5, N'Srilnka', N'Srilanka', 1093, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (6, N'SouthKorea', N'Korea Tour', 1126, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (7, N'Singapore', N'singapore jewels', 1176, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (8, N'Dhaaakaa', N'kk', 1177, 0)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (9, N'India', N'Sundowner to Goa', 1314, 1)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (10, N'India', N'CRUISE WEEKENDER', 1315, 1)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (11, N'India', N'LEH', 1316, 1)
INSERT [dbo].[PopularDestination] ([ppId], [LocationId], [Title], [ImageId], [IsActive]) VALUES (12, N'Port blair', N'BLISSFUL ANDAMAN PACKAGE', 1317, 1)
SET IDENTITY_INSERT [dbo].[PopularDestination] OFF
SET IDENTITY_INSERT [dbo].[Port_Master] ON 

INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (8, N'MUMBAI', CAST(0x0000AD1E015C0D2E AS DateTime), CAST(0x0000AD1E015C0D2E AS DateTime))
INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (9, N'KOCHI', CAST(0x0000AD1E015C169D AS DateTime), CAST(0x0000AD1E015C169D AS DateTime))
INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (10, N'GOA', CAST(0x0000AD1E015C21A3 AS DateTime), CAST(0x0000AD1E015C21A3 AS DateTime))
INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (11, N'LAKSHADWEEP', CAST(0x0000AD1E015C2BCC AS DateTime), CAST(0x0000AD1E015C2BCC AS DateTime))
INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (12, N'DIU', CAST(0x0000AD1E015C453C AS DateTime), CAST(0x0000AD1E015C453C AS DateTime))
INSERT [dbo].[Port_Master] ([PortId], [PortName], [InsertedOn], [UpdatedOn]) VALUES (13, N'CHENNIA', CAST(0x0000AD1F00A4D8B4 AS DateTime), CAST(0x0000AD1F00A4D8B4 AS DateTime))
SET IDENTITY_INSERT [dbo].[Port_Master] OFF
SET IDENTITY_INSERT [dbo].[Rent] ON 

INSERT [dbo].[Rent] ([RentId], [Location], [VehicleType], [VehicleName], [Cost], [Description], [Terms], [ImageId]) VALUES (16, N'Hydrabad', 2, N'Mustang 1980', 20000, N'<p>

A <b>car</b>&nbsp;(or <b>automobile</b>) is a wheeled motor <b>vehicle</b>&nbsp;used for transportation. Most definitions of <b>car</b>&nbsp;say they run primarily on roads, seat one to eight people, have four tires, and mainly transport people rather than goods.

<br></p>', N'<p>

&nbsp;The present Terms and Conditions establish the rights and obligations of the Renter during use of the Vehicle. The Renter is aware that the right of use of the Vehicle belongs to the Car Hire Company, and that the Renter does not have powers for transfer of the rights and obligations accepted by him or her by conclusion of the Agreement to third persons (among other, for transfer of the right to the Vehicle). Rent or transfer of the Vehicle to third persons is permitted only on the basis of a prior written agreement with the Car Hire Company. The Car Hire Company allows the Renter to use the Vehicle in accordance with the present Terms and Conditions

<br></p>', 1146)
INSERT [dbo].[Rent] ([RentId], [Location], [VehicleType], [VehicleName], [Cost], [Description], [Terms], [ImageId]) VALUES (17, N'Hydrabad', 1, N'Harley Davidson', 5000, N'<p>

It is the responsibility of Clients to hold their own travel insurance policy to cover personal medical care in case of an accident, loss due to cancellation, and any third party liability that may arise from the use of the Rental Bikes by Clients. QBE travel insurance now offers coverage for bike hire by selecting the “specified items” option when purchasing your policy or at any time prior to departure after the policy is issued.

<br></p>', N'<p>

<p>Any damage to and the costs associated with repairing the Rental Bike fair wear and tear excepted (including but not limited to all labour, replacement parts, repainting and any other work necessary to restore the Rental Bike to as new condition) during the Rental Period, whether or not caused by the Client, to the maximum of the market value of the Rental Bike as reasonably determined by Bikestyle Tours;</p><p>In the event of theft, the Rental Bike being un-repairable, or the anticipated costs associated with repair exceeding the market value (as reasonably determined by Bikestyle Tours), the market value of the Rental Bike as reasonably determined by Bikestyle Tours.</p>

<br></p>', 1147)
SET IDENTITY_INSERT [dbo].[Rent] OFF
SET IDENTITY_INSERT [dbo].[ResetPassword] ON 

INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (1, 2922953, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (2, 840801, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (3, 9346233, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (4, 4331009, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (5, 7362348, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (6, 2357530, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (7, 3306897, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (8, 6338236, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (9, 594246, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (10, 8501238, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (11, 5625071, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (12, 3558077, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (13, 6308154, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (14, 4477328, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (15, 6383199, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (16, 976774, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (17, 418485, CAST(0x8C3E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (18, 5261943, CAST(0xA53E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (19, 1815941, CAST(0xA53E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (20, 5021987, CAST(0xA53E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (21, 3593670, CAST(0xA53E0B00 AS Date))
INSERT [dbo].[ResetPassword] ([ResetId], [TokenId], [CreatedDate]) VALUES (22, 4275302, CAST(0x2B3F0B00 AS Date))
SET IDENTITY_INSERT [dbo].[ResetPassword] OFF
SET IDENTITY_INSERT [dbo].[Ship_General_Activities] ON 

INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (599, 27, 1, N'151,300 tons')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (600, 27, 2, N'3352')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (602, 27, 7, N'1674')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (603, 27, 3, N'1099.08 ft')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (604, 27, 4, N'18')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (605, 27, 8, N'131.234 ft')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (601, 27, 6, N'2016')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (638, 28, 1, N'48,563')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (639, 28, 2, N'1800')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (640, 28, 6, N'1200+')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (641, 28, 7, N'796')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (642, 28, 3, N'692')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (643, 28, 4, N'11')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (644, 28, 5, N'20')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (645, 28, 8, N'70')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (646, 29, 1, N'48,563')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (647, 29, 2, N'1800')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (648, 29, 6, N'1200+')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (649, 29, 7, N'796')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (650, 29, 3, N'692 FT')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (651, 29, 4, N'11')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (652, 29, 5, N'20')
INSERT [dbo].[Ship_General_Activities] ([ShipGenId], [CruiseId], [ShipId], [Detail]) VALUES (653, 29, 8, N'70 FT')
SET IDENTITY_INSERT [dbo].[Ship_General_Activities] OFF
SET IDENTITY_INSERT [dbo].[Ship_General_Master] ON 

INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (1, N'Gross tonnage', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (2, N'Number of passengers', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (3, N'Length', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (4, N'Decks', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (5, N'Average Speed', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (6, N'Crew members', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (7, N'Number of Staterooms', NULL)
INSERT [dbo].[Ship_General_Master] ([ShipId], [ShipName], [FAIconName]) VALUES (8, N'Width', NULL)
SET IDENTITY_INSERT [dbo].[Ship_General_Master] OFF
SET IDENTITY_INSERT [dbo].[STATEMASTER] ON 

INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (3, N'Bali', 5, 0)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (4, N'Andra Pradesh', 6, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (5, N'Kerla', 6, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (6, N'Manali', 6, 0)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (7, N'Jammu Kashmir', 6, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (8, N'Bali', 5, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (9, N'Maldives', 5, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (11, N'Dhaaakaa', 8, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (12, N'Seoul', 9, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (13, N'Singapore', 10, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (14, N'Ladakh', 6, 1)
INSERT [dbo].[STATEMASTER] ([StateID], [StateName], [CountryId], [Isactive]) VALUES (15, N'Andaman & Nicobar', 6, 1)
SET IDENTITY_INSERT [dbo].[STATEMASTER] OFF
SET IDENTITY_INSERT [dbo].[ThemeMaster] ON 

INSERT [dbo].[ThemeMaster] ([ThemeId], [ThemeName], [ThemeIcon]) VALUES (1, N'Beach', NULL)
INSERT [dbo].[ThemeMaster] ([ThemeId], [ThemeName], [ThemeIcon]) VALUES (2, N'Mountain', NULL)
INSERT [dbo].[ThemeMaster] ([ThemeId], [ThemeName], [ThemeIcon]) VALUES (3, N'Family', NULL)
INSERT [dbo].[ThemeMaster] ([ThemeId], [ThemeName], [ThemeIcon]) VALUES (4, N'Peaceful', NULL)
SET IDENTITY_INSERT [dbo].[ThemeMaster] OFF
SET IDENTITY_INSERT [dbo].[TourPackage] ON 

INSERT [dbo].[TourPackage] ([PackageId], [PackageValue], [ImageId]) VALUES (8, 8000, 1137)
INSERT [dbo].[TourPackage] ([PackageId], [PackageValue], [ImageId]) VALUES (9, 12000, 1138)
INSERT [dbo].[TourPackage] ([PackageId], [PackageValue], [ImageId]) VALUES (10, 18000, 1139)
INSERT [dbo].[TourPackage] ([PackageId], [PackageValue], [ImageId]) VALUES (11, 25000, 1140)
SET IDENTITY_INSERT [dbo].[TourPackage] OFF
SET IDENTITY_INSERT [dbo].[TrendingMaster] ON 

INSERT [dbo].[TrendingMaster] ([TrendingId], [SequenceId], [Groupname], [Packages]) VALUES (21, 4, N'dvxcv', N'Select,HIGHLIGHTS OF LADAKH,BEST OF LEH LADAKH,MAJESTIC LADAKH PACKAGE,EXOTIC ANDAMAN PACKAGE,BLISSFUL ANDAMAN PACKAGE,spiti')
INSERT [dbo].[TrendingMaster] ([TrendingId], [SequenceId], [Groupname], [Packages]) VALUES (22, 1, N'ssadsdads', N'spiti')
SET IDENTITY_INSERT [dbo].[TrendingMaster] OFF
SET IDENTITY_INSERT [dbo].[TripImageMaster] ON 

INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (2, 4, 3)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1050, 1213, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1051, 1214, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1052, 1215, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1053, 1216, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1054, 1217, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1055, 1218, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1056, 1219, 10036)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1057, 1226, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1058, 1227, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1059, 1228, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1060, 1229, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1061, 1230, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1062, 1231, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1063, 1232, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1064, 1233, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1065, 1234, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1066, 1235, 10037)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1067, 1242, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1068, 1243, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1069, 1244, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1070, 1245, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1071, 1246, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1072, 1247, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1073, 1248, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1074, 1249, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1075, 1250, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1076, 1251, 10038)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1089, 1274, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1090, 1275, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1091, 1276, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1092, 1277, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1093, 1278, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1094, 1279, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1095, 1280, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1096, 1281, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1097, 1282, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1098, 1283, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1099, 1284, 10040)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1100, 1291, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1101, 1292, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1102, 1293, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1103, 1294, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1104, 1295, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1105, 1296, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1106, 1297, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1108, 1299, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1109, 1300, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1110, 1301, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1111, 1302, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1112, 1303, 10041)
INSERT [dbo].[TripImageMaster] ([TripImageID], [ImageId], [TripId]) VALUES (1113, 1311, 10042)
SET IDENTITY_INSERT [dbo].[TripImageMaster] OFF
SET IDENTITY_INSERT [dbo].[TripMaster] ON 

INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (3, N'sfsf', N'Maharastra,Indai', N'0', N'200', CAST(0x6C3E0B00 AS Date), N'<p>cb xcbx</p>', N'<p>gfdzgvzd</p>', 0, NULL, N'<p>dgbcxb</p>', 10, N'Mountain, Family', CAST(0x733E0B00 AS Date), 5, N'Indai', N'Maharastra', N'0', NULL)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10036, N'HIGHLIGHTS OF LADAKH', N'Leh,Ladakh,India', N'1', N'11999', CAST(0x72420B00 AS Date), N'<p><ul><li><b>?

Daily Breakfast &amp; Dinner</b></li><li><b>&nbsp;Inner line permit&nbsp;</b></li><li><b>Accommodation on Double / Triple shares Basis.</b></li><li><b>&nbsp;Package includes all transfers and sightseeing by private (Xylo or Similar) ? to all Sightseeing 
Places as per itinerary; road taxes, parking fee, Driver allowances, fuel charges, interstate taxes.&nbsp;</b></li><li><b>&nbsp;Travel insurance</b></li><li><b>&nbsp;Applicable taxes.


</b></li></ul></p>', N'<p><ul><li><b>

Anything not mentioned under ‘Package Inclusions’&nbsp;</b></li><li><b>&nbsp;All personal expenses, optional tours and extra meals.</b></li><li><b>&nbsp;Any kind of entry fees anywhere if not mentioned in including.

</b></li><li><b>

Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of 
personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></li><li><b>&nbsp;Meals &amp; drinks other than specified in inclusions.</b></li><li><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></li><li><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.

<br></b></li></ul></p>', 1, NULL, N'<p>

<b>Leh Ladakh can be best described as India’s Shangri La. A land that looks too distant to be true, it is wedged between the high Himalayas. Dotted by high-altitude lakes and lofty peaks such as Stok Kangri, Leh and Ladakh offer an experience that does not have an equal. While stargazing might just be the most fascinating thing to do here, driving through the high mountain passes and wandering in the winding lanes of Leh are once in a lifetime’s experiences. It is not for without any reason that Leh Ladakh trip is rated as one of the most sought-after road trips on Earth. In case you are in a mood to fully explore the oh-so-beautiful destination, try to plan a trip during the festive season. Ladakh actually comes alive during festivals and you will actually be able to not only explore the place, but also be a part of their culture and tradition.</b>

<br></p>', 20, N'Mountain, Family, Peaceful', CAST(0x01440B00 AS Date), 5, N'India', N'Ladakh', N'Leh', 1)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10037, N'BEST OF LEH LADAKH', N'Leh,Ladakh,India', N'2', N'12499', CAST(0x72420B00 AS Date), N'<p>

<div><div><p></p><ul><li><b>Daily Breakfast &amp; Dinner</b></li><li><b>Inner line permit </b></li><li><b>Accommodation on Double / Triple shares Basis.</b></li><li><b>&nbsp;Package includes all transfers and sightseeing by private (Xylo or Similar) ? to all Sightseeing Places as per itinerary; road taxes, parking fee, Driver allowances, fuel charges, interstate taxes. </b></li><li><b>&nbsp;Travel insurance</b></li><li><b>&nbsp;Applicable taxes.</b></li></ul></div></div><div><br></div></p>', N'<p>

<div><div><ul><li><b>Anything not mentioned under ‘Package Inclusions’ </b></li><li><b>&nbsp;All personal expenses, optional tours and extra meals.</b></li><li><b>&nbsp;Any kind of entry fees anywhere if not mentioned in including.</b></li><li><b>Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></li><li><b>&nbsp;Meals &amp; drinks other than specified in inclusions.</b></li><li><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></li><li><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.</b></li></ul></div></div></p>', 1, NULL, N'<p><b>?Leh Ladakh can be best described as India’s Shangri La. A land that looks too distant to be true, it is wedged between the high Himalayas. Dotted by high-altitude lakes and lofty peaks such as Stok Kangri, Leh and Ladakh offer an experience that does not have an equal. While stargazing might just be the most fascinating thing to do here, driving through the high mountain passes and wandering in the winding lanes of Leh are once in a lifetime’s experiences. It is not for without any reason that Leh Ladakh trip is rated as one of the most sought-after road trips on Earth. In case you are in a mood to fully explore the oh-so-beautiful destination, try to plan a trip during the festive season. Ladakh actually comes alive during festivals and you will actually be able to not only explore the place, but also be a part of their culture and tradition.

</b><br></p>', 0, N'Mountain, Family, Peaceful', CAST(0x72420B00 AS Date), 6, N'India', N'Ladakh', N'Leh', 1)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10038, N'MAJESTIC LADAKH PACKAGE', N'Leh,Ladakh,India', N'2', N'14999', CAST(0x72420B00 AS Date), N'<p>

<div><div><ul><li><b>Daily Breakfast &amp; Dinner</b></li><li><b>Inner line permit</b></li><li><b>Accommodation on Double / Triple shares Basis.</b></li><li><b>&nbsp;Package includes all transfers and sightseeing by private (Xylo or Similar) ? to all Sightseeing Places as per itinerary; road taxes, parking fee, Driver allowances, fuel charges, interstate taxes.</b></li><li><b>&nbsp;Travel insurance</b></li><li><b>&nbsp;Applicable taxes.</b></li></ul></div></div><div><br>

</div><br></p>', N'<p><b>?

<ul><li><b>Anything not mentioned under ‘Package Inclusions’</b></li><li><b>&nbsp;All personal expenses, optional tours and extra meals.</b></li><li><b>&nbsp;Any kind of entry fees anywhere if not mentioned in including.</b></li><li><b>Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></li><li><b>&nbsp;Meals &amp; drinks other than specified in inclusions.</b></li><li><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></li><li><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.</b></li></ul>

</b><br></p>', 1, NULL, N'<p><b>Leh Ladakh can be best described as India’s Shangri La. A land that looks too distant to be true, it is wedged between the high Himalayas. Dotted by high-altitude lakes and lofty peaks such as Stok Kangri, Leh and Ladakh offer an experience that does not have an equal. While stargazing might just be the most fascinating thing to do here, driving through the high mountain passes and wandering in the winding lanes of Leh are once in a lifetime’s experiences. It is not for without any reason that Leh Ladakh trip is rated as one of the most sought-after road trips on Earth. In case you are in a mood to fully explore the oh-so-beautiful destination, try to plan a trip during the festive season. Ladakh actually comes alive during festivals and you will actually be able to not only explore the place, but also be a part of their culture and tradition.

</b><br></p>', 0, N'Mountain, Family, Peaceful', CAST(0x72420B00 AS Date), 7, N'India', N'Ladakh', N'Leh', 1)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10040, N'EXOTIC ANDAMAN PACKAGE', N'Andaman &,India', N'2', N'19999', CAST(0x73420B00 AS Date), N'<p><b>

<ul><li><b>05 Nights / 06 Days accommodation in 3star &nbsp;</b></li><li><b>Daily breakfast  &amp; Dinner </b></li><li><b>All sightseeing and transfers by Private vehicle </b></li><li><b>Driver allowances, fuel, parking charges, toll taxes and interstate taxes. </b></li><li><b>Separate Private Vehicle in Port Blair Havelock AND NEIL ISLAND </b></li><li><b>Port Blair-Havelock-Port Blair by Cruise Boat. </b></li><li><b>1 Complimentary Session of Snorkelling </b></li><li><b>Child below 5 years is complimentary (without extra bed). </b></li><li><b>Applicable taxes.</b></li></ul></b></p>', N'<p><b>

<ul><li><b><b>Anything not mentioned under ‘Package Inclusions’</b></b></li><li><b><b>All personal expenses, optional tours and extra meals.</b></b></li><li><b><b>Any kind of entry fees anywhere if not mentioned in including.</b></b></li><li><b><b>Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></b></li><li><b><b>Meals &amp; drinks other than specified in inclusions.</b></b></li><li><b><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></b></li><li><b><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.</b></b></li></ul>

</b><br></p>', 1, NULL, N'<p><b>

<p>Andaman, the exotic emerald isle with very blue seas and virgin forests, white glistening sandy beaches and the seclusion from the main land, is a coveted destination for people all across the world. Here the food is not very expensive. Tasty and hygienic meals are served at beach shacks where you can eat to your heart’s content along with your favourite drink. The people of the islands are very simple and down-to-earth. They would always make you feel at home, cosy and comfortable. The tropical weather with pleasant sunny beaches, warm waters, crystal clear waters full of animated sea life and exotic corals will make your vacation full of joy and fun.</p></b></p>', 0, N'Beach, Family, Peaceful', CAST(0x73420B00 AS Date), 6, N'India', N'Andaman &', N'0', 1)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10041, N'BLISSFUL ANDAMAN PACKAGE', N'Andaman &,India', N'2', N'31999', CAST(0x73420B00 AS Date), N'<p>

<ul><li><b><b>05 Nights / 06 Days accommodation in 3star &nbsp;</b></b></li><li><b><b>Daily breakfast &amp; Dinner</b></b></li><li><b><b>All sightseeing and transfers by Private vehicle</b></b></li><li><b><b>Driver allowances, fuel, parking charges, toll taxes and interstate taxes.</b></b></li><li><b><b>Separate Private Vehicle in Port Blair Havelock AND NEIL ISLAND</b></b></li><li><b><b>Port Blair-Havelock-Port Blair by Cruise Boat.</b></b></li><li><b><b>1 Complimentary Session of Snorkelling</b></b></li><li><b><b>Child below 5 years is complimentary (without extra bed).</b></b></li><li><b><b>Applicable taxes.</b></b></li></ul></p>', N'<p>

<ul><li><b><b><b>Anything not mentioned under ‘Package Inclusions’</b></b></b></li><li><b><b><b>All personal expenses, optional tours and extra meals.</b></b></b></li><li><b><b><b>Any kind of entry fees anywhere if not mentioned in including.</b></b></b></li><li><b><b><b>Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></b></b></li><li><b><b><b>Meals &amp; drinks other than specified in inclusions.</b></b></b></li><li><b><b><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></b></b></li><li><b><b><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.</b></b></b></li></ul></p>', 1, NULL, N'<p><b><b>Andaman, the exotic emerald isle with very blue seas and virgin forests, white glistening sandy beaches and the seclusion from the main land, is a coveted destination for people all across the world. Here the food is not very expensive. Tasty and hygienic meals are served at beach shacks where you can eat to your heart’s content along with your favourite drink. The people of the islands are very simple and down-to-earth. They would always make you feel at home, cosy and comfortable. The tropical weather with pleasant sunny beaches, warm waters, crystal clear waters full of animated sea life and exotic corals will make your vacation full of joy and fun.</b>

</b><br></p>', 0, N'Beach, Family, Peaceful', CAST(0x73420B00 AS Date), 7, N'India', N'Andaman &', N'0', 1)
INSERT [dbo].[TripMaster] ([TripId], [TripTitle], [TripLocation], [TripCategory], [TripCost], [TripDate], [TripInclusion], [TripExclusion], [TripStatus], [IsCompleted], [TripOverview], [Seat], [TripTheme], [ToDate], [TripDays], [Country], [State], [City], [IsItenary]) VALUES (10042, N'spiti', N'Kerla,India', N'2', N'27999', CAST(0x74420B00 AS Date), N'<p>

</p><ul><li><b><b>05 Nights / 06 Days accommodation in 3star &nbsp;</b></b></li><li><b><b>Daily breakfast &amp; Dinner</b></b></li><li><b><b>All sightseeing and transfers by Private vehicle</b></b></li><li><b><b>Driver allowances, fuel, parking charges, toll taxes and interstate taxes.</b></b></li><li><b><b>Separate Private Vehicle in Port Blair Havelock AND NEIL ISLAND</b></b></li><li><b><b>Port Blair-Havelock-Port Blair by Cruise Boat.</b></b></li><li><b><b>1 Complimentary Session of Snorkelling</b></b></li><li><b><b>Child below 5 years is complimentary (without extra bed).</b></b></li><li><b><b>Applicable taxes.</b></b></li></ul><p></p>', N'<p></p><ul><li><b><b><b>Anything not mentioned under ‘Package Inclusions’</b></b></b></li><li><b><b><b>All personal expenses, optional tours and extra meals.</b></b></b></li><li><b><b><b>Any kind of entry fees anywhere if not mentioned in including.</b></b></b></li><li><b><b><b>Tips, medical insurance, laundry charges, liquors, mineral water, telephone charges. All items of personal nature. Porter, pony, horse, cable car, boat, train tickets, air tickets charges.</b></b></b></li><li><b><b><b>Meals &amp; drinks other than specified in inclusions.</b></b></b></li><li><b><b><b>&nbsp;Expenses of personal nature such as portages, tips, telephone calls, laundry expenses etc.</b></b></b></li><li><b><b><b>&nbsp;All entrances, camera fees, guide &amp; driver tipping.</b></b></b></li></ul><p></p>', 1, NULL, N'<p><b><b>Andaman, the exotic emerald isle with very blue seas and virgin forests, white glistening sandy beaches and the seclusion from the main land, is a coveted destination for people all across the world. Here the food is not very expensive. Tasty and hygienic meals are served at beach shacks where you can eat to your heart’s content along with your favourite drink. The people of the islands are very simple and down-to-earth. They would always make you feel at home, cosy and comfortable. The tropical weather with pleasant sunny beaches, warm waters, crystal clear waters full of animated sea life and exotic corals will make your vacation full of joy and fun.</b>

</b><br></p>', 0, N'Beach, Family, Peaceful', CAST(0x74420B00 AS Date), 6, N'India', N'Kerla', N'0', NULL)
SET IDENTITY_INSERT [dbo].[TripMaster] OFF
SET IDENTITY_INSERT [dbo].[TripTypeMaster] ON 

INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (1, N'group', 1, CAST(0x7A3E0B00 AS Date))
INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (2, N'FAMILY PACKAGE', 1, CAST(0x893E0B00 AS Date))
INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (3, N'GROUP', 0, CAST(0x893E0B00 AS Date))
INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (4, N'GROUP', 0, CAST(0x893E0B00 AS Date))
INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (5, N'College IV', 1, CAST(0x923E0B00 AS Date))
INSERT [dbo].[TripTypeMaster] ([TypeId], [TypeName], [IsActive], [CreatedDate]) VALUES (6, N'TEST1', 0, CAST(0x44420B00 AS Date))
SET IDENTITY_INSERT [dbo].[TripTypeMaster] OFF
SET IDENTITY_INSERT [dbo].[vehicleMaster] ON 

INSERT [dbo].[vehicleMaster] ([VehicleId], [VehicleName]) VALUES (1, N'2Wheeler')
INSERT [dbo].[vehicleMaster] ([VehicleId], [VehicleName]) VALUES (2, N'4Wheeler')
INSERT [dbo].[vehicleMaster] ([VehicleId], [VehicleName]) VALUES (3, N'Bus')
INSERT [dbo].[vehicleMaster] ([VehicleId], [VehicleName]) VALUES (4, N'Truck')
SET IDENTITY_INSERT [dbo].[vehicleMaster] OFF
SET IDENTITY_INSERT [dbo].[Visa] ON 

INSERT [dbo].[Visa] ([VisaId], [CountryId], [Cost], [DocumentRequirment], [ImageId], [InsertedOn], [UpdatedOn]) VALUES (17, 9, 2000, N'<p>

<ul><li>Passport application completely filled out (must be completed in black ink) with the exception of your signature.</li><li>One 2 x 2 official color passport photograph with a light or white background. You can get these at various retail stores (Walgreen''s, Wolf Camera, CVS, etc.).</li><li>Certified copy of birth certificate or Naturalization Papers (proof of U.S. Citizenship). For those born in Georgia a certified birth certificate may be obtained in the Probate Court on the 1st floor of the Rockdale Courthouse.</li><li>Both parents or child''s legal guardian(s) must be present for children UNDER AGE 16. If the second parent is not available to sign, (<a target="_blank" rel="nofollow" href="http://www.rockdaleclerk.com/files/Passport-Form-DS-3053.pdf">click here to download form</a>)</li><li>Valid picture I.D. card:<ul><li>Previous U.S. passport book or U.S. passport card</li><li>Certificate of Naturalization with identifiable photo attached</li><li>Certificate of Citizenship with identifiable photo attached</li><li>Valid driver''s license (not temporary or learner''s permit)</li><li>Official U.S. military or military dependent identification card</li><li>Government employee identification card (federal, state, county, municipal)</li><li>Current foreign passport</li><li>FAA pilot''s license</li></ul></li></ul>

<br></p>', 1128, CAST(0x0000A94B00B5AC75 AS DateTime), NULL)
INSERT [dbo].[Visa] ([VisaId], [CountryId], [Cost], [DocumentRequirment], [ImageId], [InsertedOn], [UpdatedOn]) VALUES (18, 2, 200000, N'<p>

<ul><li><strong>Passport</strong>, in original, with a minimum validity of six months as on the date of submission of application for visa. The passport should have at least two blank pages. Copy of the passport (first four pages and endorsement of extension of validity if any) should be attached</li><br><li>One <strong>recent passport-size colour photograph</strong>&nbsp;depicting full face.</li><br><li><strong>Proof of Residence:</strong>&nbsp;Either a copy of National ID Card or Utility Bill such as electricity, telephone or water bill</li><br><li><strong>Proof of Profession:</strong>&nbsp;Certificate from the employer. In case of students, copy of Identity card from the educational institution is to be attached.</li><br><li><strong>Proof of Financial soundness:</strong>&nbsp;Endorsement of foreign currency equivalent to US $150/- per applicant or copy of international credit card or updated bank statement showing sufficient balance to finance travel to India.</li></ul>

<br></p>', 1141, CAST(0x0000A94E0065A4DB AS DateTime), NULL)
INSERT [dbo].[Visa] ([VisaId], [CountryId], [Cost], [DocumentRequirment], [ImageId], [InsertedOn], [UpdatedOn]) VALUES (19, 4, 100000, N'<p>

<ul><li><strong>Passport</strong>, in original, with a minimum validity of six months as on the date of submission of application for visa. The passport should have at least two blank pages. Copy of the passport (first four pages and endorsement of extension of validity if any) should be attached</li><br><li>One <strong>recent passport-size colour photograph</strong>&nbsp;depicting full face.</li><br><li><strong>Proof of Residence:</strong>&nbsp;Either a copy of National ID Card or Utility Bill such as electricity, telephone or water bill</li><br><li><strong>Proof of Profession:</strong>&nbsp;Certificate from the employer. In case of students, copy of Identity card from the educational institution is to be attached.</li><br><li><strong>Proof of Financial soundness:</strong>&nbsp;Endorsement of foreign currency equivalent to US $150/- per applicant or copy of international credit card or updated bank statement showing sufficient balance to finance travel to India.</li></ul>

<br></p>', 1142, CAST(0x0000A94E0065E399 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Visa] OFF
SET IDENTITY_INSERT [SiddhiTours].[MailDetails] ON 

INSERT [SiddhiTours].[MailDetails] ([MailId], [EMailId], [DisplayName], [InsertedOn], [UpdatedOn]) VALUES (1, N'booking@siddhitours.com', N'Siddhi Tours', CAST(0x0000A9460120FB5D AS DateTime), CAST(0x0000AD15017EA4CB AS DateTime))
SET IDENTITY_INSERT [SiddhiTours].[MailDetails] OFF
/****** Object:  Index [UQ__TourPack__F81CE744FEF24416]    Script Date: 8/18/2021 10:49:48 PM ******/
ALTER TABLE [dbo].[TourPackage] ADD UNIQUE NONCLUSTERED 
(
	[PackageValue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cruise_Company_master] ADD  DEFAULT (getdate()) FOR [InsertedOn]
GO
ALTER TABLE [dbo].[Cruise_Company_master] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[Cruise_Master] ADD  CONSTRAINT [DF_Cruise_Master_InsertedOn]  DEFAULT (getdate()) FOR [InsertedOn]
GO
ALTER TABLE [dbo].[Cruise_Master] ADD  CONSTRAINT [DF_Cruise_Master_UpdatedOn]  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[Port_Master] ADD  DEFAULT (getdate()) FOR [InsertedOn]
GO
ALTER TABLE [dbo].[Port_Master] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[TripTypeMaster] ADD  CONSTRAINT [DF__TripTypeM__IsAct__108B795B]  DEFAULT ('1') FOR [IsActive]
GO
ALTER TABLE [dbo].[TripTypeMaster] ADD  CONSTRAINT [DF__TripTypeM__Creat__117F9D94]  DEFAULT ('sysdate') FOR [CreatedDate]
GO
ALTER TABLE [SiddhiTours].[MailDetails] ADD  DEFAULT (getdate()) FOR [InsertedOn]
GO
ALTER TABLE [SiddhiTours].[MailDetails] ADD  DEFAULT (getdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[CityMaster]  WITH CHECK ADD FOREIGN KEY([StateId])
REFERENCES [dbo].[STATEMASTER] ([StateID])
GO
ALTER TABLE [dbo].[ItenaryMaster]  WITH CHECK ADD  CONSTRAINT [FK__ItenaryMa__Image__2EDAF651] FOREIGN KEY([ImageId])
REFERENCES [dbo].[ImageMaster] ([ImageId])
GO
ALTER TABLE [dbo].[ItenaryMaster] CHECK CONSTRAINT [FK__ItenaryMa__Image__2EDAF651]
GO
ALTER TABLE [dbo].[ItenaryMaster]  WITH CHECK ADD  CONSTRAINT [FK__ItenaryMa__TripI__2DE6D218] FOREIGN KEY([TripId])
REFERENCES [dbo].[TripMaster] ([TripId])
GO
ALTER TABLE [dbo].[ItenaryMaster] CHECK CONSTRAINT [FK__ItenaryMa__TripI__2DE6D218]
GO
ALTER TABLE [dbo].[STATEMASTER]  WITH CHECK ADD FOREIGN KEY([CountryId])
REFERENCES [dbo].[CountryMaster] ([CountryID])
GO
ALTER TABLE [dbo].[TripImageMaster]  WITH CHECK ADD FOREIGN KEY([ImageId])
REFERENCES [dbo].[ImageMaster] ([ImageId])
GO
ALTER TABLE [dbo].[TripImageMaster]  WITH CHECK ADD FOREIGN KEY([TripId])
REFERENCES [dbo].[TripMaster] ([TripId])
GO
USE [master]
GO
ALTER DATABASE [SiddhiTours] SET  READ_WRITE 
GO
