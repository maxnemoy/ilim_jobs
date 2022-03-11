package models

type ImportModel struct{
	Categories []string `json:"categories"`
	Vacancies []Vacancy `json:"vacancies"`
}