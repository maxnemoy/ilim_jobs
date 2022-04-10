package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Category struct {
	ID          int       `pg:"id,pk" json:"id"`
	CreateAt    time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt   time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt    time.Time `pg:"delete_at" json:"delete_at"`
	Category    string    `pg:"category" json:"category"`
	Description string    `pg:"description" json:"description"`
}

func (c *Category) Create(conn *pg.DB) error {
	if _, err := conn.Model(c).Insert(c); err != nil {
		return err
	}
	return nil
}

func (c *Category) Upgrade(conn *pg.DB) error {
	c.UpgradeAt = time.Now()
	_, err := conn.Model(c).Where("id = ?0", c.ID).
		Set("category = ?0", c.Category).
		Set("description = ?0", c.Description).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (c *Category) GetAll(conn *pg.DB) (*[]Category, error) {
	categories := &[]Category{}
	err := conn.Model(categories).Select()
	if err != nil {
		return nil, err
	}
	return categories, nil
}
