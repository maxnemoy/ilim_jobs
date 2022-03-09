package models

import (
	"time"

	"github.com/go-pg/pg/v10"
)

type User struct {
	ID             int       `pg:"id,pk"`
	CreateAt       time.Time `pg:"create_at"`
	UpgradeAt      time.Time `pg:"upgrade_at"`
	DeleteAt       time.Time `pg:"delete_at"`
	Username       string    `pg:"username,unique"`
	Password       string    `pg:"password"`
	FirstName      string    `pg:"first_name" json:"first_name"`
	LastName       string    `pg:"last_name" json:"last_name"`
	MiddleName     string    `pg:"middle_name" json:"middle_name"`
	Type           int8      `pg:"type,notnull"`
}

func (usr *User) CreateUser(conn *pg.DB) error {
	if _, err := conn.Model(usr).Insert(usr); err != nil {
		return err
	}
	return nil
}

func (usr *User) GetUser(conn *pg.DB) (*User, error) {
	user := &User{}
	err := conn.Model(user).
		Where("username = ?0", usr.Username).
		Where("password = ?0", usr.Password).
		Select()
	if err != nil {
		return nil, err
	}
	return user, nil
}

//Upgrade func
func (usr User) Upgrade(conn *pg.DB) error {
	usr.UpgradeAt = time.Now()
	_, err := conn.Model(&usr).Where("id = ?0", usr.ID).
		Set("upgrade_at = ?upgrade_at").
		Set("username = ?username").
		Set("first_name = ?first_name").
		Set("last_name = ?last_name").
		Set("middle_name = ?middle_name").
		Set("type = ?type").
		Set("department_uuid = ?department_uuid").
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (usr User) UpgradePassword(conn *pg.DB) error {
	usr.UpgradeAt = time.Now()
	_, err := conn.Model(&usr).Where("uuid = ?0", usr.ID).
		Set("upgrade_at = ?upgrade_at").
		Set("password = ?password").
		Update()
	if err != nil {
		return err
	}
	return nil
}

func (usr User) GetAll(conn *pg.DB) (*[]User, error) {
	users := &[]User{}
	err := conn.Model(users).Select()
	if err != nil {
		return nil, err
	}
	return users, nil
}