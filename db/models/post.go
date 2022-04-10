package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Post struct {
	ID        int       `pg:"id,pk" json:"id"`
	CreateAt  time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt  time.Time `pg:"delete_at" json:"delete_at"`
	Published bool      `pg:"published" json:"published"`
	Title     string    `pg:"title" json:"title"`
	Body      string    `pg:"body" json:"body"`
	Cover     string    `pg:"cover" json:"cover"`
	Assets    []string  `pg:"assets,array" json:"assets"`
	Type      int8      `pg:"type,notnull" json:"type"`
}

func (post *Post) Create(conn *pg.DB) error {
	if _, err := conn.Model(post).Insert(post); err != nil {
		return err
	}
	return nil
}

func (p *Post) Upgrade(conn *pg.DB) error {
	p.UpgradeAt = time.Now()
	_, err := conn.Model(p).Where("id = ?0", p.ID).
		Set("published = ?0", p.Published).
		Set("title = ?0", p.Title).
		Set("body = ?0", p.Body).
		Set("cover = ?0", p.Cover).
		Set("assets = ?0", pg.Array(p.Assets)).
		Set("type = ?0", p.Type).
		Set("upgrade_at = ?0", p.UpgradeAt).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (p *Post) GetAll(conn *pg.DB) (*[]Post, error) {
	posts := &[]Post{}
	err := conn.Model(posts).Select()
	if err != nil {
		return nil, err
	}
	return posts, nil
}
