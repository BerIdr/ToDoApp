package models

import (
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"
)

// TodoModel represents the MongoDB document structure
type TodoModel struct {
	ID        primitive.ObjectID `bson:"_id,omitempty"`
	Title     string             `bson:"title"`
	Completed bool               `bson:"completed"`
	CreatedAt time.Time          `bson:"createAt"`
}

// Todo represents the API response structure
type Todo struct {
	ID        string    `json:"id"`
	Title     string    `json:"title"`
	Completed bool      `json:"completed"`
	CreatedAt time.Time `json:"created_at"`
}
