package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Resume struct {
	ID          int       `pg:"id,pk" json:"id"`
	CreateAt    time.Time `pg:"create_at" json:"create_at"`
	UpgradeAt   time.Time `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt    time.Time `pg:"delete_at" json:"delete_at"`
	UserId      int       `pg:"user_id" json:"user_id"`
	FirstName   string    `pg:"first_name" json:"first_name"`
	LastName    string    `pg:"last_name" json:"last_name"`
	Phone       string    `pg:"phone" json:"phone"`
	City        string    `pg:"city" json:"city"`
	Citizenship string    `pg:"citizenship" json:"citizenship"`
	BirthDay    time.Time `pg:"birthday" json:"birthday"`
	Gender      string    `pg:"gender" json:"gender"`
	Education   []string  `pg:"education,array" json:"education"`
	Categories  []string  `pg:"categories,array" json:"categories"`
	Works       []string  `pg:"works,array" json:"works"`
	ResumeLink  string    `pg:"resume_link" json:"resume_link"`
	Assets      []string  `pg:"assets,array" json:"assets"`
	About       string    `pg:"about" json:"about"`
}

func (c *Resume) Create(conn *pg.DB) error {
	if _, err := conn.Model(c).Insert(c); err != nil {
		return err
	}
	return nil
}

func (c *Resume) Upgrade(conn *pg.DB) error {
	c.UpgradeAt = time.Now()
	_, err := conn.Model(c).Where("id = ?0", c.ID).
		Set("upgrade_at = ?0", c.UpgradeAt).
		Set("user_id = ?0", c.UserId).
		Set("first_name = ?0", c.FirstName).
		Set("last_name = ?0", c.LastName).
		Set("phone = ?0", c.Phone).
		Set("city = ?0", c.City).
		Set("citizenship = ?0", c.Citizenship).
		Set("birthday = ?0", c.BirthDay).
		Set("gender = ?0", c.Gender).
		Set("education = ?0", pg.Array(c.Education)).
		Set("categories = ?0", pg.Array(c.Categories)).
		Set("works = ?0", pg.Array(c.Works)).
		Set("resume_link = ?0", c.ResumeLink).
		Set("assets = ?0", pg.Array(c.Assets)).
		Set("about = ?0", c.About).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (c *Resume) GetAll(conn *pg.DB) (*[]Resume, error) {
	resumes := &[]Resume{}
	err := conn.Model(resumes).Select()
	if err != nil {
		return nil, err
	}
	return resumes, nil
}

func (c *Resume) GetByUserId(conn *pg.DB) (*[]Resume, error) {
	resumes := &[]Resume{}
	err := conn.Model(resumes).Where("user_id = ?0", c.UserId).Select()
	if err != nil {
		return nil, err
	}
	return resumes, nil
}
