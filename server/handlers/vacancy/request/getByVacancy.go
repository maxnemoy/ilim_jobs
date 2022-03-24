package request

import (
	"net/http"
	"strconv"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func GetByVacancy(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		req := &models.Request{}

		vacancyId := ctx.Param("id")
		id, err := strconv.Atoi(vacancyId)
		if err != nil {
			ctx.JSON(http.StatusBadRequest, struct {
				Error string
			}{Error: "invalid vacancy id"})
		}
		req.VacancyId = id

		requests, err := req.GetAllByVacancy(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusOK, requests)
	}
}
