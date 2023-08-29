-- Tablas que están en Negotis pero no en NegotisUAT
SELECT 
    'Table Missing in NegotisUAT' AS 'Difference', 
    TABLE_SCHEMA + '.' + TABLE_NAME AS 'TableName'
FROM 
    Negotis.INFORMATION_SCHEMA.TABLES 
WHERE 
    TABLE_NAME + TABLE_SCHEMA NOT IN 
    (SELECT TABLE_NAME + TABLE_SCHEMA FROM NegotisUAT.INFORMATION_SCHEMA.TABLES);

-- Tablas que están en NegotisUAT pero no en Negotis
SELECT 
    'Table Missing in Negotis' AS 'Difference', 
    TABLE_SCHEMA + '.' + TABLE_NAME AS 'TableName'
FROM 
    NegotisUAT.INFORMATION_SCHEMA.TABLES 
WHERE 
    TABLE_NAME + TABLE_SCHEMA NOT IN 
    (SELECT TABLE_NAME + TABLE_SCHEMA FROM Negotis.INFORMATION_SCHEMA.TABLES);

-- Columnas que están en Negotis pero no en NegotisUAT
SELECT 
    'Column Missing in NegotisUAT' AS 'Difference',
    a.TABLE_SCHEMA + '.' + a.TABLE_NAME AS 'TableName', 
    a.COLUMN_NAME,
    a.DATA_TYPE AS 'DataType',
    a.IS_NULLABLE AS 'IsNullable',
    'ALTER TABLE ' + a.TABLE_SCHEMA + '.' + a.TABLE_NAME + ' ADD ' + a.COLUMN_NAME + ' ' + a.DATA_TYPE + 
    CASE WHEN a.CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN '(' + CAST(a.CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')' ELSE '' END + 
    CASE WHEN a.IS_NULLABLE = 'YES' THEN ' NULL' ELSE ' NOT NULL' END AS 'AddColumnSQL'
FROM 
    Negotis.INFORMATION_SCHEMA.COLUMNS a
WHERE 
    a.TABLE_NAME + a.COLUMN_NAME NOT IN 
    (SELECT TABLE_NAME + COLUMN_NAME FROM NegotisUAT.INFORMATION_SCHEMA.COLUMNS);

-- Columnas que están en NegotisUAT pero no en Negotis
SELECT 
    'Column Missing in Negotis' AS 'Difference',
    b.TABLE_SCHEMA + '.' + b.TABLE_NAME AS 'TableName', 
    b.COLUMN_NAME,
    b.DATA_TYPE AS 'DataType',
    b.IS_NULLABLE AS 'IsNullable',
    'ALTER TABLE ' + b.TABLE_SCHEMA + '.' + b.TABLE_NAME + ' ADD ' + b.COLUMN_NAME + ' ' + b.DATA_TYPE + 
    CASE WHEN b.CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN '(' + CAST(b.CHARACTER_MAXIMUM_LENGTH AS VARCHAR) + ')' ELSE '' END + 
    CASE WHEN b.IS_NULLABLE = 'YES' THEN ' NULL' ELSE ' NOT NULL' END AS 'AddColumnSQL'
FROM 
    NegotisUAT.INFORMATION_SCHEMA.COLUMNS b
WHERE 
    b.TABLE_NAME + b.COLUMN_NAME NOT IN 
    (SELECT TABLE_NAME + COLUMN_NAME FROM Negotis.INFORMATION_SCHEMA.COLUMNS);

