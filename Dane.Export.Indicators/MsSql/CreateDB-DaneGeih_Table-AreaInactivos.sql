USE [DaneGeih]
GO

/****** Object:  Table [dbo].[AreaInactivos]    Script Date: 6/15/2017 12:36:02 AM ******/
DROP TABLE [dbo].[AreaInactivos]
GO

/****** Object:  Table [dbo].[AreaInactivos]    Script Date: 6/15/2017 12:36:02 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AreaInactivos](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Directorio] [bigint] NOT NULL,
	[Secuencia_p] [int] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [nchar](2) NOT NULL,
	[Orden] [int] NOT NULL,
	[Hogar] [int] NOT NULL,
	[Regis] [int] NOT NULL,
	[Area] [int] NOT NULL,
	[P7430] [int] NOT NULL,
	[P7440] [int] NULL,
	[P7450] [int] NULL,
	[P7450s1] [varchar](20) NULL,
	[P7460] [int] NULL,
	[P7470] [int] NULL,
	[P7472] [int] NOT NULL,
	[P7472s1] [int] NULL,
	[P7454] [int] NULL,
	[P7456] [int] NULL,
	[P7458s1] [varchar](48) NULL,
	[P7458] [int] NULL,
	[P7452] [int] NULL,
	[Ini] [smallint] NOT NULL,
	[Mes] [nchar](2) NOT NULL,
	[Depto] [nchar](2) NOT NULL,
	[Fex_c_2011] [real] NOT NULL
) ON [PRIMARY]
GO


