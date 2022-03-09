package user

import (
	"crypto/sha256"
	"encoding/base64"
	"github.com/maxnemoy/ilimjob_server/conf"
	"github.com/maxnemoy/ilimjob_server/db/models"
	"net/http"
	"os"
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

//AuthUser - auth user
func AuthUser(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		user := models.User{}
		if err := ctx.Bind(&user); err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{"binding error"})
		}

		shaEncoder := sha256.New()
		shaEncoder.Write([]byte(user.Password))
		user.Password = base64.URLEncoding.EncodeToString(shaEncoder.Sum(nil))

		usr, err := user.GetUser(conn)
		if err != nil {
			return ctx.JSON(http.StatusBadRequest,
				struct{ Error string }{err.Error()})
		}

		claims := &conf.JwtClaims{
			Username:       usr.Username,
			ID:             usr.ID,
			Type:           int(usr.Type),
			StandardClaims: jwt.StandardClaims{ExpiresAt: time.Now().Add(time.Hour * 72).Unix()},
		}

		token := jwt.NewWithClaims(jwt.SigningMethodHS256, claims)
		t, err := token.SignedString([]byte(os.Getenv("JWT")))

		if err != nil {
			return echo.ErrUnauthorized
		}

		return ctx.JSON(http.StatusOK, struct {
			Token string
		}{Token: t})
	}
}
