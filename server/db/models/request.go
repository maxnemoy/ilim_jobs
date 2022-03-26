package models

import (
	"github.com/go-pg/pg/v10"
	"time"
)

type Request struct {
	ID        int        `pg:"id,pk" json:"id"`
	CreateAt  time.Time  `pg:"create_at" json:"create_at"`
	UpgradeAt  time.Time  `pg:"upgrade_at" json:"upgrade_at"`
	DeleteAt  *time.Time `pg:"delete_at" json:"delete_at"`
	UserId    int        `pg:"user_id" json:"user_id"`
	VacancyId int        `pg:"vacancy_id" json:"vacancy_id"`
	Status    int        `pg:"status" json:"status"`
}

func (r *Request) Create(conn *pg.DB) error {
	if _, err := conn.Model(r).Insert(r); err != nil {
		return err
	}
	return nil
}

func (r *Request) Update(conn *pg.DB) error {
	//*r.DeleteAt = time.Now()
	r.UpgradeAt = time.Now()
	_, err := conn.Model(r).Where("id = ?0", r.ID).
		Set("upgrade_at = ?0", r.DeleteAt).
		Set("status = ?0", r.Status).
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (b *Request) GetAll(conn *pg.DB) (*[]Request, error) {
	Requests := &[]Request{}
	err := conn.Model(Requests).
		Select()
	if err != nil {
		return nil, err
	}
	return Requests, nil
}

func (b *Request) GetAllByUser(conn *pg.DB) (*[]Request, error) {
	requests := &[]Request{}
	err := conn.Model(requests).
		Where("user_id = ?0", b.UserId).Select()
	if err != nil {
		return nil, err
	}
	return requests, nil
}

func (b *Request) GetAllByVacancy(conn *pg.DB) (*[]Request, error) {
	requests := &[]Request{}
	err := conn.Model(requests).
		Where("vacancy_id = ?0", b.VacancyId).Select()
	if err != nil {
		return nil, err
	}
	return requests, nil
}
