package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Comment struct {
	ID       int        `pg:"id,pk" json:"id"`
	CreateAt time.Time  `pg:"create_at" json:"create_at"`
	DeleteAt *time.Time `pg:"delete_at" json:"delete_at"`
	Username string     `pg:"username" json:"username"`
	Avatar   string     `pg:"avatar" json:"avatar"`
	Body     string     `pg:"body" json:"body"`
}

func (b *Comment) Create(conn *pg.DB) error {
	if _, err := conn.Model(b).Insert(b); err != nil {
		return err
	}
	return nil
}

func (c *Comment) Upgrade(conn *pg.DB) error {
	_, err := conn.Model(c).Where("id = ?0", c.ID).
		Set("username = ?0", c.Username).
		Set("avatar = ?0", c.Avatar).
		Set("body = ?0", c.Body).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (c *Comment) Delete(conn *pg.DB) error {
	_, err := conn.Model(c).Where("id = ?0", c.ID).
		Set("delete_at = ?0", time.Now()).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (c *Comment) GetAll(conn *pg.DB) (*[]Comment, error) {
	comments := &[]Comment{}
	err := conn.Model(comments).
		Select()
	if err != nil {
		return nil, err
	}
	return comments, nil
}
