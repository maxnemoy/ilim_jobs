package importer

import (
	"net/http"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func Import(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		importData := models.ImportModel{}
		if err := ctx.Bind(&importData); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		

		return ctx.JSON(http.StatusOK, importData)		
	}
}