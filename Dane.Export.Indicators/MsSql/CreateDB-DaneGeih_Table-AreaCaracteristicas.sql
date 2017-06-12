USE [DaneGeih]
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaCaracteristicas'
GO

EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaCaracteristicas', @level2type=N'COLUMN',@level2name=N'Id'
GO

/****** Object:  Table [dbo].[AreaCaracteristicas]    Script Date: 2017-06-12 01:34:50 ******/
DROP TABLE [dbo].[AreaCaracteristicas]
GO

/****** Object:  Table [dbo].[AreaCaracteristicas]    Script Date: 2017-06-12 01:34:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AreaCaracteristicas](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Directorio] [bigint] NOT NULL,
	[Secuencia_p] [int] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [nchar](2) NOT NULL,
	[Orden] [int] NOT NULL,
	[Hogar] [int] NOT NULL,
	[Regis] [int] NOT NULL,
	[P6016] [int] NOT NULL,
	[P6020] [int] NOT NULL,
	[P6030] [int] NOT NULL,
	[P6030s1] [int] NULL,
	[P6030s3] [int] NULL,
	[P6040] [int] NOT NULL,
	[P6050] [int] NOT NULL,
	[P6070] [int] NULL,
	[P6090] [int] NOT NULL,
	[P6140] [int] NULL,
	[P6150] [int] NULL,
	[P6100] [int] NULL,
	[P6110] [int] NULL,
	[P6120] [int] NULL,
	[P6125] [int] NOT NULL,
	[P6160] [int] NULL,
	[P6170] [int] NULL,
	[P6175] [int] NULL,
	[P6210] [int] NULL,
	[P6210s1] [int] NULL,
	[P6220] [int] NULL,
	[Area] [int] NOT NULL,
	[Esc] [int] NOT NULL,
	[Mes] [nchar](2) NOT NULL,
	[p6269] [int] NULL,
	[Dpto] [int] NOT NULL,
	[Fex_c_2011] [real] NOT NULL
) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AreaC_Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaCaracteristicas', @level2type=N'COLUMN',@level2name=N'Id'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AreaCaracteristicas' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaCaracteristicas'
GO


