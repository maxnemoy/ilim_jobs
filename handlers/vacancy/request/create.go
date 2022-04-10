package request

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
		req := models.Request{}
		if err := ctx.Bind(&req); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		req.CreateAt = time.Now()
		req.Status = 1

		user := ctx.Get("user").(*jwt.Token)
    	claims := user.Claims.(*conf.JwtClaims)
		if(claims.ID == req.UserId){
		if err := req.Create(conn); err != nil {
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