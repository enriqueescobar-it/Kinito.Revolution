USE [DaneGeih]
GO

/****** Object:  Table [dbo].[AreaFuerza]    Script Date: 12-Jun-17 21:00:18 ******/
DROP TABLE [dbo].[AreaFuerza]
GO

/****** Object:  Table [dbo].[AreaFuerza]    Script Date: 12-Jun-17 21:00:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AreaFuerza](
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
	[P6290] [int] NULL,
	[P6290s1] [varchar](30) NULL,
	[P6230] [int] NOT NULL,
	[P6240] [int] NOT NULL,
	[P6240s1] [varchar](30) NULL,
	[P6250] [int] NULL,
	[P6260] [int] NULL,
	[P6270] [int] NULL,
	[P6280] [int] NULL,
	[P6300] [int] NULL,
	[P6310] [int] NULL,
	[P6310s1] [varchar](30) NULL,
	[P6320] [int] NULL,
	[P6330] [int] NULL,
	[P6340] [int] NULL,
	[P6350] [int] NULL,
	[P6351] [int] NULL,
	[Mes] [nchar](2) NOT NULL,
	[Ft] [int] NOT NULL,
	[Dpto] [int] NOT NULL,
	[Fex_c_2011] [real] NOT NULL
) ON [PRIMARY]
GO


