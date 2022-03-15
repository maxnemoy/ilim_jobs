package main

import (
	"flag"
	"github.com/maxnemoy/ilimjob_server/conf"
	"github.com/maxnemoy/ilimjob_server/db"
	"github.com/maxnemoy/ilimjob_server/handlers/importer"
	"github.com/maxnemoy/ilimjob_server/handlers/post"
	"github.com/maxnemoy/ilimjob_server/handlers/post/postType"
	"github.com/maxnemoy/ilimjob_server/handlers/secureCheck"
	"github.com/maxnemoy/ilimjob_server/handlers/upload"
	"github.com/maxnemoy/ilimjob_server/handlers/user"
	"github.com/maxnemoy/ilimjob_server/handlers/vacancy"
	"github.com/maxnemoy/ilimjob_server/handlers/vacancy/category"
	"github.com/maxnemoy/ilimjob_server/handlers/vacancy/tag"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	port := os.Getenv("PORT")

	if port == "" {
		port = *flag.String("port", "6001", "server port")
	}

	err := godotenv.Load("./.env")

	if err != nil {
		log.Fatal("Error loading .env file")
	}

	flag.Parse()
	conn := db.Connect()
	apiPublic := echo.New()

	apiPublic.Use(middleware.CORSWithConfig(middleware.CORSConfig{
		AllowMethods: []string{http.MethodGet, http.MethodPut, http.MethodPost, http.MethodDelete},
	}))
	
	apiPublic.Use(middleware.StaticWithConfig(middleware.StaticConfig{
		Root:   "./static",
		Browse: true,
	}))

	apiPublic.Use(middleware.Logger())
	apiPublic.Use(middleware.Recover())

	// Routes
	apiPublic.GET("/", root)
	apiPublic.Static("/static", "./static/")
	apiPublic.POST("/import", importer.Import(conn))
	apiPublic.POST("/user", user.AuthUser(conn))
	apiPublic.PUT("/user", user.CreateUser(conn))

	apiPublic.GET("/posts", post.GetAll(conn))
	apiPublic.GET("/post/types", postType.GetAll(conn))

	apiPublic.GET("/vacancies", vacancy.GetAll(conn))
	apiPublic.GET("/vacancy/tags", tag.GetAll(conn))
	apiPublic.GET("/vacancy/categories", category.GetAll(conn))

	privateZone := apiPublic.Group("/v1")
	conf := middleware.JWTConfig{
		Claims:     &conf.JwtClaims{},
		SigningKey: []byte(os.Getenv("JWT")),
	}
	privateZone.Use(middleware.JWTWithConfig(conf))
	privateZone.GET("/secure", securecheck.SecureCheck(conn))
	privateZone.GET("/users", root)

	privateZone.PUT("/post", post.Create(conn))
	privateZone.PATCH("/post", post.Update(conn))
	privateZone.PUT("/post/type", postType.Create(conn))
	privateZone.PATCH("/post/type", postType.Update(conn))

	privateZone.PUT("/vacancy", vacancy.Create(conn))
	privateZone.PATCH("/vacancy", vacancy.Update(conn))
	privateZone.PUT("/vacancy/tag", tag.Create(conn))
	privateZone.PATCH("/vacancy/tag", tag.Update(conn))
	privateZone.PUT("/vacancy/category", category.Create(conn))
	privateZone.PATCH("/vacancy/category", category.Update(conn))

	privateZone.POST("/upload", upload.Upload(conn))
	apiPublic.Logger.Fatal(apiPublic.Start(":" + port))
}

func root(c echo.Context) error {
	return c.String(http.StatusOK, "ilim_jobs")
}
