package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Vacancy struct {
	ID               int       `pg:"id,pk" json:"id"`
	CreateAt         time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt        time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt         time.Time `pg:"delete_at" json:"delete_at"`
	Published        bool      `pg:"published" json:"published"`
	Title            string    `pg:"title" json:"title"`
	Description      string    `pg:"description" json:"description"`
	Responsibilities string    `pg:"responsibilities" json:"responsibilities"`
	Requirements     string    `pg:"requirements" json:"requirements"`
	Terms            string    `pg:"terms" json:"terms"`
	Author           int       `pg:"author" json:"author"`
	Contacts         []string    `pg:"contacts" json:"contacts"`
	Tags             []int     `pg:"tags,array" json:"tags"`
	Category         int       `pg:"category" json:"category"`
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
		Set("description = ?0", v.Description).
		Set("responsibilities = ?0", v.Responsibilities).
		Set("requirements = ?0", v.Requirements).
		Set("terms = ?0", v.Terms).
		Set("author = ?0", v.Author).
		Set("contacts = ?0", pg.Array(v.Contacts)).
		Set("tags = ?0", pg.Array(v.Tags)).
		Set("category = ?0", v.Category).
		Set("upgrade_at = ?0", v.UpgradeAt).
		Update()
	if err != nil {
		return err
	}
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
