package postType

import (
	"net/http"
	"time"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/golang-jwt/jwt"
	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
	"github.com/maxnemoy/ilimjob_server/conf"
)

func Update(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		postType := models.PostType{}
		if err := ctx.Bind(&postType); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		postType.CreateAt = time.Now()
		postType.UpgradeAt = time.Now()

		user := ctx.Get("user").(*jwt.Token)
    	claims := user.Claims.(*conf.JwtClaims)
		if(claims.Type > 1){
			if err := postType.Upgrade(conn); err != nil {
				return ctx.JSON(http.StatusBadRequest,
					struct{ Error string }{err.Error()})
			}
			return ctx.JSON(http.StatusAccepted, struct {
				Status string
			}{Status: "updated"})
		}

		return ctx.JSON(http.StatusForbidden, struct {
			Error string
		}{Error: "not enough rights"})		
	}
}