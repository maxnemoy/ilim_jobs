package securecheck

import (
	"net/http"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
)

func SecureCheck(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {
		
		return ctx.JSON(http.StatusCreated, struct {
			Response string
		}{Response: "checked"})
	}
}