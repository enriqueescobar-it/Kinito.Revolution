USE [DaneGeih]
GO

/****** Object:  Table [dbo].[AreaDesocupados]    Script Date: 14-Jun-17 01:00:55 ******/
DROP TABLE [dbo].[AreaDesocupados]
GO

/****** Object:  Table [dbo].[AreaDesocupados]    Script Date: 14-Jun-17 01:00:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[AreaDesocupados](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Directorio] [bigint] NOT NULL,
	[Secuencia_p] [int] NOT NULL,
	[Month] [smallint] NOT NULL,
	[Year] [int] NOT NULL,
	[Quarter] [nchar](2) NOT NULL,
	[Orden] [int] NOT NULL,
	[Hogar] [int] NOT NULL,
	[Regis] [int] NOT NULL,
	[Area] [nchar](2) NOT NULL,
	[P7250] [int] NOT NULL,
	[P7260] [int] NOT NULL,
	[P7280] [int] NOT NULL,
	[P7280s1] [nchar](20) NULL,
	[P7310] [int] NOT NULL,
	[P7320] [int] NULL,
	[P7350] [int] NULL,
	[P7350s1] [nchar](20) NULL,
	[P7360] [int] NULL,
	[P7390] [int] NULL,
	[P7390s1] [nchar](20) NULL,
	[P7420] [nchar](20) NULL,
	[P7420s1] [int] NULL,
	[P7420s2] [int] NULL,
	[P7420s3] [int] NULL,
	[P7420s4] [int] NULL,
	[P7420s5] [int] NULL,
	[P7420s6] [int] NULL,
	[P7420s7] [int] NULL,
	[P7420s8] [int] NULL,
	[P7420s7a1] [nchar](20) NULL,
	[P7422] [int] NULL,
	[P7422s1] [int] NULL,
	[P9460] [int] NULL,
	[Oficio1] [nchar](2) NULL,
	[Oficio2] [nchar](2) NULL,
	[Rama2d_d] [nchar](2) NULL,
	[Dsi] [int] NOT NULL,
	[Dscy] [int] NOT NULL,
	[Rama4d_d] [nchar](4) NULL,
	[Mes] [nchar](2) NULL,
	[Depto] [nchar](2) NULL,
	[Fex_c_2011] [real] NULL
) ON [PRIMARY]
GO


