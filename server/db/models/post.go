package models

import "time"

type Post struct {
	ID        int       `pg:"id,pk"`
	CreateAt  time.Time `pg:"create_at"`
	UpgradeAt time.Time `pg:"upgrade_at"`
	DeleteAt  time.Time `pg:"delete_at"`
	Published bool 		`pg:"published"`
	Title     string    `pg:"title"`
	Body      string    `pg:"body"`
	Cover     string    `pg:"cover"`
	Assets    []string  `pg:"assets"`
	Type      int8      `pg:"type,notnull"`
}
