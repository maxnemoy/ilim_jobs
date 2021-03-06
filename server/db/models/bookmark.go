package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Bookmark struct {
	ID          int       `pg:"id,pk" json:"id"`
	CreateAt    time.Time `pg:"create_at" json:"create_at"`
	DeleteAt    *time.Time `pg:"delete_at" json:"delete_at"`
	UserId    int    `pg:"user_id" json:"user_id"`
	VacancyId int    `pg:"vacancy_id" json:"vacancy_id"`
}

func (b *Bookmark) Create(conn *pg.DB) error {
	if _, err := conn.Model(b).Insert(b); err != nil {
		return err
	}
	return nil
}

func (b *Bookmark) Delete(conn *pg.DB) error {
	_, err := conn.Model(b).Where("id = ?0", b.ID).
		Set("delete_at = ?0", time.Now()).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (b *Bookmark) GetAll(conn *pg.DB) (*[]Bookmark, error) {
	bookmarks := &[]Bookmark{}
	err := conn.Model(bookmarks).
	Select()
	if err != nil {
		return nil, err
	}
	return bookmarks, nil
}

func (b *Bookmark) GetAllByUser(conn *pg.DB) (*[]Bookmark, error) {
	bookmarks := &[]Bookmark{}
	err := conn.Model(bookmarks).
	Where("user_id = ?0", b.UserId).Select()
	if err != nil {
		return nil, err
	}
	return bookmarks, nil
}

func (b *Bookmark) GetAllByVacancy(conn *pg.DB) (*[]Bookmark, error) {
	bookmarks := &[]Bookmark{}
	err := conn.Model(bookmarks).
	Where("vacancy_id = ?0", b.VacancyId).Select()
	if err != nil {
		return nil, err
	}
	return bookmarks, nil
}
