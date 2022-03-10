package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Tag struct {
	ID          int       `pg:"id,pk" json:"id"`
	CreateAt    time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt   time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt    time.Time `pg:"delete_at" json:"delete_at"`
	Published   bool      `pg:"published" json:"published"`
	Tag         string    `pg:"tag" json:"tag"`
	Description string    `pg:"description" json:"description"`
}

func (t *Tag) Create(conn *pg.DB) error {
	if _, err := conn.Model(t).Insert(t); err != nil {
		return err
	}
	return nil
}

func (t *Tag) Upgrade(conn *pg.DB) error {
	t.UpgradeAt = time.Now()
	_, err := conn.Model(t).Where("id = ?0", t.ID).
		Set("tag = ?0", t.Tag).
		Set("description = ?0", t.Description).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (t *Tag) GetAll(conn *pg.DB) (*[]Tag, error) {
	tags := &[]Tag{}
	err := conn.Model(tags).Select()
	if err != nil {
		return nil, err
	}
	return tags, nil
}
