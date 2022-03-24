package request

import (
	"net/http"
	"time"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func Update(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		req := models.Request{}
		if err := ctx.Bind(&req); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		req.CreateAt = time.Now()
		req.UpgradeAt = time.Now()

		if err := req.Update(conn); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusAccepted, struct {
			Status string
		}{Status: "updated"})

	}
}
