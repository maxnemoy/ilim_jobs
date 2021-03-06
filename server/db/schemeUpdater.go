package db

import (
	"github.com/maxnemoy/ilimjob_server/db/models"

	"github.com/go-pg/pg/v10"
	"github.com/go-pg/pg/v10/orm"
)

func createSchema(db *pg.DB) error {
	for _, model := range []interface{}{
		(*models.User)(nil),
		(*models.Post)(nil),
		(*models.Vacancy)(nil),
		(*models.Tag)(nil),
		(*models.Category)(nil),
		(*models.PostType)(nil),
		(*models.Resume)(nil),
		(*models.Bookmark)(nil),
		(*models.Request)(nil),
		(*models.Comment)(nil),
	} {
		err := db.Model(model).CreateTable(&orm.CreateTableOptions{IfNotExists: true})
		if err != nil {
			return err
		}
	}
	return nil
}