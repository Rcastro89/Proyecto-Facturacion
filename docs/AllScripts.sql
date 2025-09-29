CREATE DATABASE LabDevTest3Test3;
GO

USE LabDevTest3Test3;
GO

-- Crear login si no existe
IF NOT EXISTS (SELECT name FROM sys.sql_logins WHERE name = 'developer')
BEGIN
    CREATE LOGIN developer WITH PASSWORD = 'abc123ABC';
END
GO

-- Crear usuario dentro de la base de datos
CREATE USER developer FOR LOGIN developer;
ALTER ROLE db_owner ADD MEMBER developer;
GO

USE [LabDevTest3Test3]
GO

/****** Object:  Table [dbo].[TblTipoCliente]    Script Date: 28/09/2025 10:00:25 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TblTipoCliente](
	[IdTipoCliente] [int] IDENTITY(1,1) NOT NULL,
	[NombreTipoCliente] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdTipoCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

USE [LabDevTest3Test3]
GO


SET IDENTITY_INSERT [dbo].[TblTipoCliente] ON;
GO

INSERT INTO [dbo].[TblTipoCliente] (IdTipoCliente, NombreTipoCliente)
VALUES
    (1, 'Natural'),
    (2, 'Juridico');
GO

-- Deshabilitar inserción manual
SET IDENTITY_INSERT [dbo].[TblTipoCliente] OFF;
GO

USE [LabDevTest3Test3]
GO

/****** Object:  Table [dbo].[TblClientes]    Script Date: 28/09/2025 10:03:24 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TblClientes](
	[IdCliente] [int] IDENTITY(1,1) NOT NULL,
	[NombreCliente] [nvarchar](100) NOT NULL,
	[ApellidoCliente] [nvarchar](100) NULL,
	[Direccion] [nvarchar](200) NULL,
	[Telefono] [nvarchar](20) NULL,
	[Email] [nvarchar](100) NULL,
	[NIT] [nvarchar](20) NULL,
	[IdTipoCliente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblClientes]  WITH CHECK ADD  CONSTRAINT [FK_Clientes_TipoCliente] FOREIGN KEY([IdTipoCliente])
REFERENCES [dbo].[TblTipoCliente] ([IdTipoCliente])
GO

ALTER TABLE [dbo].[TblClientes] CHECK CONSTRAINT [FK_Clientes_TipoCliente]
GO


USE [LabDevTest3Test3]
GO

-- Poblar la tabla TblClientes
INSERT INTO [dbo].[TblClientes] 
    (NombreCliente, ApellidoCliente, Direccion, Telefono, Email, NIT, IdTipoCliente)
VALUES
    ('Carlos', 'Ramírez', 'Calle 10 #23-45', '3004567890', 'carlos.ramirez@mail.com', '123456789-0', 1),
    ('María', 'Gómez', 'Carrera 5 #67-89', '3019876543', 'maria.gomez@mail.com', '987654321-1', 1),
    ('Andrés', 'Pérez', 'Av. Principal 45', '3025556677', 'andres.perez@mail.com', '112233445-2', 1),
    ('Laura', 'Martínez', 'Calle 20 #12-34', '3201112233', 'laura.martinez@mail.com', '223344556-3', 1),
    ('José', 'López', 'Carrera 50 #30-20', '3104445566', 'jose.lopez@mail.com', '334455667-4', 1),
    ('Comercializadora XYZ', NULL, 'Zona Industrial #100', '3151234567', 'contacto@xyz.com', '800123456-5', 2),
    ('Distribuidora ABC', NULL, 'Calle 80 #45-67', '3187654321', 'ventas@abc.com', '900987654-6', 2),
    ('Servicios Globales', NULL, 'Av. Las Américas #55', '3134567890', 'info@global.com', '811223344-7', 2),
    ('Construcciones Delta', NULL, 'Cra. 40 #60-80', '3162223344', 'delta@construcciones.com', '822334455-8', 2),
    ('Tecnología Innovar', NULL, 'Parque Empresarial #25', '3199998888', 'contacto@innovar.com', '833445566-9', 2);
GO

USE [LabDevTest3Test3]
GO

/****** Object:  Table [dbo].[CatProductos]    Script Date: 28/09/2025 10:05:16 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CatProductos](
	[IdProducto] [int] IDENTITY(1,1) NOT NULL,
	[NombreProducto] [nvarchar](100) NOT NULL,
	[Precio] [decimal](18, 2) NOT NULL,
	[Stock] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
	[imageUrl] [nvarchar](1024) NULL,
PRIMARY KEY CLUSTERED 
(
	[IdProducto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [LabDevTest3Test3]
GO

-- Poblar la tabla CatProductos
INSERT INTO [dbo].[CatProductos]
    (NombreProducto, Precio, Stock, Estado, imageUrl)
VALUES
    ('Arroz Diana 1kg', 3500.00, 120, 1, 'https://cdn1.totalcommerce.cloud/mercacentro/product-zoom/es/arroz-diana--3000-g-1.webp'),
    ('Aceite Premier 1L', 8900.00, 80, 1, 'https://olimpica.vtexassets.com/arquivos/ids/1300141/7701018076430.jpg?v=638428552067630000'),
    ('Leche Alpina 1L', 4200.00, 200, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9gJCoK-V7oRhvHKYQHWOXxhaj2yxQDbTfKA&s'),
    ('Pan Bimbo Familiar', 5500.00, 60, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQJFlItMk7y7-z6CrThebyzvyG3judt493gEw&s'),
    ('Azúcar Incauca 1kg', 4800.00, 90, 1, 'https://olimpica.vtexassets.com/arquivos/ids/614541/7702059402028.jpg?v=637626519480170000'),
    ('Gaseosa Coca-Cola 1.5L', 5200.00, 150, 1, 'https://olimpica.vtexassets.com/arquivos/ids/1733358/7702535024423_0.jpg?v=638729899536970000'),
    ('Jugo Hit Mango 1L', 3800.00, 70, 1, 'https://http2.mlstatic.com/D_NQ_NP_916815-MCO76236931202_052024-O.webp'),
    ('Café Juan Valdez 500g', 14500.00, 40, 1, 'https://comprocafedecolombia.com/wp-content//uploads/2021/03/Organico-454-1.png'),
    ('Galletas Festival 6 und', 2500.00, 100, 1, 'https://copservir.vtexassets.com/arquivos/ids/1630276/GALLETA-FESTIVAL-6-CHOCOLATE_F.png?v=638879858839000000'),
    ('Atún Van Camps 160g', 6200.00, 85, 1, 'https://olimpica.vtexassets.com/arquivos/ids/1395255/7702367002613.jpg?v=638856779047000000'),
    ('Laptop HP 14”', 2200000.00, 10, 1, 'https://reset.net.co/wp-content/uploads/2022/06/HP-14-Celeron-8GB-SSD-256GB-14-cf2509la-v3.webp'),
    ('Mouse Logitech M90', 35000.00, 25, 1, 'https://media.falabella.com/falabellaCO/126652751_01/w=1500,h=1500,fit=pad'),
    ('Teclado Genius USB', 42000.00, 20, 1, 'https://elpuntodelaimpresora.com/wp-content/uploads/2023/06/TECLADOGENIUS118.gif'),
    ('Auriculares Sony', 120000.00, 15, 1, 'https://panamericana.vtexassets.com/arquivos/ids/323254-800-auto?v=636937804246400000&width=800&height=auto&aspect=true'),
    ('Celular Samsung A54', 1450000.00, 12, 1, 'https://smselectronic.com/wp-content/uploads/2023/03/01-3.jpg'),
    ('Silla de Oficina', 320000.00, 8, 1, 'https://m.media-amazon.com/images/I/71LIaGhKn9S.jpg'),
    ('Escritorio Madera', 450000.00, 5, 1, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQSbbDdUGhCgXHdf2Gr1pydfZyUarpDAvWqg&s'),
    ('Ventilador Oster', 180000.00, 10, 1, 'https://http2.mlstatic.com/D_NQ_NP_875073-MCO32899601891_112019-O.webp'),
    ('Televisor LG 55”', 2500000.00, 6, 1, 'https://carulla.vtexassets.com/arquivos/ids/20050482/Televisor-LG-55-Pulgadas-OLED-Uhd-4K-Smart-TV-OLED55C4PSAAWC-3598333_a.jpg?v=638792026972470000'),
    ('Lavadora Samsung 20kg', 3200000.00, 4, 1, 'https://media.falabella.com/falabellaCO/48850674_2/w=800,h=800,fit=pad');
GO


USE [LabDevTest3Test3]
GO

/****** Object:  Table [dbo].[TblFacturas]    Script Date: 28/09/2025 10:07:51 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TblFacturas](
	[IdFactura] [int] IDENTITY(1,1) NOT NULL,
	[NumeroFactura] [nvarchar](50) NOT NULL,
	[FechaFactura] [datetime] NOT NULL,
	[TotalFactura] [decimal](18, 2) NOT NULL,
	[IdCliente] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblFacturas]  WITH CHECK ADD  CONSTRAINT [FK_Facturas_Clientes] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[TblClientes] ([IdCliente])
GO

ALTER TABLE [dbo].[TblFacturas] CHECK CONSTRAINT [FK_Facturas_Clientes]
GO


USE [LabDevTest3Test3]
GO

/****** Object:  Table [dbo].[TblDetalleFacturas]    Script Date: 28/09/2025 10:08:11 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TblDetalleFacturas](
	[IdDetalleFactura] [int] IDENTITY(1,1) NOT NULL,
	[IdFactura] [int] NOT NULL,
	[IdProducto] [int] NOT NULL,
	[Cantidad] [int] NOT NULL,
	[PrecioUnitario] [decimal](18, 2) NOT NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[IdDetalleFactura] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblDetalleFacturas]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Facturas] FOREIGN KEY([IdFactura])
REFERENCES [dbo].[TblFacturas] ([IdFactura])
GO

ALTER TABLE [dbo].[TblDetalleFacturas] CHECK CONSTRAINT [FK_Detalles_Facturas]
GO

ALTER TABLE [dbo].[TblDetalleFacturas]  WITH CHECK ADD  CONSTRAINT [FK_Detalles_Productos] FOREIGN KEY([IdProducto])
REFERENCES [dbo].[CatProductos] ([IdProducto])
GO

ALTER TABLE [dbo].[TblDetalleFacturas] CHECK CONSTRAINT [FK_Detalles_Productos]
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetClients]    Script Date: 28/09/2025 10:14:58 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_GetClients]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.IdCliente,
        c.NombreCliente,
        c.ApellidoCliente,
        c.Direccion,
        c.Telefono,
        c.Email,
        c.NIT,
        tc.NombreTipoCliente
    FROM TblClientes c
    INNER JOIN TblTipoCliente tc ON c.IdTipoCliente = tc.IdTipoCliente
END;
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetLastInvoiceNumber]    Script Date: 28/09/2025 10:15:15 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetLastInvoiceNumber]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @LastInvoiceNumber NVARCHAR(50);
    DECLARE @NextInvoiceNumber NVARCHAR(50);
    DECLARE @LastNumberInt INT;

    SELECT TOP (1)
        @LastInvoiceNumber = LTRIM(RTRIM(c.NumeroFactura))
    FROM TblFacturas c
    ORDER BY c.IdFactura DESC;

    IF @LastInvoiceNumber IS NULL
    BEGIN
        SET @NextInvoiceNumber = '0001';
    END
    ELSE
    BEGIN
        SET @LastNumberInt = TRY_CAST(@LastInvoiceNumber AS INT);

        IF @LastNumberInt IS NULL
        BEGIN
            SET @NextInvoiceNumber = '0001';
        END
        ELSE
        BEGIN
            SET @NextInvoiceNumber = RIGHT('0000' + CAST(@LastNumberInt + 1 AS NVARCHAR(50)), 4);
        END
    END;

    SELECT @NextInvoiceNumber AS NextInvoiceNumber;
END;
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetProductById]    Script Date: 28/09/2025 10:15:27 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_GetProductById]
    @IdProducto INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.IdProducto,
        c.NombreProducto,
        c.Precio,
        c.Stock,
        c.Estado
    FROM CatProductos c
    WHERE c.Estado = 1
      AND c.IdProducto = @IdProducto;
END;
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetProducts]    Script Date: 28/09/2025 10:15:40 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[sp_GetProducts]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        c.IdProducto,
        c.NombreProducto,
        c.Precio,
        c.Stock,
        c.Estado,
        c.imageUrl
    FROM CatProductos c
    WHERE c.Estado = 1
END;
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[sp_SaveInvoice]    Script Date: 28/09/2025 10:15:54 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_SaveInvoice]
    @NumeroFactura NVARCHAR(50),
    @FechaFactura DATETIME,
    @IdCliente INT,
    @DetallesFactura NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @IdFactura INT;
        DECLARE @TotalFactura DECIMAL(18,2);

        -- Insertar en TblFacturas (total lo calculamos después)
        INSERT INTO TblFacturas (NumeroFactura, FechaFactura, TotalFactura, IdCliente)
        VALUES (@NumeroFactura, @FechaFactura, 0, @IdCliente);

        SET @IdFactura = SCOPE_IDENTITY();

        -- Insertar los detalles desde el JSON
        INSERT INTO TblDetalleFacturas (IdFactura, IdProducto, Cantidad, PrecioUnitario, Subtotal)
        SELECT 
            @IdFactura,
            IdProducto,
            Cantidad,
            PrecioUnitario,
            Cantidad * PrecioUnitario AS Subtotal
        FROM OPENJSON(@DetallesFactura)
        WITH (
            IdProducto INT '$.idProduct',
            Cantidad INT '$.Quantity',
            PrecioUnitario DECIMAL(18,2) '$.UnitPrice'
        );

        -- Actualizar el total de la factura
        SELECT @TotalFactura = SUM(Subtotal)
        FROM TblDetalleFacturas
        WHERE IdFactura = @IdFactura;

        SET @TotalFactura = @TotalFactura + (@TotalFactura * 0.19);

        UPDATE TblFacturas
        SET TotalFactura = @TotalFactura
        WHERE IdFactura = @IdFactura;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetInvoicesByClient]    Script Date: 28/09/2025 10:16:06 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   PROCEDURE [dbo].[usp_GetInvoicesByClient]
    @idClient INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        i.NumeroFactura,
        i.FechaFactura,
        i.TotalFactura,
        c.NombreCliente,
        c.ApellidoCliente
    FROM TblFacturas i
    INNER JOIN TblClientes c
    ON c.IdCliente = i.IdCliente
    WHERE i.IdCliente = @idClient
    ORDER BY i.FechaFactura DESC;
END
GO


USE [LabDevTest3Test3]
GO

/****** Object:  StoredProcedure [dbo].[usp_GetInvoicesByInvoiceNumber]    Script Date: 28/09/2025 10:16:17 p. m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_GetInvoicesByInvoiceNumber]
    @NumeroFactura varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        i.NumeroFactura,
        i.FechaFactura,
        i.TotalFactura,
        c.NombreCliente,
        c.ApellidoCliente
    FROM TblFacturas i
    INNER JOIN TblClientes c
    ON c.IdCliente = i.IdCliente
    WHERE i.NumeroFactura = @NumeroFactura
    ORDER BY i.FechaFactura DESC;
END
GO




