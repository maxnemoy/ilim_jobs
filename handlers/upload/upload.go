package upload

import (
	"io"
	"net/http"
	"os"

	"github.com/go-pg/pg/v10"
	"github.com/labstack/echo/v4"
	uuid "github.com/satori/go.uuid"
)

func Upload(conn *pg.DB) func(ctx echo.Context) error {
	return func(ctx echo.Context) error {

		extension := ctx.FormValue("extension")


		file, err := ctx.FormFile("file")
		if err != nil {
			print(err.Error())
			return err
		}
		src, err := file.Open()
		if err != nil {
			return err
		}
		defer src.Close()
		
		var errors error
		uuid := uuid.Must(uuid.NewV4(), errors).String()
		
		dst, err := os.Create(os.Getenv("STATIC_FOLDER") + "/" + uuid + "." + extension)
		if err != nil {
			print("path")
			return err
		}
		defer dst.Close()

		if _, err = io.Copy(dst, src); err != nil {
			return err
		}
	
		return ctx.JSON(http.StatusOK, struct {
			Path string
		}{Path: (os.Getenv("BASE_URL") + "/static/" + uuid + "." + extension)})
	}
}