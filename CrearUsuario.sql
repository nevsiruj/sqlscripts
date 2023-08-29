-- Declarar variables
DECLARE @LoginName NVARCHAR(50) = 'usrTest';
DECLARE @Password NVARCHAR(50) = 'Negotis1234';
DECLARE @DBName NVARCHAR(50) = 'NegotisUAT';

-- Crear el inicio de sesión en el servidor
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = @LoginName)
BEGIN
    EXEC ('CREATE LOGIN [' + @LoginName + '] WITH PASSWORD = ''' + @Password + ''';');
END

-- Cambiar a la base de datos especificada y crear el usuario
USE [NegotisUAT];
GO

DECLARE @LoginName NVARCHAR(50) = 'usrTest';
DECLARE @Password NVARCHAR(50) = 'Negotis1234';
DECLARE @DBName NVARCHAR(50) = 'NegotisUAT';

-- Verificar si el usuario ya existe; si no, crearlo
IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = @LoginName)
BEGIN
    EXEC ('CREATE USER [' + @LoginName + '] FOR LOGIN [' + @LoginName + '];');
END

-- Asignar roles db_datareader y db_datawriter al nuevo usuario
EXEC sp_addrolemember 'db_datareader', @LoginName;
EXEC sp_addrolemember 'db_datawriter', @LoginName;
GO
