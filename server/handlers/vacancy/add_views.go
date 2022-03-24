package vacancy

import (
	"net/http"
	"strconv"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func AddViews(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		v := &models.Vacancy{}

		vacancyID := ctx.Param("id")
		id, err := strconv.Atoi(vacancyID)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, struct {
				Error string
			}{Error: "invalid user id"})
		}
		v.ID = id

		err = v.AddViews(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, struct{ Status string }{"ok"})
	}
}