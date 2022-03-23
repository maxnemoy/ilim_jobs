package bookmark

import (
	"net/http"
	"time"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/golang-jwt/jwt"
	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
	"github.com/maxnemoy/ilimjob_server/conf"
)

func Delete(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		bookmark := models.Bookmark{}
		if err := ctx.Bind(&bookmark); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		bookmark.DeleteAt = time.Now()

		user := ctx.Get("user").(*jwt.Token)
    	claims := user.Claims.(*conf.JwtClaims)
		if(claims.ID == bookmark.UserId){
			if err := bookmark.Delete(conn); err != nil {
				return ctx.JSON(http.StatusBadRequest,
					struct{ Error string }{err.Error()})
			}
			return ctx.JSON(http.StatusAccepted, struct {
				Status string
			}{Status: "deleted"})
		}

		return ctx.JSON(http.StatusForbidden, struct {
			Error string
		}{Error: "not enough rights"})		
	}
}