package bookmark

import (
	"github.com/maxnemoy/ilimjob_server/db/models"
	"net/http"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)


func GetAll(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		bookmark := &models.Bookmark{}
		bookmarks, err := bookmark.GetAll(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, bookmarks)
	}
}