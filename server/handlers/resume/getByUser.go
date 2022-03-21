package resume

import (
	"net/http"
	"strconv"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/golang-jwt/jwt"
	"github.com/labstack/echo/v4"
	"github.com/maxnemoy/ilimjob_server/conf"
)

func GetByUser(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		resume := &models.Resume{}
		
		userId := ctx.Param("id")
		id, err := strconv.Atoi(userId)
			if err != nil {
				ctx.JSON(http.StatusBadRequest, struct {
					Error string
				}{Error: "invalid user id"})
			}
		resume.UserId = id
		user := ctx.Get("user").(*jwt.Token)
		claims := user.Claims.(*conf.JwtClaims)
		if claims.Type > 1 || resume.UserId == claims.ID {
			Resumes, err := resume.GetByUserId(conn)
			if err != nil {
				return ctx.JSON(http.StatusBadRequest,
					struct{ Error string }{err.Error()})
			}
			if len(*Resumes) > 0{
				return ctx.JSON(http.StatusOK, (*Resumes)[0])
			} else{
				return ctx.JSON(http.StatusBadRequest,
					struct{ Error string }{ Error: "resume not found"})
			}

		}

		return ctx.JSON(http.StatusForbidden, struct {
			Error string
		}{Error: "not enough rights"})
	}
}