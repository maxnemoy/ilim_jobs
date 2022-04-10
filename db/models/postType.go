package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type PostType struct {
	ID          int       `pg:"id,pk" json:"id"`
	CreateAt    time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt   time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt    time.Time `pg:"delete_at" json:"delete_at"`
	Type         string    `pg:"type" json:"type"`
	Description string    `pg:"description" json:"description"`
}

func (t *PostType) Create(conn *pg.DB) error {
	if _, err := conn.Model(t).Insert(t); err != nil {
		return err
	}
	return nil
}

func (t *PostType) Upgrade(conn *pg.DB) error {
	t.UpgradeAt = time.Now()
	_, err := conn.Model(t).Where("id = ?0", t.ID).
		Set("type = ?0", t.Type).
		Set("description = ?0", t.Description).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (t *PostType) GetAll(conn *pg.DB) (*[]PostType, error) {
	postType := &[]PostType{}
	err := conn.Model(postType).Select()
	if err != nil {
		return nil, err
	}
	return postType, nil
}
