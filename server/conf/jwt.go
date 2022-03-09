package conf

import "github.com/golang-jwt/jwt"

type JwtClaims struct {
	Username string `json:"username"`
	ID       int    `json:"id"`
	Type     int	`json:"type"`
	jwt.StandardClaims
}
