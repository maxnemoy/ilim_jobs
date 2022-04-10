package bookmark

import (
	"net/http"
	"strconv"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func GetByUser(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		bookmark := &models.Bookmark{}

		userId := ctx.Param("id")
		id, err := strconv.Atoi(userId)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, struct {
				Error string
			}{Error: "invalid user id"})
		}
		bookmark.UserId = id

		bookmarks, err := bookmark.GetAllByUser(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, bookmarks)
	}
}
