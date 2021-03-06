package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Vacancy struct {
	ID        int       `pg:"id,pk" json:"id"`
	CreateAt  time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt  time.Time `pg:"delete_at" json:"delete_at"`
	Published bool      `pg:"published" json:"published"`
	Title     string    `pg:"title" json:"title"`
	Body      string    `pg:"body" json:"body"`
	Author    int       `pg:"author" json:"author"`
	Tags      []int     `pg:"tags,array" json:"tags"`
	Category  int       `pg:"category" json:"category"`
	Views     int       `pg:"views" json:"views"`
}

func (v *Vacancy) Create(conn *pg.DB) error {
	if _, err := conn.Model(v).Insert(v); err != nil {
		return err
	}
	return nil
}

func (v *Vacancy) Upgrade(conn *pg.DB) error {
	v.UpgradeAt = time.Now()
	_, err := conn.Model(v).Where("id = ?0", v.ID).
		Set("published = ?0", v.Published).
		Set("title = ?0", v.Title).
		Set("body = ?0", v.Body).
		Set("author = ?0", v.Author).
		Set("tags = ?0", pg.Array(v.Tags)).
		Set("category = ?0", v.Category).
		Set("upgrade_at = ?0", v.UpgradeAt).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (v *Vacancy) AddViews(conn *pg.DB) error {
	v.UpgradeAt = time.Now()
	vacancy := &Vacancy{}
	err := conn.Model(vacancy).Where("id = ?0", v.ID).First()
	if err != nil {
		return err
	}

	_, err = conn.Model(v).Where("id = ?0", v.ID).
	Set("views = ?0", vacancy.Views+1).
	Update()

	return nil
}

func (v *Vacancy) GetAll(conn *pg.DB) (*[]Vacancy, error) {
	vacancies := &[]Vacancy{}
	err := conn.Model(vacancies).Select()
	if err != nil {
		return nil, err
	}
	return vacancies, nil
}
