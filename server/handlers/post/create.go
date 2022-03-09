package post

import (
	"net/http"
	"time"

	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/golang-jwt/jwt"
	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
	"github.com/maxnemoy/ilimjob_server/conf"
)

func Create(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		post := models.Post{}
		if err := ctx.Bind(&post); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		post.CreateAt = time.Now()
		post.UpgradeAt = time.Now()

		user := ctx.Get("user").(*jwt.Token)
    	claims := user.Claims.(*conf.JwtClaims)
		if(claims.Type > 1){
		if err := post.Create(conn); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
			}
			return ctx.JSON(http.StatusCreated, struct {
				Status string
			}{Status: "created"})
		}

		return ctx.JSON(http.StatusForbidden, struct {
			Error string
		}{Error: "not enough rights"})		
	}
}