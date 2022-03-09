package user

import (
	"github.com/maxnemoy/ilimjob_server/db/models"
	"crypto/sha256"
	"encoding/base64"
	"net/http"
	"time"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func CreateUser(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		user := models.User{}
		if err := ctx.Bind(&user); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}
		user.CreateAt = time.Now()
		user.UpgradeAt = time.Now()
		user.Type = 1

		shaEncoder := sha256.New()
		shaEncoder.Write([]byte(user.Password))

		user.Password = base64.URLEncoding.EncodeToString(shaEncoder.Sum(nil))
		if err := user.CreateUser(conn); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}
		return ctx.JSON(http.StatusCreated, struct {
			Status string
		}{Status: "created"})
	}
}