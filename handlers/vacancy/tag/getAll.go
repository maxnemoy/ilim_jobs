package tag

import (
	"github.com/maxnemoy/ilimjob_server/db/models"
	"net/http"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)


func GetAll(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		tag := &models.Tag{}
		tags, err := tag.GetAll(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, tags)
	}
}