package conf

import "github.com/dgrijalva/jwt-go"

type JwtClaims struct {
	Username string `json:"username"`
	ID       int    `json:"id"`
	Type     int	`json:"type"`
	jwt.StandardClaims
}
