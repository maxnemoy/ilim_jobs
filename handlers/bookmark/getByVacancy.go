package bookmark

import (
	"net/http"
	"strconv"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func GetByVacancy(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		bookmark := &models.Bookmark{}

		vacancyId := ctx.Param("id")
		id, err := strconv.Atoi(vacancyId)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, struct {
				Error string
			}{Error: "invalid vacancy id"})
		}
		bookmark.VacancyId = id

		bookmarks, err := bookmark.GetAllByVacancy(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, bookmarks)
	}
}
