USE [db_Test]
GO
/****** Object:  User [wzd_test]    Script Date: 12/07/2017 13:35:49 ******/
CREATE USER [wzd_test] FOR LOGIN [wzd_test] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_UserRole]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_UserRole](
	[UserAutoID] [int] NOT NULL,
	[RoleAutoID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_User]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_User](
	[UserAutoID] [int] IDENTITY(2000,1) NOT NULL,
	[UserLoginName] [nvarchar](50) NOT NULL,
	[UserPassword] [nvarchar](60) NULL,
	[UserFullName] [nvarchar](50) NULL,
	[UserSex] [nvarchar](50) NULL,
	[UserState] [nvarchar](50) NULL,
	[DeptID] [int] NULL,
	[UserMemo] [nvarchar](500) NULL,
 CONSTRAINT [PK_tb_Test_User] PRIMARY KEY CLUSTERED 
(
	[UserAutoID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_RoleFunc]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_RoleFunc](
	[RoleAutoID] [int] NOT NULL,
	[FuncAutoID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_Role]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_Role](
	[RoleAutoID] [int] IDENTITY(1000,1) NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
	[DeptID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_OperationLog]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_OperationLog](
	[LogID] [bigint] IDENTITY(1,1) NOT NULL,
	[LogType] [nvarchar](50) NULL,
	[LogContent] [nvarchar](200) NULL,
	[LogTime] [datetime] NULL,
	[LogTable] [nvarchar](50) NULL,
	[LogFormName] [nvarchar](50) NULL,
	[LogUserFullName] [nvarchar](50) NULL,
	[LogPCIP] [nvarchar](50) NULL,
	[LogPCName] [nvarchar](50) NULL,
 CONSTRAINT [PK_tb_Test_OperationLog] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_Func]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_Func](
	[FuncAutoID] [int] IDENTITY(1000,1) NOT NULL,
	[FuncName] [nvarchar](50) NOT NULL,
	[FuncCaption] [nvarchar](50) NOT NULL,
	[FuncType] [nvarchar](50) NOT NULL,
	[FuncParentID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_Test_Sys_Department]    Script Date: 12/07/2017 13:35:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_Test_Sys_Department](
	[DeptID] [int] IDENTITY(1000,1) NOT NULL,
	[DeptName] [nvarchar](50) NOT NULL,
	[ParentID] [int] NULL,
 CONSTRAINT [PK_tb_Test_Department] PRIMARY KEY CLUSTERED 
(
	[DeptID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_Test_Sys_LogQuery]    Script Date: 12/07/2017 13:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Test_Sys_LogQuery] 
	-- Add the parameters for the stored procedure here
	@strType AS NVARCHAR(50)=''
	,@strContent AS NVARCHAR(200)=''
	,@strTimeA AS NVARCHAR(30)=''
	,@strTimeB AS NVARCHAR(30)=''
	,@strForm AS NVARCHAR(50)=''
	,@strUser AS NVARCHAR(50)=''
	,@strIP AS NVARCHAR(50)=''
	,@strPC AS NVARCHAR(50)=''
	,@strField AS NVARCHAR(50)='LogTime'
	,@strSort AS NVARCHAR(10)='ASC'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @strSQL AS NVARCHAR(2000) 
	DECLARE @intLoc AS INT
    -- Insert statements for procedure here
    SET @strSQL ='SELECT * FROM tb_Test_Sys_OperationLog '
    
    IF LEN(@strType)>0 SET @strSQL =@strSQL +' AND LogType='''+@strType+'''' 
    IF LEN(@strTimeA)>0 AND LEN(@strTimeB)>0 SET @strSQL =@strSQL +' AND (LogTime BETWEEN '''+@strTimeA+''' AND '''+@strTimeB+''')' 
    IF LEN(@strForm)>0 SET @strSQL =@strSQL +' AND LogFormName LIKE ''%'+@strForm+'%''' 
    IF LEN(@strUser)>0 SET @strSQL =@strSQL +' AND LogUserFullName LIKE ''%'+@strUser+'%''' 
    IF LEN(@strIP)>0 SET @strSQL =@strSQL +' AND LogPCIP LIKE ''%'+@strIP+'%''' 
    IF LEN(@strPC)>0 SET @strSQL =@strSQL +' AND LogPCName LIKE ''%'+@strPC+'%'''
    IF LEN(@strContent)>0 SET @strSQL =@strSQL +' AND LogContent LIKE ''%'+@strContent+'%'''
    
    SET @intLoc = CHARINDEX(' AND ',@strSQL)
    IF @intLoc >0 SET @strSQL =STUFF (@strSQL,@intLoc,5,' WHERE ')
    
	SET @strSQL =@strSQL+' ORDER BY '+@strField+' '+@strSort  
	
	EXEC(@strSQL)
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Test_Sys_LogAdd]    Script Date: 12/07/2017 13:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Test_Sys_LogAdd] 
	-- Add the parameters for the stored procedure here
	@strType AS NVARCHAR(50)='select'
	,@strForm AS NVARCHAR(50)=''
	,@strTable AS NVARCHAR(50)=''
	,@strContent AS NVARCHAR(200)=''
	,@strUser AS NVARCHAR(50)=''
	,@strIP AS NVARCHAR(50)=''
	,@strPC AS NVARCHAR(50)=''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tb_Test_Sys_OperationLog
	(LogType ,LogFormName ,LogTable ,LogContent ,LogUserFullName ,
	LogPCIP ,LogPCName ,LogTime )
	VALUES(@strType ,@strForm ,@strTable ,@strContent ,@strUser ,
	@strIP ,@strPC ,GETDATE() );
	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Test_Sys_UserLogin]    Script Date: 12/07/2017 13:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Test_Sys_UserLogin] 
	-- Add the parameters for the stored procedure here
	@strUN AS NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * 
	FROM tb_Test_Sys_User 
	WHERE UserLoginName =@strUN 

END
GO
/****** Object:  StoredProcedure [dbo].[sp_Test_Sys_UserInfo]    Script Date: 12/07/2017 13:35:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_Test_Sys_UserInfo]
	-- Add the parameters for the stored procedure here
	@intUID AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tb_Test_Sys_User 
	WHERE UserAutoID = @intUID 
END
GO
