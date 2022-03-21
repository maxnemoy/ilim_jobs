package resume

import (
	"github.com/maxnemoy/ilimjob_server/db/models"
	"net/http"

	"github.com/go-pg/pg/v10"
	"github.com/golang-jwt/jwt"
	"github.com/labstack/echo/v4"
	"github.com/maxnemoy/ilimjob_server/conf"
)

func GetAll(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		resume := &models.Resume{}

		user := ctx.Get("user").(*jwt.Token)
		claims := user.Claims.(*conf.JwtClaims)
		if claims.Type > 1 {
			Resumes, err := resume.GetAll(conn)
			if err != nil {
				return ctx.JSON(http.StatusBadRequest,
					struct{ Error string }{err.Error()})
			}
			return ctx.JSON(http.StatusOK, Resumes)

		}

		return ctx.JSON(http.StatusForbidden, struct {
			Error string
		}{Error: "not enough rights"})
	}
}
