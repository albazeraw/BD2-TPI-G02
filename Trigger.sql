USE BdMovieRaiting
GO
-- =============================================
-- TRIGGER de historial de reproducción para evitar duplicados diarios por usuario y película
-- =============================================

CREATE TRIGGER trg_HistorialReproduccion_NoDuplicadoDiario
ON HistorialReproduccion
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM HistorialReproduccion hr
        INNER JOIN inserted i
            ON hr.IDUsuario          = i.IDUsuario
            AND hr.IDPelicula        = i.IDPelicula
            AND hr.FechaReproduccion = i.FechaReproduccion
    )
    BEGIN
        RAISERROR('El usuario ya registró esta película en el historial para la fecha indicada.', 16, 1);
        RETURN;
    END

    INSERT INTO HistorialReproduccion (IDUsuario, IDPelicula, FechaReproduccion)
    SELECT IDUsuario, IDPelicula, FechaReproduccion
    FROM inserted;
END

GO
